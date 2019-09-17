FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
      apt-get install -y vim ssh && \
      echo "root:toor" | chpasswd && \
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config; && \
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config; && \
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config; && \
      service ssh start && \
      #wget https://packages.chef.io/files/stable/chef/14.10.9/ubuntu/18.04/chef_14.10.9-1_amd64.deb && \
      #dpkg -i chef_14.10.9-1_amd64.deb && \
      #rm chef-server*.deb && \
      rm -rf /var/lib/apt/lists/

ENTRYPOINT /bin/bash