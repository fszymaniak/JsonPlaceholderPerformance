#!/bin/bash
echo "Fortio Stress Test (100 QPS, 10min)"
fortio load -qps 100 -t 10m -c 50 https://jsonplaceholder.typicode.com/posts
