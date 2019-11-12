FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
      apt-get install -y vim ssh && \
      mkdir /var/run/sshd && \
      chmod 0755 /var/run/sshd && \
      echo "root:toor" | chpasswd && \
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config && \
      sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
      #wget https://packages.chef.io/files/stable/chef/14.10.9/ubuntu/18.04/chef_14.10.9-1_amd64.deb && \
      #dpkg -i chef_14.10.9-1_amd64.deb && \
      #rm chef-server*.deb && \
      rm -rf /var/lib/apt/lists/

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]