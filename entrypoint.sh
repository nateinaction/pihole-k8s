#! /bin/sh

cp /config/adlists.list /etc/pihole/

while read domain; do
    pihole -w "${domain}";
done < /config/allowlist_exact

while read domain; do
    pihole -b "${domain}";
done < /config/denylist_exact

/s6-init
