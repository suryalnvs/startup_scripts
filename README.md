# Contingent-labor
## Prerequisites
- <a href="https://git-scm.com/downloads" target="_blank">Git client</a>
- Docker v1.12 or later
- Docker-Compose v1.8 or later
- GO v1.7 or later
- NodeJS v6.7 or later
- Npm v3.1 or later

## Cloning the Repository
```bash
   git clone git@github.ibm.com:SSC-Blockchain/contingent-labor.git
```
## Installing Prerequisites
To install all the prerequisites for the environment, execute the following.
```bash
   cd contingent-labor/network
   ./setup_prereq.sh
```
Check your Docker, Docker-Compose, Go, NodeJs, Npm versions with the following commands:
```bash
    docker version
    docker-compose version
    go version
    node -v
    npm -v
```
## Launching the Blockchain Network with one orderer, two peers and one ca server
```bash
   cd contingent-labor/network
   ./network_launcher.sh up
```
This will pull the images for Orderer, Peer and CA which passed end-to-end node-sdk and java-sdk programs and launch the network using these images.
```bash
   # Contingent-labor

## Prerequisites
-  [Development Environment](https://github.com/hyperledger/fabric/blob/master/docs/dev-setup/devenv.md)
- [Sandbox Environment](https://github.com/hyperledger/fabric/blob/master/docs/Setup/Chaincode-setup.md)
- <a href="https://git-scm.com/downloads" target="_blank">Git client</a>
- Docker v1.12 or later
- Docker-Compose v1.8 or later
- GO v1.7 or later
- NodeJS v6.7 or later
- Npm v3.1 or later


Note : Open a terminal to execute the following commands.
## Cloning the Repository
```bash
   git clone git@github.ibm.com:SSC-Blockchain/contingent-labor.git
```
## Installing Prerequisites
To install all the prerequisites for the environment, execute the following.
```bash
   cd contingent-labor/network
   ./setup_prereq.sh
```
Check your Docker, Docker-Compose, Go, NodeJs, Npm versions with the following commands:
```bash
    docker version
    docker-compose version
    go version
    node -v
    npm -v
```
## Launching the Blockchain Network with one orderer, two peers and one ca server
```bash
   cd contingent-labor/network
   ./network_launcher.sh up
```
This will pull the docker images for Orderer, Peer and CA which passed end-to-end node-sdk and java-sdk programs and launch a network using these images.
```bash
   CONTAINER ID        IMAGE                                                              COMMAND                  CREATED        STATUS                  PORTS                                            NAMES
ab3ec4d706ad        rameshthoomu/fabric-peer-x86_64:x86_64-0.7.0-snapshot-509d8ed      "peer node start -..."   2 seconds ago       Up Less than a second   0.0.0.0:7056->7051/tcp, 0.0.0.0:7058->7053/tcp   peer1
1d4a979ce4f1        rameshthoomu/fabric-peer-x86_64:x86_64-0.7.0-snapshot-509d8ed      "peer node start -..."   4 seconds ago       Up 2 seconds            0.0.0.0:7051->7051/tcp, 0.0.0.0:7053->7053/tcp   peer0
f845ed1fd438        rameshthoomu/fabric-orderer-x86_64:x86_64-0.7.0-snapshot-509d8ed   "orderer"                6 seconds ago       Up 4 seconds            0.0.0.0:7050->7050/tcp                           orderer0
851a622ebfec        rameshthoomu/fabric-ca-x86_64:x86_64-0.7.0-snapshot-f18b6b7        "sh -c 'fabric-ca-..."   6 seconds ago       Up 4 seconds            0.0.0.0:7054->7054/tcp                           ca0
```
```
## Installing the Node Modules
```bash
   ./network_launcher.sh modules
```
## Deploying the Chaincode 
```bash
   ./network_launcher.sh deploy
```
## Starting the Application
```bash
   ./network_launcher.sh start-app
```
## Cleaning the Network
```bash
   ./network_launcher.sh down
```



## Installing the Node Modules
```bash
   ./network_launcher.sh modules
```
## Deploying the Chaincode 
```bash
   ./network_launcher.sh deploy
```
## Starting the Application
```bash
   ./network_launcher.sh start-app
```
## Cleaning the Network
```bash
   ./network_launcher.sh down
```
