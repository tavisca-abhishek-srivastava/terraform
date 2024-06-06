output "sg_id" {
    value = aws_security_group.security_group.id
    description = "ID of the security group."   
}

output "sg_arn" {
    value = aws_security_group.security_group.arn
    description = "ARN of the security group."
}

output "sg_owner_id" {
    value = aws_security_group.security_group.owner_id
    description = "Owner ID."
}

output "sg_tags_all" {
    value = aws_security_group.security_group.tags_all
    description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}