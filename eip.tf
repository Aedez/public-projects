# GitHub    : https://github.com/Aedez
########################################################

resource "aws_eip" "myeip" {
  //instance = aws_instance.web.id
  vpc      = true
}