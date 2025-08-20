CREATE SCHEMA IF NOT EXISTS notification_service;

CREATE TABLE IF NOT EXISTS notification_service.notifications (
    id varchar(255) PRIMARY KEY,
    user_id varchar(255),
    offer_id varchar(255),
    message varchar(255),
    creation_timestamp timestamp(6)
);

CREATE INDEX IF NOT EXISTS idx_notifications_user_created
    ON notification_service.notifications (user_id, creation_timestamp DESC);
