variable "project" {
    type = string
}

variable "container_image" {
    type = string
}

variable "region" {
    type = string
    default = "us-east1"
}

variable "zone" {
    type = string
    default = "us-east1-b"
}

variable "location" {
    type = string
    default = "us-east1-n"
}

variable "gke_username" {
    type = string
    default = ""
}

variable "gke_password" {
    type = string
    default = ""
}

