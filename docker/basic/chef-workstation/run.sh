#!/bin/bash

go_to_sleep() {
  echo "Beginning sleep on chef workstation for 8 minutes."
  sleep 480
  echo "Ending sleep for chef workstation"
}

init_workstation(){
  cd /root/.chef
  mkdir -p /root/.chef/cookbooks
  knife ssl fetch
  cd cookbooks
  knife supermarket download chef-client && tar -xvf chef-client-*; rm *tar*
  cp hello/Berksfile chef-client
  cd chef-client
  berks install
  berks upload
  cd /root/.chef
  knife upload cookbooks
  #tar -xvf knife_admin_key.tar.gz; rm *tar*
  knife bootstrap chef-agent-1 -u root -P toor --sudo -N chef-agent-1 --run-list 'recipe[hello], recipe[chef-client::config]'
}

add_secret(){
  cd /root/.chef
  rm -rf data_bags
  mkdir data_bags
  knife vault create secret_vault mysql_pw '{"user": "mysql", "password": "TheM0stS3cr3T!!!"}'
  knife vault show secret_vault mysql_pw
}

go_to_sleep
init_workstation
add_secret