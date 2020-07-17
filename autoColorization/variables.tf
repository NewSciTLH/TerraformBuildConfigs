variable "project" {
    type = string
    default = "insert-project-here"
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "zone" {
    type = string
    default = "us-central1-c"
}

variable "location" {
    type = string
    default = "us-east1"
}

variable "gke_username" {
    type = string
    default = ""
}

variable "gke_password" {
    type = string
    default = ""
}