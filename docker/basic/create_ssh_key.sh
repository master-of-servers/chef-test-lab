echo 'Creating your ssh public and private key, please wait...'

# Create public and private 2048 bit ssh key pair without pw prompt
 yes y | ssh-keygen -t rsa -b 2048 -f files/chef_env_rsa -N '' >/dev/null

 echo 'Done!'
