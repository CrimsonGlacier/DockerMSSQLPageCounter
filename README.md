# DockerMSSQLPageCounter
simple page counter



This is basically a local implemenation using Docker of my AzurePythonWebsite project. It accomplishes what that project does but at a local scale and it uses Docker as a means to deploy the solution to an internal network.
One advantage of having a local deployment like this is that it would cut down on costs that would come from an Azure deployment if there was a need to achieve something similar to this at an internal network only level.
Having a page counter as a result of this deployment is simply a means to an end and with some SQL table and GET/POST request modifications i'm sure this solution can be adapted to fit various different needs.

instructions:

Download the github repo as a zip and unpack it to your desired location
  navigate to \setup files\SQL
  Open the dockerfile and modify the SA_PASSWORD environmental variable to a password of your choosing that follows the following constraints : At least 8 characters including uppercase, lowercase letters, base-10 digits     and/or non-alphanumeric symbols.
  Open CMD in \setup files\SQL
