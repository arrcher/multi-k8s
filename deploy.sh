docker build -t arrcher/multi-client:latest -t arrcher/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arrcher/multi-server:latest -t arrcher/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arrcher/multi-worker:latest -t arrcher/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arrcher/multi-client:latest
docker push arrcher/multi-server:latest
docker push arrcher/multi-worker:latest

docker push arrcher/multi-client:$SHA
docker push arrcher/multi-server:$SHA
docker push arrcher/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arrcher/multi-server:$SHA
kubectl set image deployments/client-deployment client=arrcher/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arrcher/multi-worker:$SHA
