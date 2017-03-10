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
