terraform {
  backend "gcs" {
    bucket = "newsci-divvyup-239622-tfstate"
    prefix = "build/autoColorization"
    credentials = "../../servacc.json"
  }
}