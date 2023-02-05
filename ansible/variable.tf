variable "access_key" {
    type = string
    sensitive = true
    description = "AWS access key"
}
  
variable "secret_key" {
    type = string
    sensitive = true
    description = "AWS secret key"
}

variable "aws_region" {
    default = "us-east-1"
    description = "The AWS region to use for resources"
    }

variable "enable_dns_hostnames" {
    type = bool
    description = "Enable DNS hostnames in VPC"
    default = true
    }

variable "cidr_block" {
    type = string
    description = "The CIDR block for the VPC"
    default = "10.0.0.0/16"
    }

variable "vpc_subnets_cidr_block" {
    type = list(string)
    description = "The CIDR block for the VPC subnet"
    default = ["10.0.0.0/24","10.0.1.0/24"]
    }
    

variable "map_public_ip_on_launch" {
    type = bool
    description = "Map public IP on launch"
    default = true
    }
  
variable "instance_type" {
    type = string
    description = "The instance type to use for the EC2 instance"
    default = "t2.micro"
    }
  
 variable "project" {
    type = string
   description = "value for the project tag"
    default = "Altschool"
    }
 variable "billing_code" {
    type = string
   description = "value for the billing_code tag"
   default = "ACCT-1234"
    }
    