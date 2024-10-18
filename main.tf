resource "aws_iam_role" "this" {
    name                = var.iam_role_name != "" ? var.iam_role_name : "${var.service_account_name}-role"
    assume_role_policy  = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
    count       = length(var.iam_policy_arns)
    role        = aws_iam_role.this.name
    policy_arn  = var.iam_policy_arns[count.index]
}

resource "kubernetes_service_account" "this" {
    count = var.provision_k8s_sa ? 1 : 0
    metadata {
        name        = var.service_account_name
        namespace   = var.kubernetes_namespace
        annotations = {
            "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
        }
    }
}