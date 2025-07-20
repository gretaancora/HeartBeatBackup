resource "aws_s3_bucket" "tfer--batchdataheartbeat" {
  arn                 = "arn:aws:s3:::batchdataheartbeat"
  bucket              = "batchdataheartbeat"
  force_destroy       = "false"
  hosted_zone_id      = "Z3AQBSTGFYJSTF"
  object_lock_enabled = "false"
  request_payer       = "BucketOwner"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }

      bucket_key_enabled = "true"
    }
  }

  versioning {
    enabled    = "false"
    mfa_delete = "false"
  }
}

resource "aws_s3_bucket" "tfer--frontend-heartbeat" {
  arn                 = "arn:aws:s3:::frontend-heartbeat"
  bucket              = "frontend-heartbeat"
  force_destroy       = "false"
  hosted_zone_id      = "Z3AQBSTGFYJSTF"
  object_lock_enabled = "false"
  request_payer       = "BucketOwner"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }

      bucket_key_enabled = "true"
    }
  }

  versioning {
    enabled    = "false"
    mfa_delete = "false"
  }

  website {
    index_document = "login.html"
  }

  website_domain   = "s3-website-us-east-1.amazonaws.com"
  website_endpoint = "frontend-heartbeat.s3-website-us-east-1.amazonaws.com"
}
