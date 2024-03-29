# DockerMSSQLPageCounter
A simple page counter using Docker to deploy a Python, NGINX, and Microsoft SQL container.



This is basically a local implemenation using Docker of my AzurePythonWebsite project. It accomplishes what that project does but at a local scale and it uses Docker as a means to deploy the solution to an internal network.
One advantage of having a local deployment like this is that it can cut down on costs that would come from an Azure deployment if there was a need to achieve something similar to this at an internal network only level.
Having a page counter as a result of this deployment is simply a means to an end and with some SQL table and GET/POST request modifications I'm sure this solution can be adapted to fit various different needs.

Instructions:

Download the github repo as a zip and unpack it to your desired location,
  Navigate to \DockerMSSQLPageCounter-main\SQL.
  Open the dockerfile and modify the SA_PASSWORD environmental variable to a password of your choosing that follows the following constraints: 
  	At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.
	
Change password in SQL/run-initialization.sh as well to the one you just made.
	
  Open CMD in \DockerMSSQLPageCounter-main\SQL, and input the following commands:
  
     docker build -t sql1 .
     
     docker run -p 1433:1433 -d sql1
     
     docker network inspect bridge
   
Find the "sql1" IPv4Address and copy it to a notepad, the CIDR notation does not need to be copied.
	 
Navigate to /setup files/, right click on main.py and open in notepad. In the section where it says: 

    def connection():
    server = '172.17.0.2,1433' 
    ...
    password = '<ENTER_YOUR_PASSWORD_HERE>'
    
Replace the server IP address with the sql1 IPv4Address you copied down earlier, keep the port number 1433 and save the file,
        replace the password with the password you created for the SA_PASSWORD environmental variable.
	
Afterwards, input the following commands into CMD:

    cd ..
    docker build -t pythondocker -f Dockerfile .
    docker run -d -p 5047:80 pythondocker
    cd nginx
    docker build -t nginx -f Dockerfile .
    docker run -d -p 8080:80 nginx
	
Go to http://localhost:8080/ and you should see an html page displaying "Page View Count: #" with a number that updates every time the page is refreshed or accessed.
