resource "aws_iam_instance_profile" "cloudwatch_profile" {
  name = "cloudwatch_profile"
  role = "${aws_iam_role.cloudwatch_role.name}"
}

resource "aws_iam_role" "cloudwatch_role" {
  name = "cloudwatch_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "awslogs_iam_role_inline_policy" {
  name = "awslogs_iam_role_policy"
  role = "${aws_iam_role.cloudwatch_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublishToCloudwatchLogs",
      "Effect": "Allow",
      "Action": [
        "cloudwatch:PutMetricData",
        "ec2:DescribeTags",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups",
        "logs:CreateLogStream",
        "logs:CreateLogGroup",
        "logs:CreateLogStream"
    ],
      "Resource": [
        "*"
    ]
  }
 ]
}
EOF
}
