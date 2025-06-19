CREATE SCHEMA IF NOT EXISTS file_storage;

CREATE TABLE IF NOT EXISTS file_storage.files (
    id varchar(255) PRIMARY KEY,
    type varchar(255),
    file_path varchar(255)
);
