variable "service_account_name" {
    description = "Name of Kubernetes Service Account"
    type        = string
}

variable "iam_role_name" {
    description = "AWS IAM Role name (If not specified, ${service_account_name}-role is defaulted.)"
    type        = string
    default     = ""
}

variable "iam_policy_arns" {
    description = "List of IAM Policy ARNs to Attach to IAM Role"
    type        = list(string)
}

variable "kubernetes_namespace" {
    description = "Kubernetes Namespace where Service Account will be created"
    type        = string
    default     = ""
}

variable "enabled_sts_services" {
    description = "Enabled STS Services (rds, s3, ec2 etc.)"
    type        = list(string)
}

variable "provision_k8s_sa" {
    description = "Provision Kubernetes Service Account"
    type        = bool
    default     = true
}

variable "openid_connect_provider_arn" {
    description = "ARN of an Existing OIDC Provider"
    type        = string
}

variable "openid_connect_provider_url" {
    description = "URL of an Existing OIDC Provider"
    type        = string
}