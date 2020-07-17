variable "project" {
    type = string
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