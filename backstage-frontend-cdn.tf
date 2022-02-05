module "cdn" {
  source = "cloudposse/cloudfront-s3-cdn/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  namespace         = "eg"
  stage             = "prod"
  name              = "app"
  aliases           = ["assets.cloudposse.com"]
  dns_alias_enabled = true
  parent_zone_name  = "cloudposse.com"
  deployment_principal_arns = {
    "arn:aws:iam::123456789012:role/principal1" = ["prefix1/", "prefix2/"]
    "arn:aws:iam::123456789012:role/principal2" = [""]
  }
}
