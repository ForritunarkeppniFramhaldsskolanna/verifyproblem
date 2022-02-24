FROM problemtools/full:v1.20191126-rev1

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
