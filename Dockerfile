FROM tomcat:8.5-jre8

RUN mkdir /code
WORKDIR /code

# SSH
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd

# Configure ports
EXPOSE 8080 2222

#Copy the sshd_config file to its new location
COPY sshd_config /etc/ssh/

# Start the SSH service
RUN service ssh start