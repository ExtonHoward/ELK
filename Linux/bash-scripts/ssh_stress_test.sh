#!/usr/bit/env bash

# sciprt is designed to create an infinite number of failed ssh logins. The desired IP addresses
# must be placed in a file called urls.txt in the same directory. Never use this against an IP
# address or target without explicit permission

while true; do
        for URL in $(cat urls.txt); do
                ssh user@$URL
        done
done