resource "aws_route53_zone" "innwait-com-public" {
  name    = "innwait.com"
  comment = "domain for innwait.com"

  tags = {}
}

resource "aws_route53_zone" "buzser-com-public" {
  name    = "buzser.com"
  comment = ""

  tags = {}
}

