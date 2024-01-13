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