output "zxc_lambda_service_role_arn" {
  value = aws_iam_role.zxc_lambda_service_role.arn
}


output "zxc_flink_service_role_arn" {
  value = aws_iam_role.zxc_flink_service_role.arn
}
output "zxc_lambda_role_arn" {
  value = aws_iam_role.zxc_lambda_service_role.arn
}

output "zxc_pass_role_list" {
  value = [
#    aws_iam_role.zxc_glue_service_role.arn,
    aws_iam_role.zxc_flink_service_role.arn,
  ]
}