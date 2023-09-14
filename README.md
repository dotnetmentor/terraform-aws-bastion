# AWS EC2 Bastion Terraform module

Terraform module to create a bastion host.

## AWS Resources

- EC2 Instance
- Security Group
- Key Pair
- Route 53 Record

## Usage

    module "bastion" {
      source = "github.com/dotnetmentor/terraform-aws-bastion"

      enabled = true

      aws_region  = <region>
      environment = "dev"

      instance_name = "bastion"
      instance_ami  = data.aws_ami.ubuntu.id
      instance_type = "t2.nano"

      vpc_id   = <vpc_id>
      vpc_cidr = <vpc_cidr_block>

      public_subnet = <vpc_public_subnet>

      key_pair_name      = <key_pair_name>
      key_pair_publickey = <key_pair_publickey>

      dns_record       = "bastion.dev.mydomain.com"
      hosted_zone_name = dev.mydomain.com"
    }
