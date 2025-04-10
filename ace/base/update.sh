docker build --tag=refactoritskibm/ace-with-mq-client-install:12.0.12.4 .
docker push refactoritskibm/ace-with-mq-client-install:12.0.12.4

#docker container stop ace
#docker container rm ace
#docker run -dt --name ace ivansla/rhel-ace-with-mq-client:12.0.12.4
#docker network connect my-network ace
#docker network inspect my-network
#docker exec -ti ace bash