#!/bin/bash
echo "Fortio Spike Test (200 QPS, 2min)"
fortio load -qps 200 -t 2m -c 100 https://jsonplaceholder.typicode.com/posts
