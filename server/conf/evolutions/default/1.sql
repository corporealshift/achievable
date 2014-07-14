# --- Created by Slick DDL
# To stop Slick DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table "CAT" ("name" VARCHAR(254) NOT NULL PRIMARY KEY,"color" VARCHAR(254) NOT NULL);
create table "TASK" ("id" SERIAL NOT NULL PRIMARY KEY,"title" VARCHAR(254) NOT NULL,"description" VARCHAR(254),"due_date" DATE,"complete" BOOLEAN DEFAULT false NOT NULL,"points" INTEGER NOT NULL,"repeats" VARCHAR(254),"repeat_frequency" VARCHAR(254),"repeat_until" DATE,"chain" INTEGER DEFAULT 0 NOT NULL);

# --- !Downs

drop table "CAT";
drop table "TASK";

