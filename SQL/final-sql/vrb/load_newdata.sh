#/bin/sh


psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS answers"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS questions"
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS tags"
    

echo "Загружаем answers.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS answers (
    Id bigint,
    OwnerUserId bigint,
    CreationDate timestamp,
    ParentId bigint,
    Score bigint,
    IsAcceptedAnswer varchar(20,
    Body text
  );'

psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "\\copy answers FROM '/data/answers.csv' DELIMITER ',' CSV HEADER"



echo "Загружаем questions.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS ratings (
    Id bigint,
    OwnerUserId bigint,
    CreationDate timestamp,
    Score bigint,
    Title text,
    Body text
  );'

psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy questions FROM '/data/questions.csv' DELIMITER ',' CSV HEADER"




echo "Загружаем tags.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS answers (
    Id bigint,
    tag text
  );'

psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "\\copy tags FROM '/data/tags.csv' DELIMITER ',' CSV HEADER"

