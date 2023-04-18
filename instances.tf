resource "aws_key_pair" "terraform" {
  key_name   = "terraform-key"
  public_key = local.ssh_key
}

resource "aws_instance" "upstream_controlplane" {
  availability_zone = local.availability_zone
  count             = local.upstream_count
  ami               = local.ami //SLES AMI
  instance_type     = local.type
  key_name          = "terraform-key"
  security_groups   = [aws_security_group.public.name, aws_security_group.private.name]

  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "${local.name_tag} Upstream Controlplane ${count.index}",
  }
}

resource "aws_instance" "downstream_controlplane" {
  availability_zone = local.availability_zone
  count             = local.downstream_control_count
  ami               = local.ami //SLES AMI
  instance_type     = local.type
  key_name          = "terraform-key"
  security_groups   = [aws_security_group.public.name, aws_security_group.private.name]

  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "${local.name_tag} Downstream Controlplane ${count.index}",
  }
}

resource "aws_instance" "downstream_workers" {
  availability_zone = local.availability_zone
  count             = local.downstream_worker_count
  ami               = local.ami //SLES AMI
  instance_type     = local.type
  key_name          = "terraform-key"
  security_groups   = [aws_security_group.public.name, aws_security_group.private.name]

  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "${local.name_tag} Downstream Worker ${count.index}",
  }
}
