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
   
}

resource "github_repository" "example" {
  name        = "tf-gh-example"
  description = "My awesome web page"
  visibility = "private"

}