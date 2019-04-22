all: install

install:
	ansible-playbook playbooks/install.yaml -K
