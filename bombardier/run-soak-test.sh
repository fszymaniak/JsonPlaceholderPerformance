#!/bin/bash
echo "Bombardier Soak Test (20 connections, 30min)"
bombardier -c 20 -d 30m https://jsonplaceholder.typicode.com/posts
