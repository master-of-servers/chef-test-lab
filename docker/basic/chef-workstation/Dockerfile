FROM chef/chefdk@sha256:d65c2597802d4a7336cd43cb3ed706701fcc9bdde122e53eacdead8b21a13591

COPY files/hello/ /hello/
COPY chef-workstation/run.sh /usr/local/bin/

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
      apt-get install -y ssh vim iproute2 wget && \
      mkdir -p /root/.chef/cookbooks && \
      mkdir -p /root/.chef/data_bags && \
      echo "root:toor" | chpasswd && \
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config && \
      service ssh start && \
      rm -rf /var/lib/apt/lists/*

CMD run.sh; /usr/sbin/sshd -D
