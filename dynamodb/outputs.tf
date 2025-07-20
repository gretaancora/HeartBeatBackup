output "aws_dynamodb_table_tfer--AnalysisResults_id" {
  value = "${aws_dynamodb_table.tfer--AnalysisResults.id}"
}

output "aws_dynamodb_table_tfer--ClinicalRecords_id" {
  value = "${aws_dynamodb_table.tfer--ClinicalRecords.id}"
}

output "aws_dynamodb_table_tfer--DoctorPatient_id" {
  value = "${aws_dynamodb_table.tfer--DoctorPatient.id}"
}

output "aws_dynamodb_table_tfer--IoTPatient_id" {
  value = "${aws_dynamodb_table.tfer--IoTPatient.id}"
}

output "aws_dynamodb_table_tfer--Patient_id" {
  value = "${aws_dynamodb_table.tfer--Patient.id}"
}
