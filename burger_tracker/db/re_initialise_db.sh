dropdb -i --if-exists burger_tracker
createdb burger_tracker

psql -d burger_tracker -f burger_tracker_tables.sql

