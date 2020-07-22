terraform {
  backend "gcs" {
    bucket = "newsci-divvyup-239622-tfstate"
    prefix = "autoColorization/dev"
    credentials = "../servacc.json"
  }
}