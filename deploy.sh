docker build -t eladmz/multi-client:latest -t eladmz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eladmz/multi-server:latest -t eladmz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eladmz/multi-worker:latest -t eladmz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eladmz/multi-client:latest
docker push eladmz/multi-server:latest
docker push eladmz/multi-worker:latest

docker push eladmz/multi-client:$SHA
docker push eladmz/multi-server:$SHA
docker push eladmz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=eladmz/multi-client:$SHA
kubectl set image deployments/server-deployment server=eladmz/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=eladmz/multi-worker:$SHA