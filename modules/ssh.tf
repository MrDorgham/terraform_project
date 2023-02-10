module "ssh-module" {
  source    = "../ssh"
  algorithm = "RSA"
  rsa_bits  = "4096"
  key_name  = "ec2-2-pem"
}