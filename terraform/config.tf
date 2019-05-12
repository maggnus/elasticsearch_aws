provider "aws" {
  region = "${var.region}"

  # Read access key from AWS_ACCESS_KEY_ID env variable
  # Read secret key from AWS_SECRET_ACCESS_KEY env variable
}

terraform {
  # State file should be located on AWS S3 or anothe storage backend (not implemented)
  required_version = ">= 0.11"
}
