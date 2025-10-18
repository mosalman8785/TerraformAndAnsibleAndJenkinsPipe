provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "demo_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux
  instance_type = "t2.micro"
  key_name      = "my-key"

  tags = {
    Name = "Jenkins-Terraform-EC2"
  }
}

output "public_ip" {
  value = aws_instance.demo_ec2.public_ip
}
