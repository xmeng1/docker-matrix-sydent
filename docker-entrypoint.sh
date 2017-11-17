#!/usr/bin/env bash

init_sql() {
	echo "-=> initializing database"
	for f in /init/sql/*.sql; do
		echo "Importing $f ..";
		/bin/cat $f | /usr/bin/sqlite3 /data/sydent.db 
	done
}

if [ "$1" = 'start' ]; then
	chown -R sydent:sydent /data

	if [ ! -f /data/sydent.db ]; then
		init_sql
	fi

	exec python -m sydent.sydent
fi

exec "$@"
