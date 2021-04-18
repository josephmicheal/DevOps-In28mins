resource "aws_s3_bucket" "my_internal_s3_bucket"{
    bucket = "joseph-s3-bucket-002"
    versioning{
      enabled = true
    }
}

resource "aws_iam_user" "my_iam_user"{
    name = "my_iam_user_001_updated"
}