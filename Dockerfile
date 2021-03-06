FROM php:7.4-apache
COPY index.html /var/www/html/
COPY script.sh script.sh
RUN chmod +x script.sh

EXPOSE 80 2222

    # Install OpenSSH and set the password for root to "Docker!". In this example, "apk add" is the install instruction for an Alpine Linux-based image.
RUN apt-get update \
    && apt install openssh-server -y \
    && echo "root:Docker!" | chpasswd 

# Copy the sshd_config file to the /etc/ssh/ directory
COPY sshd_config /etc/ssh/

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)
    
#CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

CMD ["./script.sh"]


