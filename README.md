# Kubernetes cluster with Ansible

This repository contains Ansible roles that will help you to create an [Kubernetes](https://kubernetes.io/) highly available clusters with [HAProxy](https://www.haproxy.com/) for production environment using Ansible or a simple Kubernetes cluster with 3 nodes ```not for production``` also using Ansible.

Requirements
------------
Requires a machine with [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed.

If you want to create it in AWS this repository contains [Terraform](https://www.terraform.io/) files that automates the creation of instances, so you will need to install Terraform. You can install Terraform using the [documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli) or with [TFSwitch](https://tfswitch.warrensbox.com/Install/) for a better management of Terraform versions.

How to Use - Highly Available Cluster With HAProxy
------------
Creating Instances
------------
If you are using AWS you can create the instances with Terraform.
In this setup we will use seven instances: 3 Managers, 3 Workers and 1 for HAProxy.

- Set AWS environment variables

```bash
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```
replace with your ```ACCESS KEY ID``` and ```SECRET ACCESS KEY```.

- Init and execute Terraform apply

```bash
git clone https://github.com/HailsonJunior/kubernetes-ansible.git

cd kubernetes-ansible/highly-available-cluster-haproxy/terraform/

terraform init

terraform apply
```
Creating Kubernetes Cluster
------------
To use the Ansible roles you will only need to use the playbook ```playbook-k8s.yml``` in kubernetes-ansible/highly-available-cluster-haproxy directory.

```bash
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

If you have not created the instances using Terraform files from this repository will be needed to edit the Ansible inventory file replacing the IPs ```kubernetes-ansible/highly-available-cluster-haproxy/inventory.ini``` according to your environment. It will also be necessary to edit the steps "Configure frontend and backend" on ```kubernetes-ansible/roles/haproxy/tasks/install-haproxy.yml``` playbook and the step "Name resolution HAProxy" on ```kubernetes-ansible/highly-available-cluster-haproxy/roles/prepare-environment/tasks/hostname.yml``` playbook:

- kubernetes-ansible/highly-available-cluster-haproxy/inventory.ini
```bash
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

- kubernetes-ansible/highly-available-cluster-haproxy/roles/haproxy/tasks/install-haproxy.yml
```bash
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

- kubernetes-ansible/highly-available-cluster-haproxy/roles/prepare-environment/tasks/hostname.yml
```bash
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

```bash
ansible-playbook -v -i inventory.ini playbook-k8s.yml
```

How to Use - Simple three nodes Cluster 
------------
Creating Instances
------------
If you are using AWS you can create the instances with Terraform.
In this setup we will use three instances: 1 Manager and 2 Workers.

- Set AWS environment variables

```bash
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```
replace with your ```ACCESS KEY ID``` and ```SECRET ACCESS KEY```.

- Init and execute Terraform apply

```bash
git clone https://github.com/HailsonJunior/kubernetes-ansible.git
cd kubernetes-ansible/simple-three-node-cluster/terraform/
terraform init
terraform apply
```

After Terraform execution you can receive an error like this:

```bash
Error: Failure associating EIP: InvalidInstanceID: The pending instance 'i-0aebd92ecc52f11c6' is not in a valid state for this operation.
│       status code: 400, request id: 7fa99dd1-b78e-40e6-900c-7044c9eb17fd
│ 
│   with module.spot_instances.aws_eip.eip-worker01,
│   on instances/network.tf line 35, in resource "aws_eip" "eip-worker01":
│   35: resource "aws_eip" "eip-worker01" {
```

To solve this problem you just have to execute ```terraform apply``` again.

Creating Kubernetes Cluster
------------
To use the Ansible roles you will only need to use the playbook ```playbook-k8s.yml``` in kubernetes-ansible/simple-three-node-cluster directory.

```bash
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

If you have created or not the instances using Terraform files from this repository will be needed to edit the Ansible inventory file replacing the IPs ```kubernetes-ansible/simple-three-node-cluster/inventory.ini``` according to your environment. If you have created using Terraform files from this repository you have to put the public IPs of the instances created that can be visualized in AWS console. If you are not using Terraform files from this repository it will also be necessary to edit ```kubernetes-ansible/simple-three-node-cluster/roles/prepare-environment/defaults/main.yml``` file.

- kubernetes-ansible/simple-three-node-cluster/inventory.ini
```bash
[managers]
k8s-manager01 ansible_host=3.13.81.82

[workers]
k8s-worker01 ansible_host=3.130.133.219
k8s-worker02 ansible_host=3.15.56.124
```

- kubernetes-ansible/simple-three-node-cluster/roles/prepare-environment/defaults/main.yml
```bash
---
# Nodes IP

K8S_MANAGER01_IP: 10.0.80.40
K8S_WORKER01_IP: 10.0.80.43
K8S_WORKER02_IP: 10.0.80.44
```

- To execute Ansible playbook:

```bash
ansible-playbook -v -i inventory.ini playbook-k8s.yml
```
