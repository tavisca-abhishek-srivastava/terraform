provider aws{

    region ="us-east-1"
}

module "consul" {
  source  = "hashicorp/consul/aws"
  version = "0.11.0"
  # insert the 4 required variables here
  ami_id = "ami-033b95fb8079dc481"
  ssh_key_name = "${var.privatekeyPath}"
  cluster_name = "consul cluster"
}

