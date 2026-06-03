# For an EC2 Instance
output "jenkins_ip" {
  description = "The public IP address jenkins"
  value       = aws_instance.jenkins.public_ip
}

# For an Elastic IP (EIP)
output "minikube_ip" {
  description = "The public IP address minikube"
  value       = aws_instance.minikube.public_ip
}
