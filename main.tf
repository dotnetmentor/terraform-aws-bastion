terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45.0"
    }
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# CREATE A KEY PAIR USED FOR SSH
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_key_pair" "bastion" {
  key_name   = var.key_pair_name
  public_key = var.key_pair_publickey
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE BASTION HOST
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "bastion" {
  count                       = var.enabled ? 1 : 0
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet
  key_name                    = aws_key_pair.bastion.key_name
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  associate_public_ip_address = true

  tags = {
    Name        = var.instance_name
    Environment = var.environment
    Terraform   = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "bastion" {
  name        = "${var.instance_name}-sg"
  vpc_id      = var.vpc_id
  description = "Bastion security group"

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.instance_name}-sg"
    Environment = var.environment
    Terraform   = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ROUTE 53 RECORD
# ---------------------------------------------------------------------------------------------------------------------

data "aws_route53_zone" "bastion" {
  name = var.hosted_zone_name
}

resource "aws_route53_record" "bastion" {
  count   = var.enabled ? 1 : 0
  zone_id = data.aws_route53_zone.bastion.id
  name    = var.dns_record
  type    = "A"
  ttl     = "60"
  records = [aws_instance.bastion.0.public_ip]
}
