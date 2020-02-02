FROM ubuntu:14.04.5
LABEL authors="Maintained by Jayson Grace <jayson.e.grace@gmail.com, based on work by Clement Buisson <clement.buisson@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -yq --no-install-recommends wget curl ssh rsync && \
    mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    echo "root:toor" | chpasswd && \
    wget --no-check-certificate --content-disposition https://packages.chef.io/files/stable/chef-server/12.19.31/ubuntu/14.04/chef-server-core_12.19.31-1_amd64.deb && \
    dpkg -i chef-server*.deb && \
    rm chef-server*.deb && \
    apt-get remove -y wget && \
    sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    rm -rf /var/lib/apt/lists/*

COPY chef-server/run.sh chef-server/configure_chef.sh /usr/local/bin/
COPY files/knife.rb /etc/chef/knife.rb

VOLUME /var/log
CMD run.sh ; /usr/sbin/sshd -D
