terraform {
  backend "gcs" {
    bucket = "call-sim-tfstate"
    prefix = "callsim/prod/build"
    credentials = "../../servacc.json"
  }
}