. ./environment.sh
. ./org1.sh

for i in $(seq 1 $1)
do
	strsize=$(( $RANDOM % 2000 ))
	teststr=$(xxd -l $strsize -c $strsize -p < /dev/random)
        peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"UpdateAsset","Args":["asset6","white", "3","'"$teststr"'","15"]}' 
	sleep $(( $RANDOM % 10 ))
done
