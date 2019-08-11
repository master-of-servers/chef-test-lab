Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  # SSH keys to transfer chef data from server to workstation
  config.vm.provision "file", source: "files/chef_env_rsa", destination: "/home/vagrant/.ssh/chef_env_rsa"
  config.vm.provision "file", source: "files/chef_env_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"
  config.vm.define :chef_server do |chef_server|
    chef_server.vm.network :private_network, ip: '10.42.42.10'
    chef_server.vm.hostname = 'chef-server'
    chef_server.vm.provision "shell", inline: <<-SHELL
      # Add all applicable hosts
      echo "10.42.42.10 chef-server" | tee -a /etc/hosts
      echo "10.42.42.11 chef-workstation" | tee -a /etc/hosts
      echo "10.42.42.12 chef-agent-1" | tee -a /etc/hosts
      echo "10.42.42.13 chef-agent-2" | tee -a /etc/hosts
      echo "10.42.42.14 chef-agent-3" | tee -a /etc/hosts

      # Modify sshd to accomodate password auth
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config

      wget https://packages.chef.io/files/current/chef-server/12.19.29/ubuntu/18.04/chef-server-core_12.19.29-1_amd64.deb
      dpkg -i chef-server-core_12.19.29-1_amd64.deb
      chef-server-ctl reconfigure

      # Install the management console
      echo 'Installing management console'
      chef-server-ctl install chef-manage
      chef-server-ctl reconfigure
      chef-server-ctl reconfigure
      opscode-manage-ctl reconfigure --accept-license

      echo 'Creating pem files associated with chef environment in /etc/chef'
      chef-server-ctl user-create admin An Admin admin@my.org p@ssw0rd1 --filename /etc/chef/admin.pem
      chef-server-ctl org-create my_org my_org --association_user admin --filename /etc/chef/my_org-validator.pem
      # Create second org
      chef-server-ctl org-create awesome_org --association_user admin
      cd /etc/chef; tar -zcvf knife_admin_key.tar.gz . --warning=no-file-changed
      cp /etc/chef/knife_admin_key.tar.gz /home/vagrant; chown vagrant:vagrant /home/vagrant/knife_admin_key.tar.gz

      # Restart ssh to accomodate password auth
      echo "Restarting ssh service on chef-server"
      service sshd restart
    SHELL

    chef_server.vm.provider :virtualbox do |vm|
      vm.customize [
        "modifyvm", :id,
        "--memory", 2048,
        "--cpus", "2"
      ]
    end
  end

  config.vm.define :chef_agent_1 do |chef_agent_1|
    chef_agent_1.vm.network :private_network, ip: '10.42.42.12'
    chef_agent_1.vm.hostname = 'chef-agent-1'
    chef_agent_1.vm.provision "shell", inline: <<-SHELL
      # Add all applicable hosts
      echo "10.42.42.10 chef-server" | tee -a /etc/hosts
      echo "10.42.42.11 chef-workstation" | tee -a /etc/hosts
      echo "10.42.42.12 chef-agent-1" | tee -a /etc/hosts
      echo "10.42.42.13 chef-agent-2" | tee -a /etc/hosts
      echo "10.42.42.14 chef-agent-3" | tee -a /etc/hosts

      # Modify sshd to accomodate password auth
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config

      # Restart ssh to accomodate password auth
      echo "Restarting ssh service on chef-agent-1"
      service sshd restart

      echo "Lab environment has been created!"
    SHELL
  end

  config.vm.define :chef_agent_2 do |chef_agent_2|
    chef_agent_2.vm.network :private_network, ip: '10.42.42.13'
    chef_agent_2.vm.hostname = 'chef-agent-2'
    chef_agent_2.vm.provision "shell", inline: <<-SHELL
      # Add all applicable hosts
      echo "10.42.42.10 chef-server" | tee -a /etc/hosts
      echo "10.42.42.11 chef-workstation" | tee -a /etc/hosts
      echo "10.42.42.12 chef-agent-1" | tee -a /etc/hosts
      echo "10.42.42.13 chef-agent-2" | tee -a /etc/hosts
      echo "10.42.42.14 chef-agent-3" | tee -a /etc/hosts

      # Modify sshd to accomodate password auth
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config

      # Restart ssh to accomodate password auth
      echo "Restarting ssh service on chef-agent-2"
      service sshd restart

      echo "Lab environment has been created!"
    SHELL
  end

  config.vm.define :chef_agent_3 do |chef_agent_3|
    chef_agent_3.vm.network :private_network, ip: '10.42.42.14'
    chef_agent_3.vm.hostname = 'chef-agent-3'
    chef_agent_3.vm.provision "shell", inline: <<-SHELL
      # Add all applicable hosts
      echo "10.42.42.10 chef-server" | tee -a /etc/hosts
      echo "10.42.42.11 chef-workstation" | tee -a /etc/hosts
      echo "10.42.42.12 chef-agent-1" | tee -a /etc/hosts
      echo "10.42.42.13 chef-agent-2" | tee -a /etc/hosts
      echo "10.42.42.14 chef-agent-3" | tee -a /etc/hosts

      # Modify sshd to accomodate password auth
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config

      # Restart ssh to accomodate password auth
      echo "Restarting ssh service on chef-agent-3"
      service sshd restart

      echo "Lab environment has been created!"
    SHELL
  end

  config.vm.define :chef_workstation do |chef_workstation|
    chef_workstation.vm.network :private_network, ip: '10.42.42.11'
    chef_workstation.vm.hostname = 'chef-workstation'
    chef_workstation.vm.provision "file", source: "files/knife.rb", destination: "/home/vagrant/knife.rb"
    chef_workstation.vm.provision "file", source: "files/hello", destination: "/home/vagrant/hello"
    chef_workstation.vm.provision "shell", inline: <<-SHELL
      # Add all applicable hosts
      echo "10.42.42.10 chef-server" | tee -a /etc/hosts
      echo "10.42.42.11 chef-workstation" | tee -a /etc/hosts
      echo "10.42.42.12 chef-agent-1" | tee -a /etc/hosts
      echo "10.42.42.13 chef-agent-2" | tee -a /etc/hosts
      echo "10.42.42.14 chef-agent-3" | tee -a /etc/hosts

      apt update	
      apt-get install -y unzip make gcc 

      # Modify sshd to accomodate password auth
      sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sed -ri 's/UsePAM\syes/#UsePAM yes/g' /etc/ssh/sshd_config

      wget https://packages.chef.io/files/stable/chef-workstation/0.2.48/ubuntu/18.04/chef-workstation_0.2.48-1_amd64.deb
      dpkg -i chef-workstation_0.2.48-1_amd64.deb

      # Fix issue with knife bootstrap
      echo "Fixing issues with knife bootstrap"
      /usr/bin/chef gem install rbnacl -v '<5.0'
      /usr/bin/chef gem install rbnacl-libsodium
      /usr/bin/chef gem install bcrypt_pbkdf -v '<2.0'

      # Create chef workspace
      mkdir -p /root/.chef/{cookbooks,data_bags}
      
      mv /home/vagrant/knife.rb /root/.chef

      scp -o StrictHostKeyChecking=no -i /home/vagrant/.ssh/chef_env_rsa vagrant@chef-server:/etc/chef/knife_admin_key.tar.gz /home/vagrant
      mv /home/vagrant/knife_admin_key.tar.gz /root/.chef
      cd /root/.chef; tar -xvf knife_admin_key.tar.gz
      # Fix 401 by enabling validator-less bootstraps
      rm /root/.chef/my_org-validator.pem
      cd /root/.chef; knife ssl fetch

      # Create secret
      knife vault create secret_vault mysql_pw '{\"user\": \"mysql\", \"password\": \"TheM0stS3cr3T!!!\"}'

      # Show secret
      knife vault show secret_vault mysql_pw
      
      # Move hello cookbook into place
      mv /home/vagrant/hello /root/.chef/cookbooks
      # Upload hello cookbook to chef server
      knife upload cookbooks
      cd /root/.chef/cookbooks
      # Get chef-client cookbook
      knife supermarket download chef-client && tar -xvf chef-client-*; rm *tar*
      # Get chef-client cookbook dependencies
      cp hello/Berksfile chef-client/ && cd chef-client && berks install && berks upload
      # Bootstrap chef-agent-1
      cd /root/.chef; /usr/bin/knife bootstrap chef-agent-1 -x vagrant -P vagrant --sudo -N chef-agent-1 --run-list 'recipe[hello], recipe[chef-client::config]'
      # Bootstrap chef-agent-2
      cd /root/.chef; /usr/bin/knife bootstrap chef-agent-2 -x vagrant -P vagrant --sudo -N chef-agent-2 --run-list 'recipe[hello], recipe[chef-client::config]'
      # Bootstrap chef-agent-3
      cd /root/.chef; /usr/bin/knife bootstrap chef-agent-3 -x vagrant -P vagrant --sudo -N chef-agent-3 --run-list 'recipe[hello], recipe[chef-client::config]'

      # Restart ssh to accomodate password auth
      echo "Restarting ssh service on chef-workstation"
      service sshd restart
    SHELL
  end
end
