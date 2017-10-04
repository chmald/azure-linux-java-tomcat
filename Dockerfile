FROM tomcat:8.5-jre8

RUN mkdir /code
WORKDIR /code

# SSH
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "$SSH_PASSWD" | chpasswd

COPY sshd_config /etc/ssh/
EXPOSE 8080 2222

RUN service ssh start