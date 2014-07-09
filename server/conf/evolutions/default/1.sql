# --- Created by Slick DDL
# To stop Slick DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table "CAT" ("name" VARCHAR(254) NOT NULL PRIMARY KEY,"color" VARCHAR(254) NOT NULL);
create table "TASK" ("id" SERIAL NOT NULL PRIMARY KEY,"title" VARCHAR(254) NOT NULL,"description" VARCHAR(254),"due_date" DATE,"points" INTEGER NOT NULL,"repeats" VARCHAR(254));

# --- !Downs

drop table "CAT";
drop table "TASK";

