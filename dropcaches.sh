#!/usr/bin/env bash

echo "Before drop caches:"
free -h
sync
echo 3 | sudo tee /proc/sys/vm/drop_caches
sync
echo
echo "After drop caches:"
free -h
