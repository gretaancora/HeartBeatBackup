resource "aws_iot_topic_rule" "tfer--IoT_Simulator_To_SQS" {
  enabled = "true"

  lambda {
    function_arn = "arn:aws:lambda:us-east-1:832059618623:function:sendToSQS"
  }

  name        = "IoT_Simulator_To_SQS"
  sql         = "SELECT * FROM 'IoTSimulator/bpm'"
  sql_version = "2016-03-23"
}
