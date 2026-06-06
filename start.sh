#!/bin/bash
# update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
# update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# First time setup rerun setup env
# after run we don't need to run ever again
# so we check fro lock file
lock_file=/app/first_time_setup.lock
if [[ ! -f $lock_file ]]; then
	bash /app/src/setup.sh
	touch $lock_file
fi

dotnet CodeProject.AI.Server.dll --port 32168
