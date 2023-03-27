resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = local.ssh_key
}

resource "aws_instance" "upstream_controlplane" {
  count           = local.upstream_count
  ami             = local.ami //SLES AMI
  instance_type   = local.type
  key_name        = "terraform-key"
  security_groups = [aws_security_group.ssh.name, aws_security_group.https.name, aws_security_group.all.name]

  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name          = "Upstream Controlplane ${count.index}",
  }
}
