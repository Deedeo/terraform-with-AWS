
resource "aws_instance" "web-servers" {
    count = var.instance_count
    ami = "ami-0b5eea76982371e91"
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.websg.id]
    subnet_id = aws_subnet.subnets[(count.index % 2)].id
    key_name = "lab-002"


    tags = local.common_tags
}

resource "null_resource" "web-servers" {
    count = var.instance_count
    triggers = {
        instance_ids = join(",", aws_instance.web-servers[*].id)
    }
    provisioner "remote-exec" {
        inline = ["echo 'ssh is ready'"]

        connection {
          type  = "ssh"
          user  = local.ssh_user
          private_key = file(local.private_key_path)
          host = aws_instance.web-servers[count.index].public_ip
        }          
}
    
    provisioner "local-exec" {
        command = "ansible-playbook -i ${aws_instance.web-servers[count.index].public_ip}, --private-key ${local.private_key_path} ec2.yml"
        
        }
    }

resource "local_file" "inventory" {
  content = "${join("\n",aws_instance.web-servers.*.public_ip)}"
  filename = "host-inventory"
 }
