FROM chef/chefworkstation

COPY files/hello/ /hello/
COPY chef-workstation/run.sh /usr/local/bin/

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
      apt-get install -y iproute2 iputils-ping ssh sudo vim wget && \
      mkdir /var/run/sshd && \
      chmod 0755 /var/run/sshd && \
      mkdir -p /root/.berkshelf && \
      mkdir -p /root/.chef/cookbooks && \
      mkdir -p /root/.chef/data_bags && \
      echo "root:toor" | chpasswd && \
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config && \
      wget https://packages.chef.io/files/stable/chef/14.10.9/ubuntu/18.04/chef_14.10.9-1_amd64.deb && \
      dpkg -i chef_14.10.9-1_amd64.deb && \
      rm chef*.deb && \
      mkdir /root/.ssh/ && \
      touch /root/.ssh/authorized_keys && \
      rm -rf /var/lib/apt/lists/*

COPY files/config.json /root/.berkshelf

CMD run.sh; /usr/sbin/sshd -D
