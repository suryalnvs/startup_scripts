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
   CONTAINER ID        IMAGE                                                              COMMAND                  CREATED        STATUS                  PORTS                                            NAMES
ab3ec4d706ad        rameshthoomu/fabric-peer-x86_64:x86_64-0.7.0-snapshot-509d8ed      "peer node start -..."   2 seconds ago       Up Less than a second   0.0.0.0:7056->7051/tcp, 0.0.0.0:7058->7053/tcp   peer1
1d4a979ce4f1        rameshthoomu/fabric-peer-x86_64:x86_64-0.7.0-snapshot-509d8ed      "peer node start -..."   4 seconds ago       Up 2 seconds            0.0.0.0:7051->7051/tcp, 0.0.0.0:7053->7053/tcp   peer0
f845ed1fd438        rameshthoomu/fabric-orderer-x86_64:x86_64-0.7.0-snapshot-509d8ed   "orderer"                6 seconds ago       Up 4 seconds            0.0.0.0:7050->7050/tcp                           orderer0
851a622ebfec        rameshthoomu/fabric-ca-x86_64:x86_64-0.7.0-snapshot-f18b6b7        "sh -c 'fabric-ca-..."   6 seconds ago       Up 4 seconds            0.0.0.0:7054->7054/tcp                           ca0
```
```bash
archana@archana-ITPC:~/gopath/src/github.com/hyperledger/fabric/procurement/network$ docker images
REPOSITORY                           TAG                             IMAGE ID            CREATED             SIZE
rameshthoomu/fabric-ca-x86_64        x86_64-0.7.0-snapshot-f18b6b7   6033fee0716b        6 days ago          239 MB
rameshthoomu/fabric-orderer-x86_64   x86_64-0.7.0-snapshot-509d8ed   85ec9965dc5c        6 days ago          180 MB
rameshthoomu/fabric-peer-x86_64      x86_64-0.7.0-snapshot-509d8ed   bc7e875f86a9        6 days ago          184 MB
hyperledger/fabric-ccenv             x86_64-0.7.0-snapshot-509d8ed   6d713063f875        6 days ago          1.29 GB
rameshthoomu/fabric-ccenv-x86_64     x86_64-0.7.0-snapshot-509d8ed   6d713063f875        6 days ago          1.29 GB
hyperledger/fabric-baseos            x86_64-0.3.0                    c3a4cf3b3350        6 weeks ago         161 MB
```
## Installing the Node Modules
```bash
   ./network_launcher.sh modules
```
## Deploying the Chaincode 
```bash
   ./network_launcher.sh deploy
```
```bash
[2017-03-11 22:35:54.582] [DEBUG] DEPLOY - The chaincode deploy transaction has been committed on this peer0
[2017-03-11 22:35:54.583] [DEBUG] DEPLOY - The chaincode deploy transaction was valid code=VALID
[2017-03-11 22:35:54.585] [INFO] DEPLOY - Successfully sent deployment transaction to the orderer.
```
```bash
archana@archana-ITPC:~/gopath/src/github.com/hyperledger/fabric/procurement/network$ docker ps
CONTAINER ID        IMAGE                                                              COMMAND                  CREATED              STATUS              PORTS                                            NAMES
5c7eafa773d4        peer0-peer0-proc5-02                                               "chaincode -peer.a..."   18 seconds ago       Up 16 seconds                                                        peer0-peer0-proc5-02
1bd5502e0c7c        peer1-peer1-proc5-02                                               "chaincode -peer.a..."   19 seconds ago       Up 16 seconds                                                        peer1-peer1-proc5-02
5f685258745a        rameshthoomu/fabric-peer-x86_64:x86_64-0.7.0-snapshot-509d8ed      "peer node start -..."   About a minute ago   Up About a minute   0.0.0.0:7056->7051/tcp, 0.0.0.0:7058->7053/tcp   peer1
fcdb7115f1e0        rameshthoomu/fabric-peer-x86_64:x86_64-0.7.0-snapshot-509d8ed      "peer node start -..."   About a minute ago   Up About a minute   0.0.0.0:7051->7051/tcp, 0.0.0.0:7053->7053/tcp   peer0
f6a6c26daf33        rameshthoomu/fabric-orderer-x86_64:x86_64-0.7.0-snapshot-509d8ed   "orderer"                About a minute ago   Up About a minute   0.0.0.0:7050->7050/tcp                           orderer0
c8fc43adb3c8        rameshthoomu/fabric-ca-x86_64:x86_64-0.7.0-snapshot-f18b6b7        "sh -c 'fabric-ca-..."   About a minute ago   Up About a minute   0.0.0.0:7054->7054/tcp                           ca0

```
## Starting the Application
```bash
   ./network_launcher.sh start-app
```
```bash
[2017-03-11 22:42:43.032] [INFO] PROCUREMENT-NODE - ####################### Server Up - localhost:3000 #######################
info: [Peer.js]: Peer.const - url: grpc://localhost:7051 options  grpc.ssl_target_name_override=tlsca, grpc.default_authority=tlsca
info: [Peer.js]: Peer.const - url: grpc://localhost:7056 options  grpc.ssl_target_name_override=tlsca, grpc.default_authority=tlsca
[2017-03-11 22:42:43.056] [INFO] FILE-WATCHER-NODE - Started watching the files @  /home/archana/gopath/src/github.com/hyperledger/fabric/procurement/node/app/mqnode/input/


```
## Cleaning the Network
```bash
   ./network_launcher.sh down
```
```bash
archana@archana-ITPC:~/gopath/src/github.com/hyperledger/fabric/procurement/network$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
