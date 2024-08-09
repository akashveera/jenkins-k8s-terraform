resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.my-vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["122.151.242.252/32", "206.83.112.213/32"] # provide your IP address 
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["122.151.242.252/32", "206.83.112.213/32"] # provide your IP address 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.env_prefix}-default-jenkins-sg"
  }
}