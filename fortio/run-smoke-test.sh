#!/bin/bash
echo "Fortio Smoke Test (1 QPS, 30s)"
fortio load -qps 1 -t 30s https://jsonplaceholder.typicode.com/posts
