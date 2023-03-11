data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_role" {
  name               = var.iam_role
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_codedeploy_app" "deploy_app" {
  compute_platform = var.compute_platform
  name             = var.app_name
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = var.policy_arn
  role       = var.iam_role
}



resource "aws_codedeploy_deployment_group" "example" {
  app_name              = aws_codedeploy_app.deploy_app.name
  deployment_group_name =var.deployment_group_name
  service_role_arn      = aws_iam_role.iam_role.arn

  
}