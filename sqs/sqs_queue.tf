resource "aws_sqs_queue" "tfer--ECGTraces-002E-fifo" {
  content_based_deduplication       = "false"
  deduplication_scope               = "queue"
  delay_seconds                     = "0"
  fifo_queue                        = "true"
  fifo_throughput_limit             = "perQueue"
  kms_data_key_reuse_period_seconds = "300"
  max_message_size                  = "262144"
  message_retention_seconds         = "1800"
  name                              = "ECGTraces.fifo"

  policy = <<POLICY
{
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Action": "sqs:SendMessage",
      "Effect": "Allow",
      "Principal": {
        "Service": "iot.amazonaws.com"
      },
      "Resource": "arn:aws:sqs:eu-west-1:123456789012:ECGTraces.fifo",
      "Sid": "AllowIoTRule"
    },
    {
      "Action": "SQS:*",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::832059618623:root"
      },
      "Resource": "arn:aws:sqs:us-east-1:832059618623:ECGTraces.fifo",
      "Sid": "__owner_statement"
    },
    {
      "Action": "SQS:SendMessage",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::832059618623:role/LabRole"
      },
      "Resource": "arn:aws:sqs:us-east-1:832059618623:ECGTraces.fifo",
      "Sid": "__sender_statement"
    },
    {
      "Action": [
        "SQS:ChangeMessageVisibility",
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::832059618623:role/LabRole"
      },
      "Resource": "arn:aws:sqs:us-east-1:832059618623:ECGTraces.fifo",
      "Sid": "__receiver_statement"
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  receive_wait_time_seconds  = "0"
  sqs_managed_sse_enabled    = "true"
  visibility_timeout_seconds = "30"
}

resource "aws_sqs_queue" "tfer--bpmValues-002E-fifo" {
  content_based_deduplication       = "false"
  deduplication_scope               = "messageGroup"
  delay_seconds                     = "0"
  fifo_queue                        = "true"
  fifo_throughput_limit             = "perMessageGroupId"
  kms_data_key_reuse_period_seconds = "300"
  max_message_size                  = "262144"
  message_retention_seconds         = "1800"
  name                              = "bpmValues.fifo"

  policy = <<POLICY
{
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Action": "SQS:*",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::832059618623:root"
      },
      "Resource": "arn:aws:sqs:us-east-1:832059618623:bpmValues.fifo",
      "Sid": "__owner_statement"
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  receive_wait_time_seconds  = "0"
  sqs_managed_sse_enabled    = "true"
  visibility_timeout_seconds = "30"
}
