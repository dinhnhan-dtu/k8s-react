docker build -t atdinhnhan/multi-client:latest -t atdinhnhan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t atdinhnhan/multi-server:latest -t atdinhnhan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t atdinhnhan/multi-worker:latest -t atdinhnhan/multi-worker:$SHA -f ./server/Dockerfile ./worker
docker push atdinhnhan/multi-client:latest
docker push atdinhnhan/multi-server:latest
docker push atdinhnhan/multi-worker:latest

docker push atdinhnhan/multi-client:$SHA
docker push atdinhnhan/multi-server:$SHA
docker push atdinhnhan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=atdinhnhan/multi-server:$SHA
kubectl set image deployment/client-deployment client=atdinhnhan/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=atdinhnhan/multi-worker:$SHA