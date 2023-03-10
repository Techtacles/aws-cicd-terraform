

#Iam policy
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

resource "aws_iam_role" "code_build_iam" {
  name               = var.iam_role
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

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
      variable = "ec2:Subnet"

      values = [
        aws_subnet.example1.arn,
        aws_subnet.example2.arn,
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"
      values   = ["codebuild.amazonaws.com"]
    }
  }

}

resource "aws_iam_role_policy" "iam_policy" {
  role   = aws_iam_role.code_build_iam.name
  policy = data.aws_iam_policy_document.iam_policy.json
}



#Code build project
resource "aws_codebuild_project" "codebuild_project" {
  name          = var.project_name
  description   = var.project_description
  build_timeout = var.project_timeout
  service_role  = aws_iam_role.code_build_iam.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    
  }


  source {
    type            = "GITHUB"
    location        = var.github_name
    git_clone_depth = 1

  }
}

