FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

ENV SA_PASSWORD ENTER_YOUR_PASSWORD_HERE
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express



RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
COPY . /usr/local/bin/

# Grant permissions for the run-initialization script to be executable
RUN chmod +x /usr/src/app/run-initialization.sh
RUN chmod +x /usr/local/bin/run-initialization.sh

EXPOSE 1433

CMD /bin/bash ./entrypoint.sh 
