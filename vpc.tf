/*
new VPC named "vpc_devops"
*/

resource "aws_vpc" "vpc_devops" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags {
        Name = "vpc_devops"
    }
}

/*
attaching Internet Gateway
*/

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.vpc_devops.id}"
}

/*
  Public Subnet
*/

resource "aws_security_group" "sg_devops" {
    name = "sg_devops"
    description = "Allow traffic to pass from the public subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "HTTP"
        cidr_blocks = ["${var.public_subnet_cidr}"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
        cidr_blocks = ["0.0.0.0/0"]
    }
   egress {
        from_port = 80
        to_port = 80
        protocol = "http"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

}

resource "aws_instance" "ec2_devops" {
    ami = "ami-30913f47" # ami preconfigured to do NAT
    availability_zone = "eu-west-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.sg_devops.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "ec2_devops"
    }
}


/*
  Public Subnet
*/

resource "aws_subnet" "sub_public_devops" {
    vpc_id = "${aws_vpc.vpc_devops.id}"

    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"

    tags {
        Name = "sub_public_devops"
    }
}

resource "aws_route_table" "eu-west-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_vpc.default.id}"
    }

    tags {
        Name = "sub_public_devops"
    }
}

resource "aws_route_table_association" "sub_public_devops" {
    subnet_id = "${aws_subnet.sub_public_devops.id}"
    route_table_id = "${aws_route_table.sub_public_devops.id}"
}
