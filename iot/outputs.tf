output "aws_iot_thing_tfer--IoTSimulator_id" {
  value = "${aws_iot_thing.tfer--IoTSimulator.id}"
}

output "aws_iot_topic_rule_tfer--IoT_Simulator_To_SQS_id" {
  value = "${aws_iot_topic_rule.tfer--IoT_Simulator_To_SQS.id}"
}
