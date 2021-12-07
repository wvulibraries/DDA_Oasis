FROM ruby:2.7.5

ENV BUNDLER_VERSION=2.2.27
ENV RAILS_VERSION=5.2.6

WORKDIR /home/oasisform
ADD ./oasisform /home/oasisform

RUN apt-get update

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Use JEMALLOC instead
# JEMalloc is a faster garbage collection for Ruby.
# -------------------------------------------------------------------------------------------------
RUN apt-get install -y libjemalloc2 libjemalloc-dev
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so

RUN \
  gem update --system --quiet && \
  gem install bundler -v ${BUNDLER_VERSION} && \
  gem install rails -v ${RAILS_VERSION} && \
  bundle install --jobs=4 --retry=3

# Node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - \
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