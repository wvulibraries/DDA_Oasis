FROM ruby:2.6.2

# Install our dependencies and rails
RUN \
    gem install bundler \
    && gem install rails \
    && mkdir -p /home/oasisform

# update and install dependencies
RUN apt-get update

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn
    
WORKDIR /home/oasisform
ADD . /home/oasisform
RUN bundle install

ADD ./startup.sh /usr/bin/
RUN chmod -v +x /usr/bin/startup.sh
ENTRYPOINT ["/usr/bin/startup.sh"]