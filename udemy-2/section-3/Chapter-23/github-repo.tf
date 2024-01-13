terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
    token = "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"
   
}

resource "github_repository" "example" {
  name        = "tf-gh-example"
  description = "My awesome web page"
  visibility = "private"

}