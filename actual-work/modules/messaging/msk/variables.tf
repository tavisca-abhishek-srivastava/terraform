variable "cluster_name" {
  description = "Name of MSK Cluster"
  type        = string
  default     = "tf-s3-to-pg"
}
variable "kafka_version" {
  description = "Kafka Version"
  type        = string
  default     = "3.6.0"
}
variable "client_subnets" {
  description = "Subnet for brokers"
  type        = list(string)
  default = [
    "subnet-04c8a1cce0a80f526",
    "subnet-001023c820ce7e35c",
    "subnet-08792a1a703950fe7",
  ]
    validation {
      condition = length(var.client_subnets) >= 3
      error_message = "pls define atleast 3 subnets"
    }

}
variable "number_of_broker_nodes" {
  description = "number of brokers in cluster"
  type        = number
  default     = 3

  validation {
      condition = var.number_of_broker_nodes >= 3
      error_message = "pls define atleast 3 brokers in different subnet"
    }
}
variable "instance_type" {
  description = "type of instance of broker"
  type        = string
  default     = "kafka.m5.large"
}
variable "security_groups" {
  description = "Security group"
  type        = list(string)
  default     = ["sg-07c3c80e71d4b954e"]

   validation {
      condition = var.security_groups >= 1
      error_message = "pls define atleast 1 Security Group"
    }
}
variable "encryption_in_transit_client_broker" {
  description = "(Optional) Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value is TLS"
  type = string
  default = "TLS_PLAINTEXT"
}
variable "cloud_watch_log_group_retention_days" {
  type = number
  default = 14
}
########## KMS variables
variable "key_policy_map" {
  description = "A valid policy JSON document"
  type = any
  default = {
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::928814396842:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::928814396842:role/adfs-devops",
            "arn:aws:iam::928814396842:role/adfs-governance"
          ]
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::928814396842:role/adfs-devops",
            "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka"
            
          ]
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::928814396842:role/adfs-devops",
            "arn:aws:iam::928814396842:role/aws-service-role/kafka.amazonaws.com/AWSServiceRoleForKafka"
           
          ]
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  }
}
variable "delete_after_days" {
    description = " The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key.it must be between 7 and 30, inclusive"
    type = number
    default = 30
}

variable "tags" {
  type = object({
    AppName             =   string
    Backup              =   string
    BusinessUnit        =   string
    DataClassification  =   string
    Environment         =   string
    InfraOwner          =   string
    Name                =   string    
    Product             =   string
    Squad               =   string
  })
}