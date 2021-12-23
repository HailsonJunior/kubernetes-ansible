# Highly Available Kubernetes cluster with Ansible

This repository contains Ansible roles that will help you to create an [Kubernetes](https://kubernetes.io/) highly available clusters with [HAProxy](https://www.haproxy.com/) for production environment using Ansible.

Requirements
------------
Requires a machine with [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed.

If you want to create it in AWS this repository contains [Terraform](https://www.terraform.io/) files that automates the creation of instances, so you will need to install Terraform.

How to Use
------------
Creating Instances
------------
If you are using AWS you can create the instances with Terraform.
In this setup we will use seven instances: 3 Managers, 3 Workers and 1 for HAProxy.

Steps:

- Set AWS environment variables

```sh
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-east-1
```
replace with your ACCESS KEY ID, SECRET ACCESS KEY and AWS region where do you want to create the resources.

- Init and execute Terraform apply

```sh
git clone https://github.com/HailsonJunior/kubernetes-ansible.git
cd kubernetes-ansible/terraform
terraform init
terraform apply
```
Creating Kubernetes Cluster
------------
To use the Ansible roles you will only need to use the playbook ```playbook-k8s.yml``` in kubernetes-ansible directory.

```sh
--
- name: Cluster K8s Multi Master With HAProxy
  hosts: 'all'
  any_errors_fatal: true
  become: yes
  become_method: sudo
  roles:
    - { role: prepare-environment, tags: ["prepare-environment"]}
    - { role: haproxy, tags: ["haproxy"]}
    - { role: k8s, tags: ["k8s"]}

... 
```

If you have not created the instances using Terraform files from this repository will be needed to edit the Ansible inventory file replacing the IPs ```kubernetes-ansible/inventory.ini``` according to your environment. It will also be necessary to edit the steps "Configure frontend and backend" on ```kubernetes-ansible/roles/haproxy/tasks/install-haproxy.yml``` playbook and the step "Name resolution HAProxy" on ```kubernetes-ansible/roles/prepare-environment/tasks/hostname.yml``` playbook:

- kubernetes-ansible/inventory.ini
```sh
[managers]
manager1 ansible_host=172.31.87.40
manager2 ansible_host=172.31.87.41
manager3 ansible_host=172.31.87.42

[workers]
worker1 ansible_host=172.31.87.43
worker2 ansible_host=172.31.87.44
worker3 ansible_host=172.31.87.45

[haproxy]
haproxy1 ansible_host=172.31.87.46
```

- kubernetes-ansible/roles/haproxy/tasks/install-haproxy.yml
```sh
- name: Configure frontend and backend
  blockinfile:
    path: /etc/haproxy/haproxy.cfg
    block: |
      frontend kubernetes
          mode tcp
          bind 172.31.87.46:6443
          option tcplog
          default_backend k8s-masters

      backend k8s-masters
          mode tcp
          balance roundrobin
          option tcp-check
          server k8s-manager01 172.31.87.40:6443 check fall 3 rise 2
          server k8s-manager02 172.31.87.41:6443 check fall 3 rise 2
          server k8s-manager03 172.31.87.42:6443 check fall 3 rise 2
```

- kubernetes-ansible/roles/prepare-environment/tasks/hostname.yml
```sh
- name: Name resolution HAProxy
  blockinfile:
    path: /etc/hosts
    block: |
      172.31.87.40 manager01
      172.31.87.41 manager02
      172.31.87.42 manager03
      172.31.87.46 haproxy01
  tags: name-resolution
```

- To execute Ansible playbook:

```sh
ansible-playbook -v -i inventory.ini playbook-k8s.yml
```
