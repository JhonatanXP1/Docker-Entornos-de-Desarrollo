FROM mariadb:11.4.10-noble

ENV MARIADB_ROOT_PASSWORD=goodDev11+
ENV MARIADB_DATABASE=adminMultipleMail
ENV MARIADB_USER=adminMultipleMail
ENV MARIADB_PASSWORD=goodDev11+

COPY adminMultipleMail.sql /docker-entrypoint-initdb.d/

EXPOSE 3306 
VOLUME /var/lib/mysql

HEALTHCHECK --interval=10s --timeout=5s --retries=10 --start-period=40s \
    CMD mysqladmin ping -h localhost -u root -p"$MARIADB_ROOT_PASSWORD" || exit 1

# NO agregues CMD aquí, el de la imagen base ya funciona