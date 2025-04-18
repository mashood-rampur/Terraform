provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "vpcsg" {
  name        = "VPC-SG"
  description = "allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.myvpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.vpcsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.vpcsg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT1" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "RTA1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT1.id
}

resource "aws_route_table_association" "RTA2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT1.id
}

resource "aws_security_group" "ec2SG" {
  name   = "SG-1"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    cidr_blocks      = ["0.0.0.0/0"]
    protocol        = "tcp"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    cidr_blocks      = ["0.0.0.0/0"]
    protocol        = "tcp"
  }

  egress {
    from_port       = 0
    to_port         = 0
    cidr_blocks      = ["0.0.0.0/0"]
    protocol        = "-1"
  }
}

resource "aws_instance" "ec2_1" {
  ami                     = "ami-0e35ddab05955cf57"
  instance_type           = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.ec2SG.id]

  user_data = file("userdata.sh")
}

resource "aws_instance" "ec2_2" {
  ami                     = "ami-0e35ddab05955cf57"
  instance_type           = "t2.micro"
  subnet_id = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.ec2SG.id]

  user_data = file("userdata1.sh")
}

resource "aws_lb_target_group" "TG" {
  name     = "TG-example"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    protocol = "HTTP"
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "TGA1" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.ec2_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "TGA2" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.ec2_2.id
  port             = 80
}

resource "aws_lb" "ALB" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2SG.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}

output "alb_dns" {
  value = aws_lb.ALB.dns_name
}










