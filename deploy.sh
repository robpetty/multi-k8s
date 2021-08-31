docker build -t rpetty2012/multi-client:latest -t rpetty2012/mutli-client:$SHA -f ./client/Dockerfile ./client
docker build -t rpetty2012/multi-server:latest -t rpetty2012/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rpetty2012/multi-worker:latest -t rpetty2012/mutli-worker:$SHA -f ./worker/Dokcerfile ./worker
docker push rpetty2012/multi-client:latest
docker push rpetty2012/multi-server:latest
docker push rpetty2012/multi-worker:latest
docker push rpetty2012/multi-client:$SHA
docker push rpetty2012/multi-server:$SHA
docker push rpetty2012/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rpetty2012/multi-server:$SHA
kubectl set image deployments/client-deployment client=rpetty2012/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rpetty2012/multi-worker:$SHA