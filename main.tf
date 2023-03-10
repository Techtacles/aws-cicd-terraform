module "code_build" {
    source = "./modules/code_build"  
    iam_role=var.iam_role
    iam_resources = var.iam_resources
    project_name=var.project_name
    project_description = var.project_description
    project_timeout = var.project_timeout
    github_name = var.github_name
}


module "code_deploy" {
    source = "./modules/code_deploy"
    app_name=var.app_name
    compute_platform=var.compute_platform  
}
