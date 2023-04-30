# her we will maintain the terraform version configuration so that diffrent team members working 
# on the same project should keep the same version, if the tf version is diffrent in 
# diffrent files then the overall plan will fail

terraform {
  #required_version = "1.4.5" # in this terraform will look for exact version
  required_version = ">=1.4.2" #for any version above 1.4.2 , check terraform version constrain dumention
  # we cant use variables here like "${var.req_version}- this will not work as this block 
  #will come before variables so we have to hard code the vale


  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }
  }
}


