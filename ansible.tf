# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  count = local.upstream_count
  content = templatefile("${path.module}/templates/ansible_inventory.tpl",
    {
      upstream = aws_instance.upstream_controlplane.*.public_ip,
    }
  )
  filename = "ansible/inventory.cfg"
}

resource "null_resource" "runansible" {
depends_on = [local_file.hosts_cfg]
  provisioner "local-exec" {
      command = "ansible-playbook -i ansible/inventory.cfg ansible/playbook.yaml"
    }
}

