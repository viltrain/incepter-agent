Incepter Agent
--------------
An agent for Incepter, this agent uses Docker-in-Docker, allowing you to run multiple instances without them interfering with each other.
(Unlike Docker Cloud and Rancher which take up a whole node)

# Build and run
./build.sh && docker run -d --name incepter-agent --privileged peragro/incepter-agent 

# Create a client certificate and let the agent sign it 
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=incepter' -new -key key.pem | docker exec -i dc-agent sign >> cert.pem

# Connect to the agent with our certificate
docker --tls --tlscert=cert.pem --tlskey=key.pem -H=172.17.0.2:2376 version
