FROM ruby

MAINTAINER Scott Senften <scott@senften.us>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y -q build-essential python python-docutils libicu-dev libreadline-dev libssl-dev zlib1g-dev git-core
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Install gollum
RUN gem install gollum redcarpet github-markdown

# Set up to be able to handle ssh if desired
RUN mkdir /root/.ssh
RUN chmod 700 /root/.ssh

RUN  echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config

# Set up cron
RUN apt-get update && apt-get install -y cron
#COPY hello-cron /etc/cron.d/hello-cron
#RUN crontab /etc/cron.d/hello-cron
COPY gitpullpush.sh /root
RUN chmod 777 /root/gitpullpush.sh
COPY wiki-git-cron /etc/cron.d/wiki-git-cron
RUN crontab /etc/cron.d/wiki-git-cron

# Initialize wiki data
RUN mkdir /root/wikidata
RUN git init /root/wikidata

# Expose default gollum port 4567
EXPOSE 4567

ENTRYPOINT ["/usr/local/bundle/bin/gollum", "/root/wikidata"]