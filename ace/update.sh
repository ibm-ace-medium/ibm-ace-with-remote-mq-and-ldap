REPOSITORY_NAME=refactoritskibm
CONTAINER_NAME=ace:12.0.12.4

docker build --tag=${REPOSITORY_NAME}/${CONTAINER_NAME} .
docker push ${REPOSITORY_NAME}/${CONTAINER_NAME}

docker pull ${REPOSITORY_NAME}/${CONTAINER_NAME}
docker container stop ace
docker container rm ace
docker run -dt --name ace ${REPOSITORY_NAME}/${CONTAINER_NAME}
docker network connect my-network ace
docker network inspect my-network
docker exec -ti ace bash