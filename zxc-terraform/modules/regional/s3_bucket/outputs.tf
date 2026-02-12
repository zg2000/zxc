output "aws_zxc_flink_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*flink.*", s.id)) > 0][0].arn
}
output "aws_zxc_flink_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*flink.*", s.id)) > 0][0].id
}

#
output "aws_zxc_msk_logs_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*msk-logs.*", s.id)) > 0][0].arn
}
output "aws_zxc_msk_logs_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*msk-logs.*", s.id)) > 0][0].id
}

output "aws_zxc_data_s3_arn" {
  value = data.aws_s3_bucket.data-bucket.arn
}
output "aws_zxc_data_s3_bucket" {
  value = data.aws_s3_bucket.data-bucket.id
}

output "aws_zxc_lambda_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*lambda.*", s.id)) > 0][0].arn
}
output "aws_zxc_lambda_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*lambda.*", s.id)) > 0][0].id
}