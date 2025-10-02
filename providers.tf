terraform {
  required_version = ">= 1.1.0"
  required_providers {
    devzero = {
      source  = "devzero-inc/devzero"
      version = ">= 0.1.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.2"
    }
  }
}