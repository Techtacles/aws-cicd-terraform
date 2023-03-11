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

data "aws_iam_policy_document" "iam_policy" {

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
    ]

    resources = ["*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateNetworkInterfacePermission"]
    resources = var.iam_resources


    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

}

resource "aws_iam_role_policy" "example" {
  role   = aws_iam_role.iam_role.name
  policy = data.aws_iam_policy_document.iam_policy.json
}

resource "aws_codebuild_project" "build_project" {
  name          = var.project_name
  description   = var.project_description
  build_timeout = var.project_timeout
  service_role  = aws_iam_role.iam_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }


  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"


  }

   environment_variable {
      AWS_DEFAULT_REGION  = "us-east-1"
      REPOSITORY_URI = var.repo_uri
      IMAGE_TAG=var.image_tag
      CODEBUILD_BUILD_ID=var.code_build_id
    }


  source {
    type            = "GITHUB"
    location        = var.github_name
    git_clone_depth = 1
    buildspec = var.build_spec


  }

  source_version = var.github_branch


}


resource "aws_codebuild_webhook" "codebuild_webhook" {
  project_name = aws_codebuild_project.build_project.name
}

resource "github_repository_webhook" "git_webhook" {
  active     = true
  events     = ["push"]
  repository = var.github_repo

}

output "build_id" {
  value=aws_codebuild_project.build_project.id  
}
