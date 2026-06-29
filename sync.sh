#!/bin/bash
rsync --copy-links -r --progress tegra-ubuntu:'~/*.sh*' .
rsync --copy-links -r --progress tegra-ubuntu:~/Dockerfile .
rsync --copy-links -r --progress tegra-ubuntu:'~/crontab*.txt' .
rsync --copy-links -r --progress tegra-ubuntu:'~/*.whl' .
