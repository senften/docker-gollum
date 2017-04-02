FROM ruby:2.2

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

# Initialize wiki data
RUN mkdir /root/wikidata
RUN git init /root/wikidata

# Expose default gollum port 4567
EXPOSE 4567

ENTRYPOINT ["/usr/local/bundle/bin/gollum", "/root/wikidata"]