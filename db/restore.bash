#!/bin/bash
DBNAME="stock_dev"
echo "./dml/creation.sql"
psql $DBNAME < ./dml/creation.sql
echo "./ddl/insertion.sql"
psql $DBNAME < ./ddl/insert.sql
