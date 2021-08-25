# pihole/pihole:v5.8.1
FROM pihole/pihole@sha256:b51628bfa49b71ce4af4831b34e276693a6d647b82037151d8eb0d34da504432

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
