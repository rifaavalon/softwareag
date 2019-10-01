provider "aws" {
  region = "us-west-2"
}

module "remote_state_global" {
  source = "../terraform/remote_state"

  environment = "global"
}
