#!/bin/bash
echo "Bombardier Stress Test (200 connections, 10min)"
bombardier -c 200 -d 10m https://jsonplaceholder.typicode.com/posts
