CREATE SCHEMA IF NOT EXISTS job_service;

CREATE TABLE IF NOT EXISTS job_service.categories (
    id varchar(255) PRIMARY KEY,
    creation_timestamp timestamp(6),
    update_timestamp timestamp(6),
    name varchar(255),
    description varchar(255),
    image_id varchar(255)
);

CREATE TABLE IF NOT EXISTS job_service.jobs (
    id varchar(255) PRIMARY KEY,
    creation_timestamp timestamp(6),
    update_timestamp timestamp(6),
    name varchar(255),
    description varchar(255),
    image_id varchar(255),
    category_id varchar(255) NOT NULL,
    CONSTRAINT fk_jobs_category FOREIGN KEY (category_id) REFERENCES job_service.categories (id)
);

CREATE TABLE IF NOT EXISTS job_service.adverts (
    id varchar(255) PRIMARY KEY,
    creation_timestamp timestamp(6),
    update_timestamp timestamp(6),
    user_id varchar(255),
    name varchar(255),
    description varchar(255),
    delivery_time integer NOT NULL,
    price integer NOT NULL,
    image_id varchar(255),
    status varchar(255),
    advertiser varchar(255),
    job_id varchar(255) NOT NULL,
    CONSTRAINT fk_adverts_job FOREIGN KEY (job_id) REFERENCES job_service.jobs (id)
);

CREATE TABLE IF NOT EXISTS job_service.offers (
    id varchar(255) PRIMARY KEY,
    creation_timestamp timestamp(6),
    update_timestamp timestamp(6),
    user_id varchar(255),
    offered_price integer NOT NULL,
    status varchar(255),
    advert_id varchar(255) NOT NULL,
    CONSTRAINT fk_offers_advert FOREIGN KEY (advert_id) REFERENCES job_service.adverts (id)
);

CREATE TABLE IF NOT EXISTS job_service.jobs_keys (
    job_id varchar(255) NOT NULL,
    key_value varchar(255),
    CONSTRAINT fk_jobs_keys_job FOREIGN KEY (job_id) REFERENCES job_service.jobs (id)
);

CREATE INDEX IF NOT EXISTS idx_jobs_category_id ON job_service.jobs (category_id);
CREATE INDEX IF NOT EXISTS idx_adverts_job_id ON job_service.adverts (job_id);
CREATE INDEX IF NOT EXISTS idx_adverts_user_id ON job_service.adverts (user_id);
CREATE INDEX IF NOT EXISTS idx_offers_advert_id ON job_service.offers (advert_id);
CREATE INDEX IF NOT EXISTS idx_offers_user_id ON job_service.offers (user_id);
