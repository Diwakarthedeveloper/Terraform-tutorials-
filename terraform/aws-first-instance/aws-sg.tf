#creating security group # video 35 terraform gaurav sharma 
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  # dynamic command will be used to run content  which needs to run multiple times
  dynamic "ingress" {
    #for_each = [22, 80, 443, 3306, 27017]
    for_each = var.ports # as now ports value are moved to terraform.tfvars
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}