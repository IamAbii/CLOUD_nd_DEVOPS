provider "aws" {
    region = "us-east-1"
  
}

resource "aws_s3_bucket" "bin" {
    bucket = "bimbasketabhilashdumps"
}


resource "aws_iam_role_policy" "s3ecpolicy" {
  name = "s3ecpolicy"
  role = "${aws_iam_role.s3role.id}"

  policy = "${file("s3ec2policy.json")}"
}

resource "aws_iam_role" "s3role" {
  name = "s3role"

  assume_role_policy = "${file("ec2assume.json")}"
}


resource "aws_iam_instance_profile" "instprofile" {
  name = "example_profile"
  role = "${aws_iam_role.s3role.name}"
}


resource "aws_vpc" "dest" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.dest.id
}


resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.dest.id
    cidr_block = "10.0.0.0/26"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
}


resource "aws_subnet" "sub2" {
    vpc_id = aws_vpc.dest.id
    cidr_block = "10.0.0.64/26"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
}


resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.dest.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table_association" "ra1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.RT.id
}


resource "aws_route_table_association" "ra2" {
    subnet_id = aws_subnet.sub2.id
    route_table_id = aws_route_table.RT.id
}


resource "aws_security_group" "lbsg" {
    name = "lb"
    vpc_id = aws_vpc.dest.id

    ingress  {
        description = "HTTP request from VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    
    
    ingress  {

        description = "SSH request from VPC"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "websg" {
    name = "web"
    vpc_id = aws_vpc.dest.id
    ingress {
        description = "from lb to instance"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.lbsg.id]
    }
     egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "web1" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.websg.id]
    subnet_id = aws_subnet.sub1.id
    user_data = base64encode(file("userdata1.sh")) 
    iam_instance_profile = "${aws_iam_instance_profile.instprofile.name}"
    tags = {
    Name = "WEBAPP"
  }
}


resource "aws_instance" "web2" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.websg.id]
    subnet_id = aws_subnet.sub2.id
    user_data = base64encode(file("userdata2.sh"))  
    iam_instance_profile = "${aws_iam_instance_profile.instprofile.name}"
    tags = {
    Name = "Payment"
  }
}


resource "aws_lb_target_group" "tg" {
    name = "webtg"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.dest.id

    health_check {
      path = "/"
      port = "traffic-port"
    }
}

resource "aws_lb_target_group_attachment" "tg_at1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "tg_at2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.web2.id
  port = 80
}

resource "aws_lb" "alb" {
    name = "mylb"
    internal = true
    load_balancer_type = "application"
    security_groups = [aws_security_group.lbsg.id]
    subnets = [aws_subnet.sub1.id, aws_subnet.sub2.id]
}
resource "aws_lb_listener" "listen" {
    load_balancer_arn = aws_lb.alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
      target_group_arn = aws_lb_target_group.tg.arn
      type = "forward"
    }
  
}

output "loadbalancerdns" {
    value = aws_lb.alb.dns_name
  
}


