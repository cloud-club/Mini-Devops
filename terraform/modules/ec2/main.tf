# EC2
resource "aws_instance" "ec2" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  availability_zone      = "${var.availability_zone}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.keypair_name}"
  vpc_security_group_ids = ["${var.bastion_sg.id}"]

  associate_public_ip_address = true

  tags = {Name = "${var.name}"}
}
