FROM java:openjdk-8-alpine

ARG BUILDR_VERSION=1.5.0

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk update && \
  apk add jruby jruby-irb jruby-minitest jruby-rdoc jruby-rake jruby-testunit
  
ENV PATH $PATH:/usr/share/jruby/bin

RUN gem install --no-rdoc --no-ri bundler && gem install --no-rdoc --no-ri buildr -v=${BUILDR_VERSION}

CMD ["buildr"]