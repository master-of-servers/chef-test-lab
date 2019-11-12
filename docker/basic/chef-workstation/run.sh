#!/bin/bash

countdown_timer() {
  hour=0
  min=0
  sec=480
  while [ $hour -ge 0 ]; do
    while [ $min -ge 0 ]; do
      while [ $sec -ge 0 ]; do
        echo -ne "$hour:$min:$sec3[0K\r"
        let "sec=sec-1"
        sleep 1
      done
      sec=59
      let "min=min-1"
    done
    min=59
    let "hour=hour-1"
  done
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
  tar -xvf knife_admin_key.tar.gz; rm *tar* 
  knife bootstrap chef-agent-1 -u root -P toor --sudo -N chef-agent-1 --run-list 'recipe[hello], recipe[chef-client::config]' --chef-license accept
}

add_secret(){
  mkdir data_bags
  knife vault create secret_vault mysql_pw '{\"user\": \"mysql\", \"password\": \"TheM0stS3cr3T!!!\"}'
  knife vault show secret_vault mysql_pw
}

countdown_timer
init_workstation
add_secret