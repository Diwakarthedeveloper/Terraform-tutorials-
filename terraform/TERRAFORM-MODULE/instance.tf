# # creating instance below 

# resource "aws_instance" "web" {
#   ami           = "ami-02eb7a4783e7e9317"
#   instance_type = "t2.micro"
# }

module "mywebserver" {
  source = "./modules/webserver"
  key    = file("${path.module}/id_rsa.pub")

  image_id      = "${var.image_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

}

# in above module parameters are passed  like in a function parametersare passed like below sample
# function sum(int a, int b)
#  return a+b


#below code to print instace ip
output "mypublicIP" {
  value = module.mywebserver.publicIP
  
}