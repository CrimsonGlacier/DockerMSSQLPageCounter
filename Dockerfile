FROM python:3.8

COPY install.sh /
COPY requirements.txt ./requirements.txt
COPY main.py ./main.py
COPY msodbcsql17_17.10.1.1-1_amd64.deb ./msodbcsql17_17.10.1.1-1_amd64.deb
COPY unixodbc-dev_2.3.11-1_amd64.deb ./unixodbc-dev_2.3.11-1_amd64.deb
COPY mssql-tools_17.10.1.1-1_amd64.deb ./mssql-tools_17.10.1.1-1_amd64.deb
RUN chmod +x ./install.sh
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get update && \
    apt-get install -y software-properties-common

RUN apt-get install curl
RUN apt-get update \
 && apt-get install unixodbc -y \
 && apt-get install unixodbc-dev -y \
 && apt-get install freetds-dev -y \
 && apt-get install freetds-bin -y \
 && apt-get install tdsodbc -y \
 && apt-get install --reinstall build-essential -y \
 && apt-get install -y libltdl7 \
 && apt-get install -y libodbc1 \
 && apt-get install -y odbcinst \
 && apt-get install -y odbcinst1debian2 \
 && apt-get install -y locales-all
RUN apt-get update

RUN pip install -r requirements.txt
RUN apt-get install unixodbc unixodbc-dev && pip install pyodbc
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile

RUN pip install requests
RUN pip install -U flask-cors
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-get update
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list 
RUN apt-get update
RUN curl https://packages.microsoft.com/config/ubuntu/19.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update

RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN ACCEPT_EULA=Y apt-get -f install -y ./mssql-tools_17.10.1.1-1_amd64.deb
RUN ACCEPT_EULA=Y apt-get -f install -y ./msodbcsql17_17.10.1.1-1_amd64.deb

CMD ["python", "./main.py"]
















