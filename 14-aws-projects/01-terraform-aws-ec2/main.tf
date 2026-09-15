resource "aws_instance" "devops_server" {
  ami           = "ami-0f918f7e67a3323f0"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-devops-server"
  }
}
