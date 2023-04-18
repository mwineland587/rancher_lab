# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  count = local.upstream_count
  content = templatefile("${path.module}/templates/ansible_inventory.tpl",
    {
      upstream                = aws_instance.upstream_controlplane.*.public_ip,
      downstream_controlplane = aws_instance.downstream_controlplane.*.public_ip,
      downstream_workers      = aws_instance.downstream_workers.*.public_ip,
      lb_dns                  = aws_elb.lb.dns_name
    }
  )
  filename = "ansible/inventory.cfg"
}

resource "null_resource" "ansible_upstream" {
  depends_on = [local_file.hosts_cfg]
  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory.cfg ansible/upstream.yaml --extra-vars bootstrap_password='${local.bootstrap_password}'"
  }
}

resource "null_resource" "ansible_downstream_controlplane" {
  depends_on = [local_file.hosts_cfg]
  provisioner "local-exec" {
    command = nonsensitive("ansible-playbook -i ansible/inventory.cfg ansible/downstream_controlplane.yaml --extra-vars \"node_command='${rancher2_cluster_v2.downstream1.cluster_registration_token[0].insecure_node_command} --etcd --controlplane'\"")
  }
}

resource "null_resource" "ansible_downstream_workers" {
  depends_on = [local_file.hosts_cfg]
  provisioner "local-exec" {
    command = nonsensitive("ansible-playbook -i ansible/inventory.cfg ansible/downstream_workers.yaml --extra-vars \"node_command='${rancher2_cluster_v2.downstream1.cluster_registration_token[0].insecure_node_command} --worker'\"")
  }
}

