FROM ruby:latest

RUN apt-get update && apt-get -y install curl

# configure java runtime
ENV JAVA_HOME=/opt/jdk-9 \
    JAVA_VERSION_MAJOR=9 \
    JAVA_VERSION_MINOR=ea+143

RUN mkdir -p /opt \
  && curl --fail --silent --location --retry 3 \
  http://www.java.net/download/java/jdk9/archive/143/binaries/jdk-${JAVA_VERSION_MAJOR}-${JAVA_VERSION_MINOR}_linux-x64_bin.tar.gz \
  | gunzip \
  | tar -x -C /opt

RUN ${JAVA_HOME}/bin/jlink --module-path /opt/jdk-9/jmods/ --add-modules java.logging,java.compiler --output /opt/java && \
  rm -Rf ${JAVA_HOME}
  
RUN apt-get purge --auto-remove -y curl

ENV JAVA_HOME=/opt/java \
PATH=$PATH:/opt/java/bin

CMD ["java"]