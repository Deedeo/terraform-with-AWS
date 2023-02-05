data "aws_route53_zone" "domain" {
  name         = var.hostedname
}
  
resource "aws_route53_record" "name" {
    zone_id = data.aws_route53_zone.domain.zone_id
    name    = var.sub-domain
    type    = "A"
    alias {
        name                   = aws_lb.my_alb.dns_name
        zone_id                = aws_lb.my_alb.zone_id
        evaluate_target_health = true
    }
  
}