resource "aws_route53_record" "innwait-com-MX" {
  zone_id = "Z1HUHVR0LV2MC5"
  name    = "innwait.com"
  type    = "MX"
  records = ["10 eforward1.registrar-servers.com.", "10 eforward2.registrar-servers.com.", "10 eforward3.registrar-servers.com.", "15 eforward4.registrar-servers.com.", "20 eforward5.registrar-servers.com."]
  ttl     = "3600"
}

resource "aws_route53_record" "innwait-com-NS" {
  zone_id = "Z1HUHVR0LV2MC5"
  name    = "innwait.com"
  type    = "NS"
  records = ["ns-1930.awsdns-49.co.uk.", "ns-820.awsdns-38.net.", "ns-200.awsdns-25.com.", "ns-1463.awsdns-54.org."]
  ttl     = "172800"
}

resource "aws_route53_record" "innwait-com-SOA" {
  zone_id = "Z1HUHVR0LV2MC5"
  name    = "innwait.com"
  type    = "SOA"
  records = ["ns-1930.awsdns-49.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"
}

resource "aws_route53_record" "innwait-com-TXT" {
  zone_id = "Z1HUHVR0LV2MC5"
  name    = "innwait.com"
  type    = "TXT"
  records = ["\"v=spf1\" \"include:spf.efwd.registrar-servers.com\" \"~all\""]
  ttl     = "3600"
}

resource "aws_route53_record" "www-innwait-com-CNAME" {
  zone_id = "Z1HUHVR0LV2MC5"
  name    = "www.innwait.com"
  type    = "CNAME"
  records = ["d2i656uinpzg0q.cloudfront.net."]
  ttl     = "1799"
}

resource "aws_route53_record" "buzser-com-A" {
  zone_id = "ZDP2550YODVT3"
  name    = "buzser.com"
  type    = "A"

  alias {
    name                   = "d2qp433nxwpvkp.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "buzser-com-NS" {
  zone_id = "ZDP2550YODVT3"
  name    = "buzser.com"
  type    = "NS"
  records = ["ns-521.awsdns-01.net.", "ns-1088.awsdns-08.org.", "ns-1967.awsdns-53.co.uk.", "ns-403.awsdns-50.com."]
  ttl     = "172800"
}

resource "aws_route53_record" "buzser-com-SOA" {
  zone_id = "ZDP2550YODVT3"
  name    = "buzser.com"
  type    = "SOA"
  records = ["ns-1967.awsdns-53.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
  ttl     = "900"
}

resource "aws_route53_record" "buzser-com-TXT" {
  zone_id = "ZDP2550YODVT3"
  name    = "buzser.com"
  type    = "TXT"
  records = ["\"v=spf1 include:spf.efwd.registrar-servers.com ~all\""]
  ttl     = "60"
}

resource "aws_route53_record" "_e89c011078bbf87c1472ade020069751-buzser-com-CNAME" {
  zone_id = "ZDP2550YODVT3"
  name    = "_e89c011078bbf87c1472ade020069751.buzser.com"
  type    = "CNAME"
  records = ["_aced8efc9346659190ef2a2b416b7c68.duyqrilejt.acm-validations.aws."]
  ttl     = "300"
}

resource "aws_route53_record" "www-buzser-com-CNAME" {
  zone_id = "ZDP2550YODVT3"
  name    = "www.buzser.com"
  type    = "CNAME"
  records = ["d2qp433nxwpvkp.cloudfront.net"]
  ttl     = "500"
}

