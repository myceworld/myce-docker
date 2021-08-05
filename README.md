# RUN DOCKER
This repository allows you to run a myce node quickly and with docker

## 1. Install Docker
https://docs.docker.com/engine/install/ubuntu/

## 2. Build
	docker build -t mycewallet:1.0.0 .

## 3. Creating volumes
	docker volume create myce_data_1
	docker volume create myce_data_2
	docker volume create myce_data_3
	docker volume create myce_data_4

## 4. Running several nodes (changing folder and entry port)
	docker run -d -p 4515:4515 -v myce_data_1:/myce/.myce --name wallet mycewallet:1.0.0
	docker run -d -p 4516:4515 -v myce_data_2:/myce/.myce --name wallet2 mycewallet:1.0.0
	docker run -d -p 4517:4515 -v myce_data_3:/myce/.myce --name wallet3 mycewallet:1.0.0
	docker run -d -p 4518:4515 -v myce_data_4:/myce/.myce --name wallet4 mycewallet:1.0.0

## 5. Test
	curl --data-binary '{"jsonrpc": "1.0", "id":"1", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://username:password@localhost:4515
	curl --data-binary '{"jsonrpc": "1.0", "id":"1", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://username:password@localhost:4516
	curl --data-binary '{"jsonrpc": "1.0", "id":"1", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://username:password@localhost:4517
	curl --data-binary '{"jsonrpc": "1.0", "id":"1", "method": "getblockchaininfo", "params": [] }' -H 'content-type: text/plain;' http://username:password@localhost:4518


## issues

### connection reset by peer
	When I connect the second node or any new node, I have this error `connection reset by peer` and the node never syncs, to solve this issue you need to do the next
	1. stop all previous nodes
		`docker stop wallet`
	2. start new node (`n` being the number of the node)
		`docker run -d -p [4514+n]:4515 -v myce_data_[n]:/myce/.myce --name wallet[n] mycewallet:1.0.0`
	3. then start all previous nodes
		`docker start wallet[n]`
