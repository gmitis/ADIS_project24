## Project Description
tba

## Test Presto with databases:

Added this lines of code inside mongo_init.sh after db launch to create a user inside the adis database of mongo before importing data

```bash
docker system prune -f && sudo docker-compose up cassandra cassandra-load-keyspace mongo postgres presto-coordinator presto-worker1 presto-worker2
docker exec -it presto-coordinator bash

# for testing postgres
./opt/presto-cli --server localhost:8080 --catalog postgresql --schema public --execute 'select count(*) from web_page;' 

# for testing cassandra
./opt/presto-cli --server localhost:8080 --catalog cassandra --schema adis --execute 'select * from  web_page limit 10;'

# for testing mongodb
./opt/presto-cli --server localhost:8080 --catalog mongodb --schema adis --execute 'select * from  income_band limit 10;'
```

## Produce scripts to populate DBs:

Step 1: Copy created tpc-ds dataset into ~/ADIS_project24/data/original_data directory
```bash
mv tpcds_data_directory/* ~/ADIS_project24/data/original_data
```

Step 2: Clean data and convert to csv by running
```bash
cd ~/ADIS_project24
chmod +x ~/ADIS_project24/utils/*

# also creates a catalog.txt into ~/ADIS_project24 that contains the names of all the tables
./utils/make_csv.sh ~/ADIS_project24/data/original_data     # create the csv data from scratch with original .dat files
scp -r ubuntu@snf-77013.ok-kno.grnetcloud.net:~/ADIS_project24/data ~/ADIS_project24/data   # or copy it from the already generated csv dataset

# generates sql interpretation into single file of a single talbes of tpcds.sql
./utils/generate_table_scripts/postgresql_population_scripts.sh

# create actual population file that docker is going to initialize the database with 
# see name of tables in ~/ADIS_project24/data/tables_catalog.txt 
# with "*" you include all of the tables
./utils/population_script_generate/postgresql_generate.sh table_name1 table_name2 ... | all
```

Step 3: Now run the postgres container and it will be populated automatically
```bash
# docker-compose down -v is necessarry to remove any volumes or containers that has outdated configuration/format
cd ~/ADIS_project24 && \
docker-compose down -v && \
docker-compose up -d --build --force-recreate postgres
```

## DOCKER SWARM SETUP:
```bash

#First set up passwordless ssh connection to nestedVM

#Establish reverse SSH tunnel to nestedVM

ssh -f -N -R 2377:localhost:2377 ubuntu@snf-77020

#Make It Persistent at Startup

crontab -e 
#and then add the following: 
@reboot ssh -f -N -R 2377:localhost:2377 ubuntu@snf-77020

#Now if the initialVM is up then it is connected to the nestedVM through this tunnel 

#Secondly we initialize the Docker Swarm

docker swarm init --advertise-addr <initial_vm_ip>

#now the docker swarm is created and the manager node is the initialVM

#now use this command to get the worker join token

docker swarm join-token worker

#after you get the token use this command on the nestedVM

docker swarm join --token <worker-token> localhost:2377

#After both of the nodes are connected apply labels to each

docker node update --label-add role=initial snf-77016
docker node update --label-add role=nested snf-77020

#Thirdly initialize the overlay network called presto-network on the initialVM

docker network create --driver overlay --attachable presto-network

#Now you must modify docker-compose.yaml as such:
#you add this after every container except cassandra keyspace so that they automatically restart if failed and to run on specific machines.

    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
      placement:
        constraints:
          - node.labels.role == initial
          #here the role is either initial or nested based on where you want to run what
    networks:
      - presto-network

#for cassandra keyspace add this 

    deploy:                   
      placement:
        constraints:
          - node.labels.role == initial
    networks:
      - presto-network

#Also at the end of docker-compose.yaml specify the overlay network used

    networks:
    presto-network:
        external: true

#Also change to every catalog file 

cassandra.contact-points= cassandra
mongodb.seeds=mongo:27017
connection-url=jdbc:postgresql://postgres:5432/adis

#Also change the discovery uri of coordinator and every worker you have on the same VM to this 

discovery.uri=http://presto-coordinator:8080

#for workers on the nested VM so far I have changed their discovery uri to this 

discovery.uri=http://localhost:2377

#and added this to their docker-compose.yaml containers

    extra_hosts:
      - "presto-coordinator:127.0.0.1"

#Finally to check the docker swarm nodes health use this

docker node ls

#this command checks the services used in docker

docker service ls

#this command shows the networks used in docker

docker network ls

#this command starts the stack of containers from the initialVM

docker stack deploy -c docker-compose.yaml presto-cluster

#it starts all the containers together and shares them across all nodes (machines) and checks to run each container on the corresponding machine.

#check logs of a service

docker service logs <service-name>

#restart a service 

docker service update --force <service-name>
docker service ps --no-trunc <service-name>     # more verborse error printing

#to restart the stack 

docker stack rm cluster && docker stack deploy -c docker-compose.yaml cluster

#auta exw kanei mexri twra. Ante na ta kanoume na milane twra
```

so far:
works ->cassandra, postgres, presto-worker1 
doesn't work -> mongo
