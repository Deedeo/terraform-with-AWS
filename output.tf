 output "my_alb_dns_name" {
    value = aws_lb.my_alb.dns_name
  }
 output "instances_public_ip" {
    value = [aws_instance.web-servers.*.public_ip]
 
  }

output "domain_name" {
    value = "${aws_route53_record.name.name}"
  }

  


   
 