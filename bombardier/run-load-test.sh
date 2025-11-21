#!/bin/bash
echo "Bombardier Load Test (50 connections, 5min)"
bombardier -c 50 -d 5m https://jsonplaceholder.typicode.com/posts
