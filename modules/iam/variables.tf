variable "role_name" {
  type        = string
  description = "The name of the IAM Role"
}

variable "profile_name" {
  type        = string
  description = "The name of the IAM Instance Profile"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "List of IAM Policy ARNs to attach to the role"
  default     = []
}
