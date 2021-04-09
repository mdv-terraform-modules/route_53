#======================= Create Route53 Primary Zone =================================

resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

#======================= Create Route53 Records =================================

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "records" {
  count   = length(var.names_for_route53_record)
  zone_id = aws_route53_zone.primary.zone_id
  name    = "${var.names_for_route53_record[count.index]}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_route53_record.main.name
    zone_id                = aws_route53_zone.primary.zone_id
    evaluate_target_health = true
  }
}
