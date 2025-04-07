CREATE SCHEMA IF NOT EXISTS user_service;

CREATE TABLE IF NOT EXISTS user_service.users (
    id varchar(255) PRIMARY KEY,
    creation_timestamp timestamp(6),
    update_timestamp timestamp(6),
    username varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    role varchar(255),
    active varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    phone_number varchar(255),
    country varchar(255),
    city varchar(255),
    address varchar(255),
    postal_code varchar(255),
    about_me varchar(255),
    profile_picture varchar(255),
    CONSTRAINT uk_users_username UNIQUE (username),
    CONSTRAINT uk_users_email UNIQUE (email)
);
