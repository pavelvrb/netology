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
    OwnerUserId bigint check(OwnerUserId != 'NA'),
    CreationDate timestamp,
    ParentId bigint,
    Score bigint,
    IsAcceptedAnswer varchar(20),
    Body text
  );'

psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "\\copy answers FROM '/data/rquestions/Answers.csv' DELIMITER ',' CSV HEADER"



echo "Загружаем questions.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS questions (
    Id bigint,
    OwnerUserId bigint check(OwnerUserId != 'NA'),
    CreationDate timestamp,
    Score bigint,
    Title text,
    Body text
  );'

psql --host $APP_POSTGRES_HOST -U postgres -c \
    "\\copy questions FROM '/data/rquestions/Questions.csv' DELIMITER ',' CSV HEADER"




echo "Загружаем tags.csv..."
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS tags (
    Id bigint,
    tag text
  );'

psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "\\copy tags FROM '/data/rquestions/Tags.csv' DELIMITER ',' CSV HEADER"

