terraform {
  backend "gcs" {
    bucket = "call-sim-tfstate"
    prefix = "callsim/dev/frontend"
  }
}