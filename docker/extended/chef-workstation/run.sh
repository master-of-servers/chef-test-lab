#!/bin/bash

go_to_sleep()
              {
    echo "Beginning sleep on chef workstation for 10 minutes."
    sleep 600
    echo "Ending sleep for chef workstation"
}

init_workstation()
                  {
    mkdir -p /root/.chef/cookbooks
    cd /root/.chef/cookbooks || exit
    knife ssl fetch
    mv /hello hello
    knife supermarket download chef-client && tar -xvf chef-client-*
    rm ./*tar*
    cp hello/Berksfile chef-client
    cd chef-client || exit
    berks install
    berks upload
    cd /root/.chef || exit
    knife upload cookbooks
    # Needed to enroll the workstation as an agent
    service ssh start
    knife bootstrap webserver -u root -P toor --sudo -N webserver --run-list 'recipe[hello], recipe[chef-client::config]'
    knife bootstrap devsystem -u root -P toor --sudo -N devsystem --run-list 'recipe[chef-client::config]'
    knife bootstrap chef-workstation -u root -P toor --sudo -N chef-workstation --run-list 'recipe[chef-client::config]'
}

add_secret()
            {
    cd /root/.chef || exit
    rm -rf data_bags
    mkdir data_bags
    knife vault create secret_vault mariadb_pw '{"user": "root", "password": "TheM0stS3cr3T!!!"}'
    knife vault show secret_vault mariadb_pw
}

go_to_sleep
init_workstation
add_secret
