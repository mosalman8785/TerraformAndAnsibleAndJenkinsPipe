provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "demo_ec2" {
  ami           = "ami-0a716d3f3b16d290c"  # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  key_name      = "my-key"

  tags = {
    Name = "Jenkins-Terraform-Ubuntu-EC2"
  }
}

output "public_ip" {
  value = aws_instance.demo_ec2.public_ip
}
