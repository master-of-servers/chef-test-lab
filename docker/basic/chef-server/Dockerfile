FROM cbuisson/chef-server

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
      apt-get install -y vim ssh && \
      echo "root:toor" | chpasswd && \
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
      sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config && \
      service ssh start && \
      rm -rf /var/lib/apt/lists/

ENTRYPOINT /bin/bash