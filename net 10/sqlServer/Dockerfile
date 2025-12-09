FROM mcr.microsoft.com/mssql/server:2025-latest

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Jhonatan11+
ENV MSSQL_PID=Developer


USER root

RUN apt-get update && \
    apt-get install -y curl gnupg2 apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev && \
    # Agregar mssql-tools al PATH
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> /root/.bashrc && \
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> /etc/environment

ENV PATH="$PATH:/opt/mssql-tools18/bin"

EXPOSE 1433
VOLUME /var/opt/mssql
WORKDIR /var/opt/mssql

HEALTHCHECK --interval=10s --timeout=5s --retries=10 --start-period=40s \
  CMD /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" || exit 1

CMD ["/opt/mssql/bin/sqlservr"]