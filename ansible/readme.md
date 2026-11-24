Ansible image with some tools. Primarly use is running on windows for managing kubernetes clusters.
Includes kubectl, helm and some image utils.

Has an entrypoint script that copies SSH keys (id_rsa, id_ed25519, ... and their .pub files) from /tmp/.ssh to /root/.ssh, and points ssh at /tmp/.ssh/known_hosts.

Example for running:

docker run --rm -it -v $HOME/.ssh/:/tmp/.ssh/ -v $ANSIBLE_FOLDER:/ansible nordseth/ansible

