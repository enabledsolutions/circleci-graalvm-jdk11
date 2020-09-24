# vim:set ft=dockerfile:

FROM cimg/base:2020.06

LABEL maintainer="Enabled Solutions <dev@enabled.com.au>"

ENV JAVA_VERSION 11.0.8
ENV URL https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java11-linux-amd64-20.2.0.tar.gz
ENV JAVA_HOME /usr/local/jdk-${JAVA_VERSION}
ENV GRAALVM_HOME /usr/local/jdk-${JAVA_VERSION}

RUN curl -sSL -o java.tar.gz "${URL}" && \
	sudo mkdir /usr/local/jdk-${JAVA_VERSION} && \
	sudo tar -xzf java.tar.gz --strip-components=1 -C /usr/local/jdk-${JAVA_VERSION} && \
	rm java.tar.gz && \
	# The dual version command is to support OpenJDK 8
	${JAVA_HOME}/bin/java --version || ${JAVA_HOME}/bin/java -version && \
	${JAVA_HOME}/bin/javac --version || ${JAVA_HOME}/bin/javac -version && \
	sudo ${GRAALVM_HOME}/bin/gu install native-image

ENV PATH /usr/local/jdk-${JAVA_VERSION}/bin:$PATH

ENV MAVEN_VERSION=3.6.3 \
	PATH=/opt/apache-maven/bin:$PATH
RUN dl_URL="https://www.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" && \
	curl -sSL --fail --retry 3 $dl_URL -o apache-maven.tar.gz && \
	sudo tar -xzf apache-maven.tar.gz -C /opt/ && \
	rm apache-maven.tar.gz && \
	sudo ln -s /opt/apache-maven-* /opt/apache-maven && \
	mvn --version

ENV GRADLE_VERSION=6.4.1 \
	PATH=/opt/gradle/bin:$PATH
RUN dl_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
	curl -sSL --fail --retry 3 $dl_URL -o gradle.zip && \
	sudo unzip -d /opt gradle.zip && \
	rm gradle.zip && \
	sudo ln -s /opt/gradle-* /opt/gradle && \
	gradle --version
