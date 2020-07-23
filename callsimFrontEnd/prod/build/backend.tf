terraform {
  backend "gcs" {
    bucket = "call-sim-239622-tfstate"
    prefix = "callsim/prod/build"
    credentials = "../../servacc.json"
  }
}