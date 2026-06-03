# 1. Generate a new private key
resource "tls_private_key" "icanio" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Register the generated public key with AWS
resource "aws_key_pair" "icanio" {
  key_name   = "icanio-key"
  public_key = tls_private_key.icanio.public_key_openssh
}

# 3. Save the private key to your local machine to use with SSH
resource "local_file" "private_key" {
  content         = tls_private_key.icanio.private_key_pem
  filename        = "${path.module}/icanio-key.pem"
  file_permission = "0400"
}
