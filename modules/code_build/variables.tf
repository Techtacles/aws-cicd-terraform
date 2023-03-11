#Code build iam
variable "iam_role" {
    type = string
}
variable "iam_resources" {}

variable "build_spec" {}

variable "repo_uri" {}
variable "image_tag" {}
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
variable "github_branch" { }
variable "github_repo" {}