resource "aws_elb" "lb" {
  name               = "rancher-lb"
  availability_zones = ["us-east-1b"]

  listener {
    instance_port     = 6443
    instance_protocol = "tcp"
    lb_port           = 6443
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

