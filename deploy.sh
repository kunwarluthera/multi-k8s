docker build -t kunwarluthera/multi-client:latest -t kunwarluthera/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kunwarluthera/multi-server:latest -t kunwarluthera/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kunwarluthera/multi-worker:latest -t kunwarluthera/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kunwarluthera/multi-client:latest
docker push kunwarluthera/multi-server:latest
docker push kunwarluthera/multi-worker:latest
docker push kunwarluthera/multi-client:$SHA
docker push kunwarluthera/multi-server:$SHA
docker push kunwarluthera/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kunwarluthera/multi-server:$SHA
kubectl set image deployments/client-deployment client=kunwarluthera/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kunwarluthera/multi-worker:$SHA