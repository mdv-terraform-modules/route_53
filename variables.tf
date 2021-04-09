variable "domain_name" {}
variable "dns_name" {}
variable "zone_id" {}

variable "names_for_route53_record" {
  default = [
    "www",
    "app1",
    "app2",
  ]
}
