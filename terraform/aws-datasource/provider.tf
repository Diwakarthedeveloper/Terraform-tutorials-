provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "access_key" {
  type = string

}

variable "secret_key" {
  type = string
}

#data sources - they help to provide name of dynamic resources like AWS os AMI id

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  # name = ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230325
  # root device= ebs
  # vert type = 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

output "ami_id" {
  value = data.aws_ami.ubuntu.id

}


