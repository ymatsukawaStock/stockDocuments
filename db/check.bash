#!/bin/bash

echo "tested"
DBNAME="stock_dev"

psql $DBNAME < ./check/show_all_tables.sql
