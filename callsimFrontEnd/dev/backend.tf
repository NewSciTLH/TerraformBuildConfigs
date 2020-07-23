terraform {
  backend "gcs" {
    bucket = "call-sim-239622-tfstate"
    prefix = "callsim/dev/frontend"
  }
}