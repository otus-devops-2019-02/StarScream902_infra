terraform {
  backend "gcs" {
    bucket  = "infra-starscream902-terraform-states"
    prefix  = "stage"
  }
}
