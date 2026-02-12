output "swe_zpes_glue_service_role_arn" {
  value = aws_iam_role.swe_zpes_glue_service_role.arn
}


output "swe_zpes_flink_service_role_arn" {
  value = aws_iam_role.swe_zpes_flink_service_role.arn
}

output "swe_zpes_pass_role_list" {
  value = [
    aws_iam_role.swe_zpes_glue_service_role.arn,
    aws_iam_role.swe_zpes_flink_service_role.arn,
  ]
}