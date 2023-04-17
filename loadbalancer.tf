resource "aws_elb" "lb" {
  name               = "${local.name_tag}-rancher-lb"
  availability_zones = [local.availability_zone]

listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
    lb_protocol       = "tcp"
  }

listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 443
    instance_protocol = "tcp"
    lb_port           = 443
    lb_protocol       = "tcp"
  }
  instances           = aws_instance.upstream_controlplane.*.id
}

