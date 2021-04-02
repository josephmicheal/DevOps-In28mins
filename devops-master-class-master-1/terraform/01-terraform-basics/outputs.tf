output "my_internal_s3_bucket_versioning"{
    value = aws_s3_bucket.my_internal_s3_bucket.versioning[0].enabled
}

output "aws_iam_user_arn"{
    value = aws_iam_user.my_iam_user
}