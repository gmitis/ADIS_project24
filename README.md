## Project Description
tba

## Running Services:

Specifications in postgres_init.sql file:

```bash
    # The following lines make it conditional to create a database named adis
    # , a role named root with it's password and give them privileges if they
    # don't exist. If they do they don't create nothing and continue. It is
    # necessary because if it just tries to create a database named adis and 
    # finds that it exists then it skips the rest of the initialization which
    # includes the tables creation and the data parsing

    DO $$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'adis') THEN
            CREATE DATABASE adis;
        END IF;
    END $$;

    DO $$
    BEGIN
        IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'root') THEN
            CREATE USER root WITH PASSWORD 'root';
        END IF;
    END $$;

    DO $$
    BEGIN
        IF EXISTS (SELECT FROM pg_database WHERE datname = 'adis')
        AND EXISTS (SELECT FROM pg_roles WHERE rolname = 'root') THEN
            GRANT ALL PRIVILEGES ON DATABASE adis TO root;
        END IF;
    END $$;

    # setting the tables following the syntax that is compatible with 
    # posgreSQL

    CREATE TABLE web_site (...);
    CREATE TABLE web_page (...);
    CREATE TABLE web_returns (...);
    CREATE TABLE web_sales (...);

    # Here it passes the data from the .dat files
    # here /data is the directory that the DBMS sees and it is inside the
    # container which is specified in the docker-compose.yaml and corresponds
    # to the (PROJECT DIRECTORY)/ADIS_project24/Data/postgre_data (see more in
    # the docker-compose.yaml file)

    COPY web_site FROM '/data/web_site.dat' WITH (FORMAT csv, DELIMITER '|');
    COPY web_page FROM '/data/web_page.dat' WITH (FORMAT csv, DELIMITER '|');
    COPY web_returns FROM '/data/web_returns.dat' WITH (FORMAT csv, DELIMITER '|');
    COPY web_sales FROM '/data/web_sales.dat' WITH (FORMAT csv, DELIMITER '|');

```

Specifications in the docker-compose.yaml file:

``` bash
    services:
        
        .
        .
        . #OTHER SERVICES
        .
        .

      postgres:
        image: postgres:17.0
        container_name: postgres
        hostname: postgres
        environment:
            - POSTGRES_USER=root
            - POSTGRES_PASSWORD=root
            - POSTGRES_DB=adis
        ports:
            - "5432:5432"
        volumes:
            #same as before this line initializes the postgres_init.sql
            #file in the postgreSQL DBMS container creation process
            - ./datasources/db_population_scripts/postgres_init.sql:/docker-entrypoint-initdb.d/postgres_init.sql
            #here we set a directory locally that houses the volumes
            #created by the DBMS and it corresponds to the name
            #'postgres_data' (THIS IS THE VOLUME NAME)
            - postgres_data:/var/lib/postgresql/data
            #here we connect the Data/postgres_data inside the local git repo
            #to correspond to the data folder that is inside the container
            #when it is created
            - ./Data/postgre_data:/data
        networks:
        presto:
            ipv4_address: 10.18.0.128


    #This is needed so that the volume we created is recognized by
    #the container. Also we set the name here again because if we 
    #don't it is automatically named after the project name + the
    #name we gave above in the volumes part of the postgres service
    #for example it is named (ADIS_project24_postgres_data)
    volumes:
        postgres_data:
            name: postgres_data
```

Commands to fix the data files
``` bash
    #This command copies the problematic file fixes it and saves it
    #in the current directory as a new file
    sed 's/|$//' (ABSOLUTE_PATH_TO_PROBLEMATIC_DATA_FILE)/(DATA_FILE_NAME).dat > (FIXED_DATA_FILE_NAME).dat

    #This command moves the fixed file to the directory of the 
    #problematic one and replaces it giving the fixed file the 
    #name it had before when it was problematic
    mv (FIXED_DATA_FILE_NAME).dat (ABSOLUTE_PATH_TO_PROBLEMATIC_DATA_FILE)/(DATA_FILE_NAME).dat
```

How to initialize postgreSQL
``` bash
    # If you just start it with the above specifications:
    
    # Initialize the container that has the DBMS
    sudo docker-compose up -d postgres
    # Get inside the cli of the DBMS:
    sudo docker exec -it postgres psql -U root -d adis
    # Then write this to return the tables:
    \dt 
    # Then execute a simple query :
    SELECT * FROM web_site LIMIT 10; 
    #This should print the column names and then 10 results from the web_site table 


    #If you encounter problems and \dt or SELECT * FROM web_site LIMIT 10; 
    #don't print anything then you reinitialize a clean postgres container
    
    #While postgres container is up you get inside the cli again with:
    sudo docker exec -it postgres psql -U root -d adis
    # you must connect to the adis database. You roll back to the postgres
    # default database and drop the adis database like this :
    \c postgres
    DROP DATABASE adis;
    exit 
    # Then you bring the postgres container down like this:
    sudo docker-compose down
    # After that you see if there are any remaining volumes:
    sudo docker volume ls
    # If there are you delete them. It will probably has the 
    # name postgres_data
    sudo docker volume rm postgres_data
    # Now it is clean so you reinitialize with the commands 
    # from the start
