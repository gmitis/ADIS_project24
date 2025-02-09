-- disable write ahead logging and checkpoints for batch population of the database
ALTER SYSTEM SET synchronous_commit = 'off';
ALTER SYSTEM SET wal_level = 'minimal';
ALTER SYSTEM SET wal_keep_size = 0;
ALTER SYSTEM SET max_wal_senders = 0;
ALTER SYSTEM SET archive_mode = off;

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

