
# #creating ssh-key
# resource "aws_key_pair" "key-tf" {
#   key_name = "key-tf"
#   public_key = file("${path.module}/id_rsa.pub")
# }

#printing key pair name
# output "keyname" {
#     value = "${aws_key_pair.key-tf.key_name}" #key_name is common attribute = avalable on documentaion 

# }

# #creating security group # video 35 terraform gaurav sharma 
# resource "aws_security_group" "allow_tls" {
#   name        = "allow_tls"
#   description = "Allow TLS inbound traffic"

#   # dynamic command will be used to run content  which needs to run multiple times
#   dynamic "ingress" {
#     #for_each = [22, 80, 443, 3306, 27017]
#     for_each = var.ports # as now ports value are moved to terraform.tfvars
#     iterator = port
#     content {
#       description = "TLS from VPC"
#       from_port   = port.value
#       to_port     = port.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]

#     }

#   }

# egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

# }

# output "securityGroupDetails" {
#   value = "${aws_security_group.allow_tls.id}"

# }


#data source below
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  # name = ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230325
  # root device= ebs
  # vert type = 
  filter {
    name = "name"
    #values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    values = ["${var.image_name}"]
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


# creating instance below 

resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.instance_type}"
  key_name               = aws_key_pair.key-tf.key_name #here rhis will assign key pair to the instance created
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "first-tf-instance"
  }
  # user_data = <<-EOF
  #                EOF
  user_data = file("${path.module}/script.sh")

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    #host = "${aws_instance.web.pblic_ip}"
    host = self.public_ip # self is used to avoid infinite loop 

  }

  # provisners = They are used to copy file from the local machine to the instances
  #note : if a provisner fails then it will mark the resourse as taint and redeploy in next apply
  # provisioners are of many types some are file, local exec, remote exec
  # below is provisner code
  provisioner "file" {
    source      = "readme.md"      #terraform machine
    destination = "/tmp/readme.md" #terraform machine
    # connection {
    #   type    = "ssh"
    #   user    = "ubuntu"
    #   private_key = file("${path.module}/id_rsa")
    #   #host = "${aws_instance.web.pblic_ip}"
    #   host = "${self.public_ip}" # self is used to avoid infinite loop 

    # }


  }


  provisioner "file" {
    content     = "This is test content" #terraform machine
    destination = "/tmp/content.md"      #terraform machine
    # connection {
    #   type    = "ssh"
    #   user    = "ubuntu"
    #   private_key = file("${path.module}/id_rsa")
    #   #host = "${aws_instance.web.pblic_ip}"
    #   host = "${self.public_ip}" # self is used to avoid infinite loop 

    # }
  }
  # provisioner "local-exec" {
  #   command = "echo ${self.public_ip}  > /tmp/mypublicip.txt "
  # }

  # provisioner "local-exec" {
  #   working_dir = "/tmp/"
  #   command     = "echo ${self.public_ip}  > /tmp/mypublicip.txt "
  # }


  provisioner "local-exec" {
    on_failure = continue # this will allow teraform to continue even if one line gives error like try catch block 
    command    = "workspace >env.txt"
    environment = {
      workspacename = "workspacevalue"
    }

  }

  provisioner "local-exec" {
    command = "echo 'at  Create '"

  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'at delete'"

  }

  provisioner "remote-exec" {
    inline = [
      "ifconfig >/tmp/ifconfig.output",
      "echo 'hello diwakar' >/tmp/test.txt"
    ]
  }

  provisioner "remote-exec" {
    script = "./testscript.sh"
  }







  #  provisioner "local-exec" {

  #     #workdir = "/tmp/"
  #     interpreter = [
  #       "/usr/bin/python", "-c"
  #     ]
  #     #command = "echo ${self.public_ip}  > mypublicip.txt "
  #     command = "print('Hellow Diwakar ')"




}


