provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0309a295b1c3605cd"
  instance_type = "t2.micro"

  tags = {
    Name = "prodigybe"
  }
}
