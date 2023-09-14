# ---------------------------------------------------------------------------------------------------------------------
# MANDATORY PARAMS
# ---------------------------------------------------------------------------------------------------------------------

variable "enabled" {
  description = "When set to true, a bastion host will be created"
  type        = bool
  default     = true
}

variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "environment" {
  description = "The name of the environment the cluster represents"
}

variable "instance_name" {
  description = "The bastion instance name"
}

variable "instance_ami" {
  description = "The AMI to use for bastion instance"
}

variable "vpc_id" {
  description = "The ID of the VPC to launch the bastion instance in"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
}

variable "public_subnet" {
  description = "ID of the public subnet you want the bastion to join"
}

variable "key_pair_name" {
  description = "The Key Pair name to associate with bastion instance"
}

variable "key_pair_publickey" {
  description = "The Key Pair public key used when accessing the bastion instance"
}

variable "dns_record" {
  description = "The public DNS record to use for the bastion host"
}

variable "hosted_zone_name" {
  description = "The Route 53 hosted zone that will hold the public dns record for the bastion host"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMS
# ---------------------------------------------------------------------------------------------------------------------

variable "instance_type" {
  description = "The AMI to use for cluster instances"
  default     = "t2.micro"
}
