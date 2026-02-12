output "swe_zpes_flink_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*flink.*", s.id)) > 0][0].arn
}
output "swe_zpes_flink_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*flink.*", s.id)) > 0][0].id
}

output "swe_zpes_glue_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*glue.*", s.id)) > 0][0].arn
}
output "swe_zpes_glue_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*glue.*", s.id)) > 0][0].id
}

output "swe_zpes_msk_logs_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*msk-logs.*", s.id)) > 0][0].arn
}
output "swe_zpes_msk_logs_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*msk-logs.*", s.id)) > 0][0].id
}

output "swe_zpes_app-be_s3_arn" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*app-be.*", s.id)) > 0][0].arn
}
output "swe_zpes_app-be_s3_bucket" {
  value = [for s in aws_s3_bucket.private_bucket_list : s if length(regexall(".*app-be.*", s.id)) > 0][0].id
}