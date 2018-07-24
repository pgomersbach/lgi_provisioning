resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "terraform-kinesis-firehose-test-stream"
  destination = "splunk"

  s3_configuration {
    role_arn           = "${aws_iam_role.firehose_role.arn}"
    bucket_arn         = "${aws_s3_bucket.akana-tf-splunk.arn}"
    buffer_size        = 10
    buffer_interval    = 400
    compression_format = "GZIP"
  }

  splunk_configuration {
    hec_endpoint               = "${var.hec_endpoint}"
    hec_token                  = "${var.hec_token}"
    hec_acknowledgment_timeout = 600
    hec_endpoint_type          = "Event"
    s3_backup_mode             = "FailedEventsOnly"
  }
}

resource "aws_s3_bucket" "akana-tf-splunk" {
  bucket = "akana-tf-splunk"
  acl    = "private"
  force_destroy = true
}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_test_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
