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
    owner = "tavisca-abhishek-srivastava"
   
}

resource "github_repository" "example" {
  name        = "tf-gh-example"
  description = "My awesome web page"
  visibility = "private"

}