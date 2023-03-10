resource "aws_codedeploy_app" "deploy_app" {
  compute_platform = var.compute_platform
  name             = var.app_name
}