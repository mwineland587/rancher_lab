# generate inventory file for Ansible
resource "local_file" "hosts_cfg" {
  count = local.upstream_count
  content = templatefile("${path.module}/templates/ansible_inventory.tpl",
    {
      upstream = aws_instance.upstream_controlplane.*.public_ip,
      index    = count.index
    }
  )
  filename = "ansible/inventory.cfg"
}
