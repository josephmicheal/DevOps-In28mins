

//S3 Bucket

resource "aws_s3_bucket" "enterprise_backend_state" {
  bucket = "dev-apps-backend-state-joseph801"

  lifecycle {
    prevent_destroy = true # not abllow to delete
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule{
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
    }
  }
}

//Locking using AWS Dynamo DB

resource "aws_dynamodb_table" "enterprise_backend_lock" {
  name="dev_apps_locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key="LockID"
  attribute{
      name="LockID"
      type="S"
  }
}