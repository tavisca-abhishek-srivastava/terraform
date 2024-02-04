module "update-ami" {
    source = "../../modules/update-ami"
    
}


module "ec2module" {
    
    source = "../../modules/ec2"
    
}