#outputs file


output "instance_id" {
  value = "${aws_instance.chef-server.id}"
}

output "private_ip" {
  value            = "${aws_instance.chef-server.private_ip}"
}

output "instance_name" {
  value = "${aws_instance.chef-server.name}"
}

output "security_group_name" {
  value = "${aws_security_group.chef-server.name}"
}

output "security_group_id" {
  value            = "${aws_security_group.chef-server.id}"
}
