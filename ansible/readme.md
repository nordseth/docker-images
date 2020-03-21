Ansible image with some tools. Primarly use is running on windows for managing kubernetes clusters.
Includes kubectl, helm and some image utils.

Has a entrypoint scripts that mounts id_rsa, id_rsa.pub and known_hosts from /tmp/.ssh to /root/.ssh.

Example for running:

docker run --rm -it -v $HOME/.ssh/:/tmp/.ssh/ -v $ANSIBLE_FOLDER:/ansible nordseth/ansible

