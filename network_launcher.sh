#!/bin/bash

set -e
UP_DOWN=$1

function printHelp {
	echo "Usage: ./network_launcher.sh <up|down|remove>"
        echo "       ./network_launcher.sh up is used to launch the network
       ./network_launcher.sh down is used to take down the network
       ./network_launcher.sh remove is used to remove the images"
}

function validateArgs {
	if [ -z "${UP_DOWN}" ]; then
		echo "up/down/remove not mentioned"
		printHelp
		exit 1
	fi
        if [ "${UP_DOWN}" == "down" ]; then
		return
	fi
        if [ "${UP_DOWN}" == "remove" ]; then
                return
        fi
}

validateArgs

if [ "${UP_DOWN}" == "up" ]; then
        for i in orderer
        do
                j=peer
                k=ca
                TAG=$(curl -s -S 'https://registry.hub.docker.com/v2/repositories/rameshthoomu/fabric-'"$i"'-x86_64/tags/' | awk '{for(i=1;i<=NF;i++)if($i~/"name":/)print $(i+1)}' | grep "x86_64" | awk 'NR==1{print $1}' | tr -d "\"|,")
                CA_TAG=$(curl -s -S 'https://registry.hub.docker.com/v2/repositories/rameshthoomu/fabric-'"$k"'-x86_64/tags/' | awk '{for(i=1;i<=NF;i++)if($i~/"name":/)print $(i+1)}' | grep "x86_64" | awk 'NR==1{print $1}' | tr -d "\"|,")
                sed 's/\(.*fabric-'"$i"'-x86_64\)\(.*\)/\1:'"$TAG"'/;s/\(.*fabric-'"$j"'-x86_64\)\(.*\)/\1:'"$TAG"'/;s/\(.*fabric-'"$k"'-x86_64\)\(.*\)/\1:'"$CA_TAG"'/' docker-compose.yml > docker-compose.yml.tmp
                cp docker-compose.yml.tmp docker-compose.yml
                rm docker-compose.yml.tmp
                echo "====================Pulling CCENV Image===================="
                docker pull rameshthoomu/fabric-ccenv-x86_64:$TAG
                docker tag rameshthoomu/fabric-ccenv-x86_64:$TAG hyperledger/fabric-ccenv:$TAG
        done
        echo "====================Starting the Network===================="
        docker-compose -f docker-compose.yml up -d

elif [ "${UP_DOWN}" == "down" ]; then ##Clean up the network
	docker-compose -f docker-compose.yml down
        #rm -rf keyValStore chaincodeID
        #Cleanup the chaincode containers
	docker-compose down
	#Cleanup the unwated images
	#docker rmi -f $(docker images | grep "" | awk '{print $3}') 

elif [ "${UP_DOWN}" == "remove" ]; then
        docker rmi -f $(docker images | grep rameshthoomu)

else
	printHelp
	exit 1
fi
