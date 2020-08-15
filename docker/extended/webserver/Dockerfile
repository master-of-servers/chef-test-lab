FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
      apt-get install -y \
      mysql-client \
      nginx \
      php7.2 php7.2-fpm php7.2-cli php7.2-curl php7.2-mysql php7.2-curl php7.2-gd php7.2-mbstring php-pear \
      python \
      vim \
      ssh \
      sudo && \
      mkdir /var/run/sshd && \
      mkdir /root/.ssh/ && \
      chmod 0755 /var/run/sshd && \
      echo "root:toor" | chpasswd && \
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config && \
      sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd && \
      sed -i 's/listen = \/run\/php\/php.*.sock/listen = localhost:8080/' /etc/php/7.2/fpm/pool.d/www.conf && \
      wget https://packages.chef.io/files/stable/chef/14.10.9/ubuntu/18.04/chef_14.10.9-1_amd64.deb && \
      dpkg -i chef_14.10.9-1_amd64.deb && \
      rm chef*.deb && \
      rm -rf /var/lib/apt/lists/

RUN cd /var/www/html/ && \
      # Download pages from bsidessf.org for us to host
      wget \
      --recursive \
      --no-clobber \
      --page-requisites \
      --html-extension \
      --convert-links \
      --restrict-file-names=windows \
      --domains bsidessf.org \
      --no-parent \
      https://bsidessf.org; exit 0

RUN cd /var/www/html/ && \
      rm index.nginx-debian.html && \
      # Add test file
      echo "<?php phpinfo(); ?>" > /var/www/html/info.php && \
      mv bsidessf.org/* . && \
      rm -rf bsidessf.org

ADD files/default /etc/nginx/sites-available/default
ADD files/nginx.conf /etc/nginx/nginx.conf

EXPOSE 22
CMD service nginx start; service php7.2-fpm start; /usr/sbin/sshd -D
