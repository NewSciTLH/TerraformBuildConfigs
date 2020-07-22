variable "project" {
    type = string
}

variable "region" {
    type = string
    default = "us-central1"
}

variable "container_image" {
    type = string
}

variable "zone" {
    type = string
    default = "us-central1-c"
}

variable "location" {
    type = string
    default = "us-central1-c"
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
    default = "n1-standard-4"
}