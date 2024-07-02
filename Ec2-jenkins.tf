provider "aws" {
    region = "us-east-1"
  
}
resource "aws_security_group" "sg_terraform" {
    name = "sg_terraform"
    description = "Allow SSh inbound traffic"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
    }
    resource "aws_instance" "max-terra" {
        ami = "ami-0e001c9271cf7f3b9"
        instance_type = "t2.micro"
        key_name = "max123"
        vpc_security_group_ids = [aws_security_group.sg_terraform.id]
        associate_public_ip_address = true
        user_data = <<EOF
            #!/bin/bash
            apt-get update
            apt-get install -y software-properties-common
            apt-add-repository ppa:ansible/ansible
            apt-get update
            apt-get install -y ansible
            ansible --version
            EOF
      
    }
