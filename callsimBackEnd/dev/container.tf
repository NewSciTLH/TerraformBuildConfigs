data "google_secret_manager_secret_version" "secretkey" {
  secret = "dev-call-sim-backend-servacckey"
}

module "gce-container" {
  source = "github.com/terraform-google-modules/terraform-google-container-vm"

  container = {
    image = var.container_image

    env = [
      {
        name  = "servacckey"
        value = data.google_secret_manager_secret_version.secretkey.secret_data
      },
    ]
  }

  restart_policy = "Always"
}