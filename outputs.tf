output "user" {
  value = "ubuntu"
}

output "private_ip" {
  value = one(aws_instance.bastion.*.private_ip)
}

output "public_ip" {
  value = one(aws_instance.bastion.*.public_ip)
}

output "fqdn" {
  value = one(aws_route53_record.bastion.*.fqdn)
}

output "security_group" {
  value = aws_security_group.bastion.id
}

output "ssh_key_pair_name" {
  value = aws_key_pair.bastion.key_name
}
