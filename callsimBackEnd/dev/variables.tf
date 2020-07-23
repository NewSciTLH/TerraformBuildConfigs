variable "project" {
    type = string
}

variable "region" {
    type = string
    default = "us-east1"
}

variable "container_image" {
    type = string
}

variable "zone" {
    type = string
    default = "us-east1-b"
}

variable "location" {
    type = string
    default = "us-east1-b"
}

variable "gke_username" {
    type = string
    default = ""
}

variable "gke_password" {
    type = string
    default = ""
}

variable "machine_type" {
    type = string
    default = "n1-standard-2"
}