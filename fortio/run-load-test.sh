#!/bin/bash
echo "Fortio Load Test (20 QPS, 5min)"
fortio load -qps 20 -t 5m -c 10 https://jsonplaceholder.typicode.com/posts
