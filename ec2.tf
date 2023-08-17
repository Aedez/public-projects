# Github : https://github.com/Aedez

##########################

resource "aws_instance" "web" {
  ami           = "ami-09538990a0c4fe9be"
  instance_type = "t2.micro"
  key_name = "ranjitkey"
  subnet_id = aws_subnet.public[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "./ranjitkey.pem"
    destination = "/home/ec2-user/ranjitkey.pem"

    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./ranjitkey.pem")}"
    }  
  }
}

resource "aws_instance" "db" {
  ami           = "ami-09538990a0c4fe9be"
  instance_type = "t2.micro"
  key_name = "ranjitkey"
  subnet_id = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}