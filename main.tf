module "code_build" {
    source = "./modules/code_build"  
    iam_role=var.iam_role
    iam_resources = var.iam_resources
    project_name=var.project_name
    project_description = var.project_description
    project_timeout = var.project_timeout
    github_name = var.github_name
    github_branch = var.github_branch
}


module "code_deploy" {
    source = "./modules/code_deploy"
    app_name=var.app_name
    compute_platform=var.compute_platform  
    iam_role = var.iam_role
    policy_arn = var.policy_arn
    deployment_group_name = var.deployment_group_name
}

module "ec2" {
    source = "./modules/ec2"
    owner_id = var.owner_id
    instance_type = var.instance_type
}

module "ecr" {
    source = "./modules/ecr"
    ecr_repo_name = var.ecr_repo_name
  
}