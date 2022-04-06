provider "aws" {
  access_key = "your_access_key"
  secret_key = "your_secret_key"
  region     = "us-east-2"
}

resource "aws_instance" "maor" {
  ami           = "ami-001089eb624938d9f"
  instance_type = "t2.micro"
  key_name = "aws_key"
  vpc_security_group_ids = [aws_security_group.allow_8081.id]

provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install git -y",
      "sudo yum install docker -y",
      "sudo curl -L 'https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "git clone https://github.com/maormalca/count_python_withterraform.git",
      "cd count_python_withterraform",
      "docker-compose up -d",
      "curl localhost:8081/hits",

    ]
  }

connection{
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("/root/.ssh/id_rsa")
      timeout     = "20m"
}



}
resource "aws_security_group" "allow_8081" {
  name        = "allow_8081"
  description = "Allow 8081 inbound traffic"
  vpc_id      = "vpc-e4b8cf8f"

  ingress {
    description      = "allow_8081"
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

ingress {
    description      = "allow_ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  tags = {
    Name = "allow_8081"
  }
}
`
