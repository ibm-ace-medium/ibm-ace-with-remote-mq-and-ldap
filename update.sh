# Build base image for all other images with necessary tools
#sudo docker build --no-cache --tag=my-docker-repository/rhel-base ./rhel

# Build Apache DS
#sudo docker build --no-cache --tag=my-docker-repository/apache-ds:AM26 ./apache-ds

# Build MQ base image
#sudo docker build --no-cache --tag=my-docker-repository/mq-install:9.3.5.0 ./mq/base

# Build ACE base image
#sudo docker build --no-cache --tag=my-docker-repository/ace-install:12.0.12.2 ./ace/base

sudo docker compose down
sudo docker compose up -d --build --remove-orphans --force-recreate
#sudo docker compose logs -f
sudo docker compose exec -ti ace bash