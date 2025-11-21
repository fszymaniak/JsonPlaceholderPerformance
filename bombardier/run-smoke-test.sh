#!/bin/bash
echo "Bombardier Smoke Test (1 connection, 30s)"
bombardier -c 1 -d 30s https://jsonplaceholder.typicode.com/posts
