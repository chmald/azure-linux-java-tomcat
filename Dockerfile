FROM tomcat:8.5-jre8

RUN mkdir /app
ADD . /app

# Configure ports
EXPOSE 8080 2222

# SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd

#Copy the sshd_config file to its new location
COPY sshd_config /etc/ssh/

# Copy init_container.sh to the /bin directory
#COPY init_container.sh /bin/

COPY tomcat-users.xml /usr/local/tomcat/conf/

COPY myapp.war /usr/local/tomcat/webapps/
RUN chmod 755 /usr/local/tomcat/webapps/myapp.war 

COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/

# Run the chmod command to change permissions on above file in the /bin directory
#RUN chmod 755 /bin/init_container.sh 

WORKDIR /usr/local/tomcat

RUN /etc/init.d/ssh restart