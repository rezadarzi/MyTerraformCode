resource "aws_key_pair" "citadel-key" {
  key_name          = "citadel-key"
  public_key        = file("/root/terraform-challenges/project-citadel/.ssh/ec2-connect-key.pub")
}

resource "aws_instance" "citadel" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.citadel-key.key_name
  user_data = file("install-nginx.sh")
}

resource "aws_eip" "eip" {
  instance = aws_instance.citadel.id
  vpc = true
  provisioner "local-exec" {
    command = "echo ${self.public_dns} >> /root/citadel_public_dns.txt"
  }
}
