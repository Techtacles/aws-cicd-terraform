module "code_build" {
  source              = "./modules/code_build"
  iam_role            = var.iam_role
  iam_resources       = var.iam_resources
  project_name        = var.project_name
  project_description = var.project_description
  project_timeout     = var.project_timeout
  github_name         = var.github_name
  github_repo         = var.github_repo
  github_branch       = var.github_branch
  repo_uri            = module.ecr.aws_ecr_repository.ecr_repo.repository_url
  image_tag           = var.image_tag
  code_build_id       = module.code_build.aws_codebuild_project.build_project.id
}


module "code_deploy" {
  source                = "./modules/code_deploy"
  app_name              = var.app_name
  compute_platform      = var.compute_platform
  code_deploy_iam_name  = var.code_deploy_iam_name
  policy_arn            = var.policy_arn
  deployment_group_name = var.deployment_group_name
}

module "ec2" {
  source        = "./modules/ec2"
  owner_id      = var.owner_id
  instance_type = var.instance_type
  ami_id        = var.ami_id
}

module "ecr" {
  source        = "./modules/ecr"
  ecr_repo_name = var.ecr_repo_name

}
