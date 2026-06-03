resource "aws_security_group" "jenkins" {
    name = "jenkins-sg"
    vpc_id      = aws_vpc.main.id


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["27.7.235.197"]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "minikube" {
    name = "minikube-sg"
    vpc_id      = aws_vpc.main.id


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [
        "27.7.235.197",
        "10.0.1.0/24"
    ]
  }

  ingress {
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = [
        "27.7.235.197",
        "10.0.1.0/24"
    ]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 30000
    to_port          = 32767
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}