# We will learn how to store tfstate fines in the backend[in remote safe location like S3 or kubernetesetc  check terraform backend page for more]

terraform {
  backend "s3" {
    bucket = "diwakar-tf-state"  #
    region = "ap-south-1"
    key = "terraform.tftate" # this will be the name of the tf state file in the backend cloud
    dynamodb_table = "diwakar-tf-table"
  }
}






variable "access_key" {
  type = string
  
}

variable "secret_key" {
  type = string
  
}



provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
  

}

resource "aws_instance" "web" {
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.small"
  
}