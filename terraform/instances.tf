resource "aws_key_pair" "es_ssh_key" {
  key_name   = "es_ssh_key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "aws_instance" "es_node" {
  count                       = "${var.cluster_size}"
  ami                         = "${var.ami_id}"
  instance_type               = "${var.ami_type}"
  vpc_security_group_ids      = ["${aws_security_group.es_secgroup.id}"]
  subnet_id                   = "${aws_subnet.es_vpc_subnet.id}"
  key_name                    = "${aws_key_pair.es_ssh_key.key_name}"
  associate_public_ip_address = true

  tags = {
    Name = "node${count.index+1}"
    role = "es_node"
  }
}

output "es_node.ips" {
  value = "${aws_instance.es_node.*.public_ip}"
}
