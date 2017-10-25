FROM vimalathithen/alpine-glibc-x86:latest 

ENV JDK_URL=http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-i586.tar.gz
ENV JAVA_VERSION=1.8.0_151

ENV JAVA_HOME=/usr/java/jdk_${JAVA_VERSION}

ENV PATH=$JAVA_HOME/bin:$PATH

ADD ./ ./home

RUN  apk add --update --no-cache wget tar && \
    mkdir -p /usr/java \
    jdk_${JAVA_VERSION} && \
    wget --no-check-certificate --progress=dot:mega --header "Cookie: oraclelicense=accept-securebackup-cookie;" "$JDK_URL" -O jdk_${JAVA_VERSION}.tar.gz && \  
    tar xf jdk_${JAVA_VERSION}.tar.gz -C "jdk_${JAVA_VERSION}" --strip-components=1 && \
    mv "jdk_${JAVA_VERSION}" /usr/java/ && \
    ldconfig $JAVA_HOME/lib $JAVA_HOME/jre/lib && \
    ln -s "$JAVA_HOME/bin" /usr/bin
