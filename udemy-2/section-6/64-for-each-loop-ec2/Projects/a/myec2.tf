module "update-ami" {
    source = "../../modules/update-ami"
}


module "ec2module" {

    depends_on = [ module.update-ami]

    source = "../../modules/ec2"
    name_security_groups = "cb-citrix-module-nrt-sg"  # name_security_groups is getting overridden
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