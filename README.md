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

If you have not created the instances using Terraform files from this repository will be needed to edit the Ansible inventory file replacing the IPs ```kubernetes-ansible/inventory.ini``` according to your environment.

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

- To execute Ansible playbook:

```sh
ansible-playbook -v -i inventory.ini playbook-k8s.yml
```
