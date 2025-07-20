resource "aws_dynamodb_table" "tfer--AnalysisResults" {
  attribute {
    name = "patient"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "patient"
  name         = "AnalysisResults"

  point_in_time_recovery {
    enabled = "false"
  }

  range_key      = "timestamp"
  read_capacity  = "0"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "0"
}

resource "aws_dynamodb_table" "tfer--ClinicalRecords" {
  attribute {
    name = "patient"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "patient"
  name         = "ClinicalRecords"

  point_in_time_recovery {
    enabled = "false"
  }

  range_key      = "timestamp"
  read_capacity  = "0"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "0"
}

resource "aws_dynamodb_table" "tfer--DoctorPatient" {
  attribute {
    name = "doctor"
    type = "S"
  }

  attribute {
    name = "patient"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "patient"
  name         = "DoctorPatient"

  point_in_time_recovery {
    enabled = "false"
  }

  range_key      = "doctor"
  read_capacity  = "0"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "0"
}

resource "aws_dynamodb_table" "tfer--IoTPatient" {
  attribute {
    name = "deviceId"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "deviceId"
  name         = "IoTPatient"

  point_in_time_recovery {
    enabled = "false"
  }

  read_capacity  = "0"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "0"
}

resource "aws_dynamodb_table" "tfer--Patient" {
  attribute {
    name = "patientId"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "patientId"
  name         = "Patient"

  point_in_time_recovery {
    enabled = "false"
  }

  read_capacity  = "0"
  stream_enabled = "false"
  table_class    = "STANDARD"
  write_capacity = "0"
}
