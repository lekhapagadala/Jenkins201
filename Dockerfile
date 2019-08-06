FROM maven:3.6-jdk-8

MAINTAINER Avinash Seelam

WORKDIR /maven-webapp-project

# Prepare by downloading dependencies
ADD pom.xml /maven-webapp-project/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /maven-webapp-project/src
RUN ["mvn", "package"]

#Running the website in the build in tomcat
CMD ["mvn", "tomcat7:run"]
