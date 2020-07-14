# variable "acme_registration_email" {
#     description = "Email address to be associated with the Let's Encrypt private key registration"
# }

# variable "manage_zone" {
#     description = "The Cloud DNS Managed Zone that will contain the notebook server's DNS records"
# }

# variable "servername" {
#     description = "Name of the notebook server"
# }

# variable "acme_server_url" {
#     description = "URL for the Let's Encrypt ACME server"
#     default = "https://acme-v02.api.letsencrypt.org/directory"
# }

# variable "disk_size" {
#     description = "Size of the notebook server boot disk"
#     default = "16" # (Gigabytes)
# }

# variable "jupyter_server_port" {
#     description = "Port the notebook server will listen on"
#     default = "8089"
# }

# variable "use_acme_cert" {
#     description = "Acquire a Let's Encrypt issued certificate and install it on the notebook server"
#     default = true
# }

variable "project" {
    description = "Name of the project that will contain the notebook server"
    default = "optimal-bivouac-247023"
}

variable "network" {
    description = "The Google Cloud Platform network the notebook server will be attached to"
    default = "default"
}

variable "region" {
    description = "The compute region the notebook server will run in"
    default = "us-east1"
}

variable "zone" {
    description = "The compute zone the notebook server will run in"
    default = "us-east1-b"
}

variable "machine_type" {
    description = "Notebook server machine type"
    default = "n1-standard-1"
}