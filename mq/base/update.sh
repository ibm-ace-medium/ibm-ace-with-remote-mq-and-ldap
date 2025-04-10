docker build --tag=refactoritskibm/mq-install:9.3.5.0 .
docker push refactoritskibm/mq-install:9.3.5.0
#sudo docker container stop QM1
#sudo docker container rm QM1
#sudo docker run -dt --name QM1 my-docker-repository/mq-install:9.3.5.0
#sudo docker exec -ti QM1 bash