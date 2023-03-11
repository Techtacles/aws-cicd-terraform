variable "region" {
    type = string
}

variable "access_key" {}
variable "secret_key" {}

#Code build iam
variable "iam_role" {
    type = string
}
variable "iam_resources" {}
variable "buildspec" {}

# Code build project
variable "project_name" {
    type = string
}
variable "project_description" {
    type = string
}
variable "project_timeout" {
    type = string
}
variable "github_name" {
    type = string
}

variable "github_branch" {
    type = string
}
variable "github_repo" {
    type = string
}
variable "image_tag" {}

#Code deploy deploy
variable "app_name"{}
variable "compute_platform" {
    type = string
}
variable "code_deploy_iam_name" {}

#ECR
variable "ecr_repo_name" {}

#EC2
variable "owner_id" {}
variable "instance_type" {}
variable "policy_arn" {}
variable "deployment_group_name" {}
variable "ami_id" {}
