resource "aws_security_group" "public" {
  name = "${local.name_tag} Allow public traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "ALL"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2376
    to_port     = 2376
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private" {
  name = "${local.name_tag} Allow all ports between nodes"
}

resource "aws_security_group_rule" "private_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "ALL"
  cidr_blocks       = formatlist("%s/32", concat(aws_instance.upstream_controlplane.*.private_ip, aws_instance.downstream_controlplane.*.private_ip, aws_instance.downstream_workers.*.private_ip))
  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "ALL"
  cidr_blocks       = formatlist("%s/32", concat(aws_instance.upstream_controlplane.*.private_ip, aws_instance.downstream_controlplane.*.private_ip, aws_instance.downstream_workers.*.private_ip))
  security_group_id = aws_security_group.private.id
}
