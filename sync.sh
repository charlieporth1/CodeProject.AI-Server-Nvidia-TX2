#!/bin/bash
rsync --copy-links -r tegra-ubuntu:'~/*.sh*' .
rsync --copy-links -r tegra-ubuntu:~/Dockerfile .
rsync --copy-links -r tegra-ubuntu:'~/crontab*.txt' .
rsync --copy-links -r tegra-ubuntu:'~/*.whl' .
