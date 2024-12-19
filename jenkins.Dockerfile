FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update && apt-get install -y maven

ENV MAVEN_HOME=/usr/share/maven
ENV PATH=$MAVEN_HOME/bin:$PATH

COPY Sonar-Analysis-Code /var/jenkins_home/jobs/Sonar-Analysis-Code
