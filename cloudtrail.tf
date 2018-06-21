resource "aws_cloudtrail" "akana-tf-cloudtrail" {
  name                          = "akana-tf-cloudtrail"
  s3_bucket_name                = "${aws_s3_bucket.akana-tf-cloudtrail.id}"
  s3_key_prefix                 = "prefix"
  include_global_service_events = true

  tags = {
    Terraform   = "true"
    Environment = "${var.environment}"
    Name        = "cloudtrail"
  }
}

resource "aws_s3_bucket" "akana-tf-cloudtrail" {
  bucket        = "akana-tf-cloudtrail"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::akana-tf-cloudtrail"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::akana-tf-cloudtrail/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
