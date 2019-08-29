FROM maven:3.6-jdk-8

MAINTAINER Deepak Kattamuru

WORKDIR /devops

# Prepare by downloading dependencies
ADD pom.xml /devops/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /devops/src
RUN ["mvn", "package"]

#Running the website in the build in tomcat
CMD ["mvn", "tomcat7:run"]
