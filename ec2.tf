resource "aws_instance" "jenkins" {
  ami           = "ami-0388e3ada3d9812da"
  instance_type = "m7i-flex.large"

  subnet_id = aws_subnet.main.id

  key_name = aws_key_pair.icanio.key_name

  vpc_security_group_ids = [
    aws_security_group.jenkins.id
  ]

  user_data = file("${path.module}/jenkins.sh")

  tags = {
    Name = "jenkins-server"
  }
}

resource "aws_instance" "minikube" {
  ami           = "ami-0388e3ada3d9812da"
  instance_type = "m7i-flex.large"

  subnet_id = aws_subnet.main.id

  key_name = aws_key_pair.icanio.key_name

  vpc_security_group_ids = [
    aws_security_group.minikube.id
  ]

  user_data = file("${path.module}/minikube.sh")

  tags = {
    Name = "minikube-server"
  }
}