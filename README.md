# Terraform Module - EKS Service Account With OIDC-Integrated IAM Role

Terraform Module to create an EKS Kubernetes Service Account, bound to a related IAM Role via an IAM Policy Document.

Allows for attaching any number of IAM policies and allowing any AWS Service via it's named prefix I.E ec2, rds, s3.

Intended as a Terraform-native solution to replace the solution offered by **eksctl** and **aws cli** as outlined in the AWS Docs [here](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).

See the blog post [here](https://www.tinfoilcipher.co.uk/2021/09/12/eks-configuring-iam-roles-for-service-accounts-using-terraform/) for an in-depth breakdown.

## tl;dr

```
terraform init
terraform apply
```

### Create IAM Role Componenets and Kubernetes Service Account

```
module "tinfoil_sa" {
    source                      = "tinfoilcipher/eks-service-account-with-oidc-iam-role/aws"
    version                     = "x.x.x"
    service_account_name        = "my-service-account"
    iam_policy_arns             = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::123456789012:policy/custom-policy"]
    kubernetes_namespace        = "some-namespace"
    enabled_sts_services        = ["ec2", "rds", "s3"]
    openid_connect_provider_arn = module.eks_cluster.oidc_provider_arn
    openid_connect_provider_url = module.eks_cluster.oidc_provider_url
}
```

### Create an IAM role component and Kubernetes service account and specify the IAM role name

```
module "tinfoil_sa" {
    source                      = "tinfoilcipher/eks-service-account-with-oidc-iam-role/aws"
    version                     = "x.x.x"
    service_account_name        = "my-service-account"
    iam_policy_arns             = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::123456789012:policy/custom-policy"]
    kubernetes_namespace        = "some-namespace"
    enabled_sts_services        = ["ec2", "rds", "s3"]
    openid_connect_provider_arn = module.eks_cluster.oidc_provider_arn
    openid_connect_provider_url = module.eks_cluster.oidc_provider_url
    iam_role_name               = "my-iam-role-name"
}
```

### Create IAM Role Componenets Only

```
module "tinfoil_sa" {
    source                      = "tinfoilcipher/eks-service-account-with-oidc-iam-role/aws"
    version                     = "x.x.x"
    service_account_name        = "tinfoil-sa"
    iam_policy_arns             = ["arn:aws:iam::668264849718:policy/tinfoil-limited-access"]
    kubernetes_namespace        = "tinfoil"
    enabled_sts_services        = ["ec2", "rds", "s3"]
    openid_connect_provider_arn = module.eks_cluster.oidc_provider_arn
    openid_connect_provider_url = module.eks_cluster.oidc_provider_url
    provision_k8s_sa            = false
}
```
