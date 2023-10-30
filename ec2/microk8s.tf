provider "aws" {
  region = "ap-southeast-1" # Singapore region
}

resource "aws_instance" "microk8s" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 20.04 LTS
  instance_type = "t2.micro"
  key_name      = "your_key_name"

  vpc_security_group_ids = [
    aws_security_group.microk8s.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo snap install microk8s --classic",
      "sudo usermod -a -G microk8s ubuntu",
      "sudo chown -f -R ubuntu ~/.kube",
      "sudo microk8s enable dashboard",
      "sudo microk8s enable dns",
      "sudo microk8s enable community",
      "sudo microk8s enable linkerd",             # enable service mesh and observability monitoring
      "sudo snap alias microk8s.kubectl kubectl", # create alias microk8s.kubectl to kubectl
    ]
  }

  tags = {
    Name = "microk8s-instance"
    App  = "prodigybe"
  }
}

resource "aws_security_group" "microk8s" {
  name_prefix = "microk8s-sg-"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "app" = "prodigybe"
  }
}
