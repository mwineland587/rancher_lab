[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter='/usr/bin/python3'
ansible_user='ec2-user'

[upstream]
%{ for index, ip in upstream ~}
%{ if index == 0 ~}
controlplane-${index} ansible_host=${ip} primary=True
%{ else ~}
controlplane-${index} ansible_host=${ip}
%{ endif ~}
%{ endfor ~}
