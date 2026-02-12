output "bigdata_kda_service_role_arn" {
  value = aws_iam_role.Bigdata-KDA-Service-Role.arn
}

output "bigdata_glue_service_role_arn" {
  value = aws_iam_role.Bigdata-Glue-Service-Role.arn
}


output "bigdata_HermesK8s_service_role_arn" {
  value = aws_iam_role.Bigdata-HermesK8s-Service-Role.arn
}