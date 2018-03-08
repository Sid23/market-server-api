#Dockerfile
FROM phusion/passenger-ruby24
MAINTAINER Gabriele Gambotto <gambotto@leva.io>

# Ensure that our apt package list is updated and install a few
# packages to ensure that we can compile assets
RUN apt-get update && apt-get install -y -o Dpkg::Options::="--force-confold" \
nodejs  

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Prepare folders
RUN mkdir /home/app/webapp

# Run Bundle in a cache efficient way
WORKDIR /tmp
ADD ./rails/Gemfile      /tmp/
ADD ./rails/Gemfile.lock /tmp/

RUN bundle install 

# Add the Rails app
ADD ./rails/ /home/app/webapp

WORKDIR /home/app/webapp

RUN chown -R app:app /home/app/webapp

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
