module "update-ami" {
    source = "../../modules/update-ami"
}


module "ec2module" {
    
    source = "../../modules/ec2"
    keyName = "mykey_test_fe_ec2"    #keyName is getting overridden
    sg_egress_rules = {

    rule1 = {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"
        },
    rule2 = {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_block = "10.0.0.0/8"
        },


    }

    
    
}