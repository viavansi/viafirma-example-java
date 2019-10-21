FROM tomcat:jdk8-openjdk-slim
ADD ejemploViafirma.war /usr/local/tomcat/webapps
# ADD tomcat/server.xml /usr/local/tomcat/conf/server.xml
# ADD platform /viafirma/platform
EXPOSE 8080
CMD ["catalina.sh","run"]