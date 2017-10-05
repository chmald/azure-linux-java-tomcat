FROM tomcat:8.5-jre8

RUN mkdir /app
ADD . /app
WORKDIR /app

# Configure ports
EXPOSE 8080 2222

# SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
        vim \
    && echo "root:Docker!" | chpasswd

RUN mkdir -p /home/LogFiles

# Copy the sshd_config file to its new location
COPY sshd_config /etc/ssh/

# Copy init_container.sh to the /bin directory
COPY init_container.sh /bin/

# Tomcat files
COPY tomcat-users.xml /usr/local/tomcat/conf/
COPY myapp.war /usr/local/tomcat/webapps/
RUN chmod 755 /usr/local/tomcat/webapps/myapp.war 
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/

# Copy supervisor config to ./conf.d directory
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf	

# Run the chmod command to change permissions on above file in the /bin directory
RUN chmod 755 /bin/init_container.sh

#WORKDIR /usr/local/tomcat

CMD ["/bin/init_container.sh"]