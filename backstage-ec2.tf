resource "aws_instance" "backstage_ec2" {

  for_each = var.backstage_ec2_enable ? [var.backstage_ec2] : {}

  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  associate_public_ip_address = each.value.associate_public_ip_address
  monitoring                  = each.value.monitoring
  subnet_id                   = each.value.subnet_id

  vpc_security_group_ids = [aws_security_group.loadtest.id]
  iam_instance_profile   = aws_iam_instance_profile.loadtest.name

  user_data_base64 = local.setup_leader_base64

  #PUBLISHING SCRIPTS AND DATA
  key_name = aws_key_pair.loadtest.key_name
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.ssh_user
    private_key = tls_private_key.loadtest.private_key_pem
  }

  #CLONE REPO
  #https://github.com/backstage/backstage.git

  #CONSTROI CONTAINER

  provisioner "remote-exec" {
    inline = [
      "echo '${tls_private_key.loadtest.private_key_pem}' > ~/.ssh/id_rsa",
      "chmod 600 ~/.ssh/id_rsa",
      "sudo mkdir -p ${var.loadtest_dir_destination} || true",
      "sudo chown ${var.ssh_user}:${var.ssh_user} ${var.loadtest_dir_destination} || true"
    ]
  }

  provisioner "file" {
    destination = var.loadtest_dir_destination
    source      = var.loadtest_dir_source
  }

  tags = merge(
    var.tags,
    var.leader_tags
  )
}
