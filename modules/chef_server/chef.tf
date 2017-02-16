#--------------------------------------------------------------
# This module creates chef-server instances
#--------------------------------------------------------------

# Chef Server AWS security group - https://docs.chef.io/server_firewalls_and_ports.html
resource "aws_security_group" "chef-server" {
  name        = "${var.instance["hostname"]}.${var.instance["domain"]} security group"
  description = "Chef Server ${var.instance["hostname"]}.${var.instance["domain"]}"
  vpc_id      = "${var.aws_network["vpc"]}"
  tags = {
    Name      = "${var.instance["hostname"]}.${var.instance["domain"]} security group"
  }
}
# SSH
resource "aws_security_group_rule" "chef-server_allow_22_tcp_allowed_cidrs" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.chef-server.id}"
}
# HTTP (nginx)
resource "aws_security_group_rule" "chef-server_allow_80_tcp" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server.id}"
}
# HTTPS (nginx)
resource "aws_security_group_rule" "chef-server_allow_443_tcp" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server.id}"
}
# oc_bifrost (nginx LB)
resource "aws_security_group_rule" "chef-server_allow_9683_tcp" {
  type        = "ingress"
  from_port   = 9683
  to_port     = 9683
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server.id}"
}
# opscode-push-jobs
resource "aws_security_group_rule" "chef-server_allow_10000-10003_tcp" {
  type        = "ingress"
  from_port   = 10000
  to_port     = 10003
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server.id}"
}
# Egress: ALL
resource "aws_security_group_rule" "chef-server_allow_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.chef-server.id}"
}

# AWS settings Requires AWS Role Profile on terraform local instance
provider "aws" {

  region     = "${var.aws_region}"
}

resource "aws_instance" "chef-server" {

  ami              = "${lookup(var.ami_map, "${var.ami_os}-${var.aws_region}")}"
  count            = 1
  instance_type    = "${var.instance_flavor}"
  subnet_id        = "${var.aws_network["subnet"]}"
  vpc_security_group_ids = ["${aws_security_group.chef-server.id}"]
  key_name         = "${var.instance_key["name"]}"
  tags             = {
    Name           = "${var.instance["hostname"]}.${var.instance["domain"]}"
    Description    = "${var.instance_tag_desc}"
  }
  associate_public_ip_address = "${var.instance_public}"
  connection {
        host = "${self.private_ip}"
        user = "centos"
        private_key = "${file("${var.instance_key["file"]}")}"
    }
 
 # metadata {
 #  name = "CVGX-${var.environment}-CHEF-SERVER-01"
 #  environment = "${var.environment}"
 #  contact = "${var.tag_contact}"
 # }

  provisioner "file" {
    source = "${path.module}/setHostname.sh"
    destination = "/tmp/setHostname.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setHostname.sh",
      "sudo /tmp/setHostname.sh CVGX-${var.environment}-CHEF-SERVER-01"
    ]
  }
}

data "template_file" "chef_server_rb" {
  template = "${file("${path.module}/chef-server.rb.tpl")}"

  vars {
    entry_point = "${aws_instance.chef-server.private_ip}"
  }
}

data "template_file" "chef_client_rb" {
  template = "${file("${path.module}/chef-client.rb.tpl")}"

  vars {
    entry_point = "${aws_instance.chef-server.private_ip}"
  }
}


resource "null_resource" "chef_configure" {

  # The connection block tells our provisioner how to
  # communicate with the resource (instance)

 connection {
    host        = "${aws_instance.chef-server.private_ip}"
    #user        = "${lookup(var.ami_usermap, var.ami_os)}"
    User        = "centos"
    private_key = "${file("${var.instance_key["file"]}")}"
    
  }


  provisioner "file" {
    source = "${path.module}/chef_configure.sh"
    destination = "/tmp/chef_configure.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/chef_configure.sh",
      "sudo /tmp/chef_configure.sh ${aws_instance.chef-server.private_ip}"
    ]
  }
  depends_on = [
    "aws_instance.chef-server"]

}

