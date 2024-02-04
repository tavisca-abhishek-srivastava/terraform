
module "update-ami" {
    source = "../../modules/update-ami"
    
}


module "ec2module" {
    depends_on = [ module.update-ami ]
    source = "../../modules/ec2"
    
}