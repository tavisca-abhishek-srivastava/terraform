terraform {
    cloud {
        organization = "cxloyalty"
        workspaces {
            name = "TaviscaChaseTravel5"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    insecure = true
    default_tags {
        tags = {
            AppName = "test"
            Backup = "no"
            DataClassification = "internal"
            InfraOwner = "poap2"
            Product = "cw"
            BusinessUnit = "poap2"
            Environment = "travel.poc"
        }
    }
}