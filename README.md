<!-- TASK: fill read more link-->

# PrestoDB benchmarks with heterogenous datasources (PostgreSQL, Cassandra, MongoDB)
<!-- [![Awesome](https://awesome.re/badge.svg)](https://awesome.re) -->
<!-- [![GitHub contributors](https://img.shields.io/github/contributors/coderjojo/creative-profile-readme)](https://github.com/coderjojo/creative-profile-readme/graphs/contributors) -->
<br>


## Table of Contents
- [Project Description](#project-description)
- [System Description](#system-description)
- [System Deployment](#system-deployment)
- [Usage](#usage)
- [Tools Used](#tools-used)
- [Contributors](#contributors)
- [Licence](#license)

<br><br>


## Project Description
> This paper benchmarks the performance of the
distributed SQL query engine PrestoDB when connected to three heterogeneous data sources: MongoDB, Cassandra, and PostgreSQL. The study examines the effectiveness of the query engine across varying data distribution strategies, worker configurations, and query complexities. Using the TPC-DS benchmark for data and query generation, we conduct experiments on a subset of queries to analyze and enhance query latency, bandwidth, and memory utilization. The findings culminate in a proposed optimization strategy that considers the entity-relationship model, query performance, and the unique characteristics of the underlying storage technologies
[read more]()

<br><br>


## System Description 
This is an indicative configuration used for our experiment with 1 coordinator, 3 workers, PostgreSQL, Cassandra and MongoDB. More experiments with different data distributions across the datasources and number of workers have been done.

| VM       | Cores |          CPU type     | System RAM | Disk Size | Disk Type     | Role                | Additional processes | Cluster Nodes (Docker Swarm) |
|:--------:|:-----:|:---------------------:|:----------:|:---------:|:-------------:|:-------------------:|:--------------------:|:----------------------------:|
| adis1    | 4     | Intel Xeon E5-2650 v3 |8 GB        | 30 GB     |HDD            | coordinator         |         -            |  manager                     |
| adis2    | 4     | Intel Xeon E5-2650 v3 |8 GB        | 30 GB     |HDD            | worker1             | MongoDB              |  worker                      |
| adis3    | 4     | Intel Xeon E5-2650 v3 |8 GB        | 30 GB     |HDD            | worker2             | Cassandra            |  worker                      |
| adis4    | 4     | Intel Xeon E5-2650 v3 |8 GB        | 30 GB     |HDD            | worker3             | PostgreSQL           |  worker                      |

<br><br>


## System Deployment
For the deployment of the services we are using docker-compose in unison with docker swarm for the management of the cluster resources. To deploy the system on your machine follow the next steps:

### Step 1: Install dependencies

#### Install Docker
```bash
# install docker on linux
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sudo apt install docker-ce


# verify installation
docker --version

# enable docker to run automatically on every startup
sudo systemctl start docker
sudo systemctl enable docker

# run docker without sudo
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot
```

#### Install docker-compose
```bash
sudo apt update
sudo apt install curl
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# verify the installation
docker-compose --version
```

### Step 2: Clone necessarry repositories
```bash
sudo apt update && sudo apt install git

# clone ADIS project it is necessary for the project to reside into home directory of the user
cd ~/
git clone https://github.com/gmitis/ADIS_project24

# clone TPC-DS repo
cd ADIS_project24 
git clone https://github.com/gregrahn/tpcds-kit.git 
```

### Step 3: Create dataset
Create the desired amount of data and TPC-DS tables

```bash
# install gcc
# CRITICAL: if gcc is already installed make sure it is version 9
gcc --version
sudo add-apt-repository ppa:ubuntu-toolchain-r/ppa -y
sudo apt update
sudo apt install g++-9 gcc-9

# install dependencies
sudo apt-get install gcc make flex bison byacc git

# generate data (finally)
mv tpcds-kit DSGen && cd DSGen/tools
make clean && make CC=gcc-9 OS=LINUX
cd DSGen/tools
./dsdgen -scale [created dataset in GB: integer] \
         -dir ~/ADIS_project24/data/original_data
```

### Step 4 (optional): Generate queries
On the directory ./ADIS_project/queries all of the queries that was run for this experiment are available. If you want to regenerate all the query suite you got to follow the steps described next

```bash
# generated queries will be located in ~/ADIS_project24/utils/initial_queries
cd ~/ADIS_project24
./utils/generate_queries.sh [scale_factor_same_as_data_generation: integer]
```

### Step 5: Parse dataset to CSV
```bash
cd ~/ADIS_project24
chmod +x ~/ADIS_project24/utils/*

# also creates a catalog.txt into ~/ADIS_project24 that contains the names of all the tables
./utils/make_csv.sh ~/ADIS_project24/data/original_data
```

### Step 6 (optional): Generate tables interpretation according to db
We have the ~/ADIS_project24/datasources/tpcds.sql file tha contains all of the definitions of the tables in SQL format. With the below script we generate the table translation as well as the command needed to populate each db for this table.The results table/copy definitions are localted in ~/ADIS_project24/datasources/table_population_scripts/{db}/* . All of these configuration files are present in the repository, so this step is optional.

```bash
cd ~/ADIS_project24
./utils/table_scripts/cassandra_population_scripts.sh
./utils/table_scripts/mongodb_population_scripts.sh     
./utils/table_scripts/postgresql_population_scripts.sh

# ATTENTION: you need to add manually the attribute "dv_cmdline_args" to all dbgen_version table definitions if you are chosing to regenerate them 
```

### Step 7: Define table distribution for each DB
Runs a script for each database that gets as input the table names that we want to populate the corresponding database with and provides as ouput a ~/ADIS_project24/datasources/db_population_scripts/{db}_populate.{postfix} file. <br>
Use all of the table names that you want to include for the particular db or * for all of them.

```bash
cd ~/ADIS_project24
./utils/population_scripts/cassandra_generate.sh [table1 table2 ... tableN] || all
./utils/population_scripts/mongodb_generate.sh [table1 table2 ... tableN] || all
./utils/population_scripts/postgresql_generate.sh [table1 table2 ... tableN] || all
```

### Step 8: Configure Virtual Machine Cluster
In this step we will perform the necessarry configuration for a docker swarm cluster. 

```bash
# from each VM
# to see the ip address from each node execute the following command and see interface eth0
ifconfig | grep inet6

# or to see ipv4s if connected to public net
ifconfig | grep inet

# step a: create an ssh tunneling service so that adis2 and adis4 can communicate with adis1 and make It Persistent at Startup
crontab -e 

# step b: then add following lines, save document and exit
# for our use case adis2 and adis4 didn't have connection to the internet via ipv4

# ssh -f -N -R 2377:localhost:2377 [adis2_domainName]
# ssh -f -N -R 2377:localhost:2377 [adis4_domainName]

# step c: allow traffic on ports 22, 2377, 4789 and 7946 on all of the Virtual Machines
sudo ufw allow from [HOST] to [HOST]/any port [list_ports]
```
Then we are going to create the cluster by deploying docker services with docker swarm

```bash
# on the manager node (adis1)
# initialize swarm cluster
docker swarm init --advertise-addr [adis1_ipv6]

# get a join token for workers
docker swarm join-token worker

# then you have to ssh to each worker (adis2, adis3, adis4) and join these nodes with manager
docker swarm join --token [received_token] [adis1_ipv6]:2377

# ssh back to the manager node and create neccessary labels so that docker knows which service to deploy in what VM
docker node update --label-add role=adis1 [adis1_domainName] 
docker node update --label-add role=adis2 [adis2_domainName]
docker node update --label-add role=adis3 [adis3_domainName]
docker node update --label-add role=adis4 [adis4_domainName]
```

### Step 9: Verify Successful Implementation of Cluster 
Run the following commands to check if cluster is setup correctly
```bash
# from adis1(manager)
# you should be able to oberve traffic to all of the VMs
ping6 [adis2_domainName]
ping6 [adis3_domainName]
ping6 [adis4_domainName]

# from each VM
# you should be able to have communication with the manager
ping6 [adis1_domainName]

# from adis1(manager)
# verify that all nodes are present, you should see that all nodes are available 
docker node ls 
```

<br><br>


## Usage

### Initialize Services
```bash
# from manager VM
docker stack deploy -c docker-compose.yaml cluster

# inspect running services
docker service ls

# inspect services logs
docker service logs [service_cluster_name] -f

# restart a service either of which works, the latter has more error messages
docker service update --force [service_cluster_name]
docker service ps --no-trunc [service_cluster_name]

# remove a service 
docker service rm [service_cluster_name]

# remove the whole cluster
docker stack rm cluster
```

### Run queries
```bash
# from VM that presto-coordinator is deployed
docker exec -it [cluster_presto-coordinator_name] /opt/presto-cli --file /opt/presto-server/etc/queries/query{N}.sql
```

### Troubleshooting Databases
```bash
# from manager node
# see logs 
docker service logs -f [database_cluster_name]

# or run queries from inside the presto-coordinator
docker exec -it presto-coordinator bash
./opt/presto-cli --catalog postgresql --schema public  --execute 'show tables;'
./opt/presto-cli --execute 'select count(*) from {catalog}.{schema}.{table};' 
./opt/presto-cli --execute 'select * from {catalog}.{schema}.{table} limit 100;' 


# from where the database is deployed
# execute commands from inside the containers
docker exec -it [database_cluster_name] bash

# from where the database is deployed
# if a database is not populating correctly try removing the volumes and builds with
docker volume -f prune
docker system -f prune
docker-compose down -v

```

### Query Management
You can use a web UI to see how presto queries run and manage them in general by installing Remote - SSH and Remote - SSH: Editing Configuration Files in VSCode

<br><br>


## Tools used 
![Git Badge](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![PrestoDB Badge](https://img.shields.io/badge/PrestoDB-5890FF?style=for-the-badge&logo=prestodb&logoColor=white)
![PostgreSQL Badge](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![MongoDB Badge](https://img.shields.io/badge/MongoDB-47A248?style=for-the-badge&logo=mongodb&logoColor=white)
![Cassandra Badge](https://img.shields.io/badge/Cassandra-1287B1?style=for-the-badge&logo=apache-cassandra&logoColor=white)
![TPC-DS Badge](https://img.shields.io/badge/TPC--DS-FFA500?style=for-the-badge)
![Bash Badge](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![SQL Badge](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white)
![Docker Badge](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Docker Swarm Badge](https://img.shields.io/badge/Docker_Swarm-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Okeanos Badge](https://img.shields.io/badge/Okeanos-0052CC?style=for-the-badge)  
<br><br>


## Contributors
<table>
  <tr>
    <td align="center">
      <a href="https://github.com/gmitis">
        <img src="https://github.com/identicons/mwhite.png" width="100px;" alt="gmitis"/>
        <br />
        <sub><b>Yanis Mytis</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/AntonisZakynthinos">
        <img src="https://snipboard.io/Gu7MgA.jpg" width="100px;" alt="AntonisZakynthinos"/>
        <br />
        <sub><b>Antonis Zakynthinos</b></sub>
      </a>
    </td>
    <td align="center">
      <a href="https://github.com/georgia-manifava">
        <img src="https://snipboard.io/xYftsk.jpg" width="100px;" alt="georgia-manifava"/>
        <br />
        <sub><b>Georgia Manifava</b></sub>
      </a>
    </td>
  </tr>
</table>

<br><br>

## License
This project is licensed under the [MIT License](LICENSE)