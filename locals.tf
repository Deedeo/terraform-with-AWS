locals {
  ssh_user         = "ec2-user"
  private_key_path = "~/lab-002.pem"
}

locals {
  common_tags = {
    project      = var.project
    billing_code = var.billing_code

  }
}
