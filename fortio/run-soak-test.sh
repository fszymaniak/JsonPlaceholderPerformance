#!/bin/bash
echo "Fortio Soak Test (20 QPS, 30min)"
fortio load -qps 20 -t 30m -c 10 https://jsonplaceholder.typicode.com/posts
