# docker-gollum

This Dockerfile is a simply install [gollum](https://github.com/gollum/gollum).


## Installation
	docker pull suttang/gollum

## Usage

### Run container simply

    sudo docker run -d -P --name gollum suttang/gollum

    # Check container port
    sudo docker port gollum
    # 0.0.0.0:49157

    wget http://localhost:49157

### Change port to 80

    sudo docker run -d -p 80:4567 --name gollum suttang/gollum
    wget http://localhost

### You can attach some options

	sudo docker run -d -P --name gollum suttang/gollum --allow-uploads --live-preview

To add more options , checkout this link [gollum options](https://github.com/gollum/gollum#running).

### Use wikidata in host filesystem

	# Create and initialize wikidata
	mkdir ~/wikidata
	git init ~/wikidata

	sudo docker run -d -P -v ~/wikidata:/root/wikidata suttang/gollum

### Load config file

	# Create and initialize wikidata
	mkdir ~/wikidata
	git init ~/wikidata

	# Create config.rb
	vi ~/config.rb

	sudo docker run -d -P -v ~/wikidata:/root/wikidata suttang/gollum --config /root/wikidata/config.rb

### Use a data volume

    docker create -v /root/wikidata --name gollum-store senften/gollum /bin/true
	docker run -d --volumes-from gollum-store  -p 4567:4567 --name gollum senften/gollum --h1-title --show-all --css

#### To Manage the Volume

    docker run -i -t --entrypoint=/bin/bash --rm --volumes-from gollum-store senften/gollum
	docker cp ~/.ssh/id_rsa dazzling_cori:/root/.ssh/id_rsa

### Use nginx-proxy

	sudo docker run -d -P --name gollum -v ~/wikidata:/root/wikidata -e VIRTUAL_HOST=wiki.example.com -e VIRTUAL_PORT=80 -p 80 suttang/gollum --allow-uploads --config /root/wikidata/config.rb --port 80

[nginx-proxy](https://github.com/jwilder/nginx-proxy)

### Customize suttang/gollum image

	sudo docker run -t -i --entrypoint="/bin/bash" suttang/gollum

	# execute some commands in container's shell

	sudo docker commit -m "customized suttang/gollum by myself" CONTAINER_ID YOURNAME/gollum

or create new Dockerfile with `FROM suttang/gollum`
