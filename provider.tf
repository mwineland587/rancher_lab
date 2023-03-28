terraform {
  required_providers { #### ansible provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    rancher2 = {
      source = "rancher/rancher2"
      version = "~> 1.25.0"
    }
  }
}
