# DockerMSSQLPageCounter
simple page counter



This is basically a local implemenation using Docker of my AzurePythonWebsite project. It accomplishes what that project does but at a local scale and it uses Docker as a means to deploy the solution to an internal network.
One advantage of having a local deployment like this is that it would cut down on costs that would come from an Azure deployment if there was a need to achieve something similar to this at an internal network only level.
Having a page counter as a result of this deployment is simply a means to an end and with some SQL table and GET/POST request modifications i'm sure this solution can be adapted to fit various different needs.

instructions:

Download the github repo as a zip and unpack it to your desired location
  navigate to \DockerMSSQLPageCounter-main\SQL
  Open the dockerfile and modify the SA_PASSWORD environmental variable to a password of your choosing that follows the following constraints: 
  	At least 8 characters including uppercase, lowercase letters, base-10 digits and/or non-alphanumeric symbols.
	
  Open CMD in \DockerMSSQLPageCounter-main\SQL
   > type: docker build -t sql1 .
   > type: docker run -p 1433:1433 -d sql1
   > type: docker network inspect bridge
   	 find the "sql1" IPv4Address and copy it to a notepad, the cidr notation does not need to be copied
	 
navigate to /setup files/ and right click on main.py and open in notepad
in the section where it says: 

def connection():
server = '172.17.0.2,1433' 
...
password = '<password hehere>'
      replace the server ip address with the sql1 IPv4Address you copied down earlier, keep the port number 1433 and save the file
      replcae the password with the password you created for the SA_PASSWORD env variable
	
IN CMD type "cd .."
    type: docker build -t pythondocker -f Dockerfile .
    type: docker run -d -p 5047:80 pythondocker
    type: cd nginx
    type: docker build -t nginx -f Dockerfile .
    type: docker run -d -p 8080:80 nginx
	
go to http://localhost:8080/ and you should see an html page displaying "Page View Count: #" with a number that updates every time the page is refreshed or accessed.
