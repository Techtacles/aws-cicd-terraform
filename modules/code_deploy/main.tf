data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "code_deploy_iam" {
  name               = var.code_deploy_iam_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.code_deploy_iam.name
}


resource "aws_codedeploy_app" "deploy_app" {
  compute_platform = var.compute_platform
  name             = var.app_name
}


resource "aws_codedeploy_deployment_group" "example" {
  app_name              = aws_codedeploy_app.deploy_app.name
  deployment_group_name =var.deployment_group_name
  service_role_arn      = aws_iam_role.code_deploy_iam.arn
}

# Define the deployment triggers
  trigger_configuration {
    trigger_name        = "codedeploy-trigger"
    trigger_target_arn  = var.trigger_arn
    trigger_events      = ["codebuild-project-build-state-succeeded", "codebuild-project-build-state-failed"]
    trigger_target_type = "AWS_CODEBUILD"
  }