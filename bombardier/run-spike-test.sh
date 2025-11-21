#!/bin/bash
echo "Bombardier Spike Test (500 connections, 2min)"
bombardier -c 500 -d 2m -t 30s https://jsonplaceholder.typicode.com/posts
