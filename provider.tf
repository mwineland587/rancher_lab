terraform {
  required_providers { #### ansible provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
