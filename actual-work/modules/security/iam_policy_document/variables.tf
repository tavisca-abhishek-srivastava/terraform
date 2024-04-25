variable "key_policy_statements" {
  description = "All the statements for the key policy"
  type = map(object({
    sid = string
    actions = list(string)
    resources = list(string)
    effect = string
    principals = object({
      identifiers = list(string)
    })
  }))
default = {}
}