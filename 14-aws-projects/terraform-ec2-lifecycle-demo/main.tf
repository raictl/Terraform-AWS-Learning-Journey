resource "aws_instance" "demo" {
  ami           = "ami-08c99fa57d488ab37"
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
