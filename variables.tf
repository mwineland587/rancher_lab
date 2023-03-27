locals {
  upstream_count = 3
  ami            = "ami-0c544bda9765444c2"
  type           = "c4.xlarge"
  name_tag       = "My EC2 Instance"
  ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqZQBqRpPIIk5I4X8poVRlRiy/gBElKI7qNzigFA4ZHskQbsGvGGdaKYe2YKNMjdFHSvYkMoUyLbhgW5PXugz9DnOY/UOPDm0R26sJKowI/K2YbYuEF9zgPN686yEVxUQQscfnYVh5yanWUBBLdYp692keftCHJCo5Vlosf+SgZTNvr+6Sx6DXDocbu40TSInU5672CKjspmxum+93Gg+nxfMkWRycMDvHQV9CgyT4VGwBVh9/txIrQGZwyZd9n9nK4L6SOKRuXI5UWgAf9kVbyOyzv4v5VPU+2uqTm3HUuzZWk4tmrNFTID1dkOoqGbJ7yh/+qH0wPe+prZXPtGkNoXMQbCp9QLa2iLq2Zhz+bEIhEA12Jx/tMc2XCbrlmEt/+4o5cF0tl35lFefog+0rq/hEjeeSxKdIZHwKepfVdaVjDLpfCtLcPIyHD7MdBrqGE5wxsDuJsztcnH3bOjovxRho1ESrn8QYe7PDUVTwdIlIof/O9rglFL1JTb5JcZc+VT1fw/PsBFHn8KY7649XMQIaCEO9JM6fonC8Lu/reZm9zfO4WDrr4gNpYMeqFf8ou5x/QWQg8aj4/8J+cXLPZKRWglBz6TZ4MGelKTlKE2qDqj8kSOYjeDSwiPyRtwfGkK0MbQnAFFw6CWApaPkgBFZN+XWxT0IlGVdiqs8lGQ== michael"
}

#output "public_ip" {
#  value       = aws_instance.upstream_controlplane.*.public_ip
#  description = "Public IP Address of EC2 instance"
#}

#output "instance_id" {
#  value       = aws_instance.upstream_controlplane.*.id
#  description = "Instance ID"
#}
