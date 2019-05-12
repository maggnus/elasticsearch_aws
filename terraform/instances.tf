resource "aws_key_pair" "es_ssh_key" {
  key_name   = "es_ssh_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "es_node" {
  ami                         = "${var.ami_id}"
  instance_type               = "${var.ami_type}"
  security_groups             = ["${aws_security_group.es_secgroup.id}"]
  subnet_id                   = "${aws_subnet.es_vpc_subnet.id}"
  key_name                    = "${aws_key_pair.es_ssh_key.key_name}"
  associate_public_ip_address = true

  tags = {
    Name = "node01"
    role = "es_node"
  }
}

output "node01.ip" {
  value = "${aws_instance.es_node.public_ip}"
}
