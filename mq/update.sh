docker build --tag=refactoritskibm/mq:9.3.5.0 .
docker push refactoritskibm/mq:9.3.5.0
docker pull refactoritskibm/mq:9.3.5.0
docker container stop QM1
docker container rm QM1
docker run -dt --name QM1 refactoritskibm/mq:9.3.5.0
docker network connect my-network QM1
docker network inspect my-network
docker exec -ti QM1 bash