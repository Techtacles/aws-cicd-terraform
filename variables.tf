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

#Code deploy deploy
variable "app_name"{}
variable "compute_platform" {
    type = string
}