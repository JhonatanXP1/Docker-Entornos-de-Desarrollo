FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine  as build
RUN apk add --no-cache \
    bash \
    git \
    curl \
    wget \
    nano \
    vim \
    icu-libs \
    procps \
    tzdata \
    tree
#set timezone
ENV TZ=America/Mexico_City

RUN dotnet tool install -g dotnet-ef \
    && dotnet tool install -g dotnet-aspnet-codegenerator \
    && rm -rf /root/.nuget/packages/* \
    && rm -rf /tmp/*

ENV PATH="$PATH:/root/.dotnet/tools"

EXPOSE 80 443 5000 5001


ENV ASPNETCORE_ENVIRONMENT=Development \
    DOTNET_USE_POLLING_FILE_WATCHER=true \
    ASPNETCORE_URLS="http://+:80"

WORKDIR /homeWork

CMD ["bash"]
