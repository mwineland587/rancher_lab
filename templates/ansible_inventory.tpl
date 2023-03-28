[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter='/usr/bin/python3'
ansible_user='ec2-user'

[lb]
aws_elb dns_name=${lb_dns}

[upstream]
%{ for index, ip in upstream ~}
%{ if index == 0 ~}
upstream-controlplane-${index} ansible_host=${ip} primary=True
%{ else ~}
upstream-controlplane-${index} ansible_host=${ip}
%{ endif ~}
%{ endfor ~}

[downstream_controlplane]
%{ for index, ip in downstream_controlplane ~}
%{ if index == 0 ~}
downstream-controlplane-${index} ansible_host=${ip} primary=True
%{ else ~}
downstream-controlplane-${index} ansible_host=${ip}
%{ endif ~}
%{ endfor ~}

[downstream_workers]
%{ for index, ip in downstream_workers ~}
downstream-worker-${index} ansible_host=${ip}
%{ endfor ~}
