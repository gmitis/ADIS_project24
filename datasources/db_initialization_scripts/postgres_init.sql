-- DROP DATABASE adis;
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
