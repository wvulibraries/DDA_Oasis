FROM ruby:2.6.2

# Install our dependencies and rails
RUN \
    gem install bundler \
    && gem install rails \
    && mkdir -p /home/oasisform

# update and install dependencies
RUN apt-get update

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs
    
WORKDIR /home/oasisform
ADD . /home/oasisform
RUN bundle install

ADD ./startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]