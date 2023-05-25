FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

ENV SA_PASSWORD Onlythestrong99!
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express



RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN chmod +x /usr/src/app/run-initialization.sh

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh 
