resource "aws_instance" "samail-server" {
    ami = var.ami_id
    count = var.number_of_instance
    subnet_id = aws_subnet.some_public_subnet.id
    instance_type = var.instance_type
    key_name = var.ami_key_pair_name
    associate_public_ip_address = true
    security_groups = [ aws_security_group.k8s_sg.id ]
    root_block_device {
    volume_type = "gp2"
    volume_size = "8"
    delete_on_termination = true
    }
     provisioner "file" {
    source      = "/c/Users/Samail/happylearning/terraform/terraform-infra/happfile.txt"
    destination = "/home/ec2-user/test-file.txt"
    }
    connection {
                type        = "ssh"
                host        = self.public_ip
                user        = "ec2-user"
                private_key = file("~/.ssh/id_rsa")
                timeout     = "4m"
        }

    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum upgrade
    sudo dnf install java-17-amazon-corretto -y
    yum install jenkins -y
    systemctl enable jenkins
    systemctl start jenkins
    systemctl status Jenkins
    yum install git -y
    EOF

    
    tags = {
        Name = "${var.name}-instance-${count.index + 1}"
    }
   }

output "ec2_global_ips" {
  value = "${aws_instance.samail-server.*.public_ip}"
}

resource "aws_key_pair" "deployer" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7605gyREqnCvG2maXglOhsALblIAfzy0qrqWaXh9ZxZh/4bMB5dfSf4O+y6lbtk51nGEDbK07SLWuIzoHYADpPphovYxcXLxFPr8VNuA+58rQAqIWCtuSnUmoBcdOk5vwPzQ6U3mzDut8T1GzbS8WqoqEODfHlpxPaO0s4PVk6BjqGG8bzXxWgF18M3SQbtpUtDYvEuOrSjmG2gfg4h5mk+2UjkM8rcxqYh3RR/+Ioq25Jvy66zF2JQm0SX2Uz/mRkgyJ+FErx6FYVGHE9YPoHV2RR5ogaSa43pxW5EG9Y/qOWubb2ykk/07Ladd+UYtwJijO/0zbVSiTBMNwXjjVfFXNqRJD7h+320OxnsZ+U8FQ/PbhJY8mWHE0BLNQnH7kY0Y+FbkEHWsC1gH5JpklGTQcBvd7PLuOAs6txJorGbPAwmwpakEDJ01VYoI2ko6Pv949mdP7redJRYvnX9Qbw/JYlaVz6+qblco58ywcCyGpQatZBLFcamNe7fRgHdk= Samail@DESKTOP-TQ07T3R"
}
