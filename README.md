# rancher_lab

Software Requirements:

aws-cli v2 + configured with credentials

Terraform v1.3.9+

ansible [core 2.14.3]

Install required ansible collection:

ansible-galaxy collection install kubernetes.core

Copy variables.tf.sample to variables.tf and put in your public SSH key, bootstrap password and rancher admin password

Then just run terraform apply
