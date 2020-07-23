terraform {
  backend "gcs" {
    bucket = "newsci-divvyup-239622-tfstate"
    prefix = "callsim/prod/build"
    credentials = "../../servacc.json"
  }
}