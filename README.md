

ELK stands for Elasticsearch, Logstash, and Kibana. It is being promoted by Elasticsearch as a "devops" logging solution

This implementation of ELK stack is designed to run on Microsoft Azure on Linux Ubuntu machines. The JSON setup files for Microsoft azure can be found at the following link. The SSH keys have been redacted & will have to be recreated. The default system admin account has also been changed from azureadmin to azadmin



This ELK is pre-configured with the following privileged user account.

  User: elastic
  Password: changeme

It is highly recommended to change this users account credentials immediately after setup

By default, the following ports are exposed with this installation
- 5044: Logstash
- 5601: Kibana
- 9200: Elasticsearch HTTP

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![alt text](https://github.com/ExtonHoward/ELK/blob/main/Ansible/Resources/Network-Topology.png "Network Diagram")

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Deployment-playbook.yml file may be used to install only certain pieces of it, such as Filebeat. The config giles should be placed in the /etc/ansible/files directory while the playbook should be placed in the /etc/ansible/roles directory. After the config files are placed in the /etc/ansible/files directory you need to make sure that the etc/ansibe/hosts file has the appropriate local IP numbers under the webservers and the elk groups.

  - https://github.com/ExtonHoward/ELK/blob/main/Ansible/yml_files/Deployment-playbook.yml

Additionally, the other YML config files for Filebeat & Metricbeat are located at https://github.com/ExtonHoward/ELK/blob/main/Ansible/yml_files/Filebeat-config.yml and https://github.com/ExtonHoward/ELK/blob/main/Ansible/yml_files/metricbeat-config.yml respectively. The shorter yml files for each independent portion of the install are located https://github.com/ExtonHoward/ELK/tree/main/Ansible/yml_files

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the Damn Vulnerable Web Application.

Load balancing ensures that the application will be highly redundant and resilient, in addition to restricting access to the network.
- The Load Balancers allow access to the regularly not available Web-VM's that are loaded with the docker containers for the DVWA, Filebeat, and Metricbeat
  Placing them behind the load balancer allows the load to be spread out across multiple machines in case a machine goes down. 

- The jump Box limits access to the rest of the network as you have to ssh to the jump box, then move into the docker container, then move to any of the other
  machines in the network. This allows a single point of entry which makes it easier to monitor. It also allows more robust security procedures to be deployed
  to the jump box in order to make the entire network more secure

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system files.
- Filebeat is used to monitor log data, events, and files, then forwards them to either Elasticsearch or Logstash 
- Metricbeat is used to collect different metrics from the OS and services running on the server

The configuration details of each machine may be found below.

| Name     | Function   | Local IP Address | Operating System |
|----------|------------|------------------|------------------|
| Jump Box | Gateway    | 10.1.0.4         | Ubuntu 18.04     |
| Web-1    | Webserver  | 10.1.0.5         | Ubuntu 18.04     |
| Web-2    | Webserver  | 10.1.0.6         | Ubuntu 18.04     |
| Web-3    | Webserver  | 10.1.0.7         | Ubuntu 18.04     |
| ELK-1    | Monitoring | 10.2.0.4         | Ubuntu 18.04     |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 99.145.88.86

NOTE: You will have to change the firewall rule to allow only traffic from your organizations public IP address. In my case, that IP was 99.145.88.86

Machines within the network can only be accessed by the Jump Box's IP address.
- 10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible | Allowed IP Addresses   |
|---------------|---------------------|------------------------|
| Jump-Box      | Yes                 | 99.145.88.86           |
| Web-1         | No                  | 10.1.0.4               |
| Web-2         | No                  | 10.1.0.4               |
| Web-3         | No                  | 10.1.0.4               |
| ELK-1         | Yes                 | 10.1.0.4, 99.145.88.86 |
| Load Balancer | Yes                 | 99.145.88.86           |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- Ansible is a powerful and flexible tool that allows you to quickly configure multiple machines in the exact format you want. This is advantageous
  because you can easily launch an entire network in minimal time. This reduces downtime for the network and can help maximize efficiency and profit.
  It is also easily adaptable by adding the new IP's to the hosts file and then rerunning the playbook. This means you can add, modify, or remove machines
  quickly as your network demands change. Specifically for ELK, you can also add different modules to multiple machines with just a few keystrokes.

The playbook implements the following tasks:
- Installs Docker.io
- Installs pip3 & the Python Docker Module
- Allows and executes an increase in Virtual Memory
- Downloads & launches the ELK container image, then opens the appropriate ports
- Enables that ELK runs every time the machine is booted

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![alt test](https://github.com/ExtonHoward/ELK/blob/main/Ansible/Resources/Success.JPG "Success")

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.1.0.5, 10.1.0.6, 10.1.0.7

We have installed the following Beats on these machines:
- Installed Filebeat & Metricbeat on each machine

These Beats allow us to collect the following information from each machine:
- Filebeat collects log data which allows us to monitor traffic on the devices
- Metricbeat collects data from servers such as OS data, CPU or memory data, or data about anything running on the server

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the Deployment-playbook.yml file to /etc/ansible/roles
- Update the /etc/ansible/ansible.cfg file to include the remote_user=(USERNAME FOR ADMIN OF EACH VIRTUAL MACHINE)
- Update the /etc/ansible/hosts file to include the IP address in the webservers & ELK groups. Make certain to uncomment the webservers selection & add the
  ELK section so it will work
- Run the playbook, and navigate to 52.188.120.165:5601/app/kibana to check that the installation worked as expected.

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._\

To get this, you will first have to clone the repo. You can do that with the command below

    
      git clone https://github.com/ExtonHoward/ELK
    
    
