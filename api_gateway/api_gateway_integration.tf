resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-1zcy6b-002F-OPTIONS" {
  cache_namespace      = "1zcy6b"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "1zcy6b"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-1zcy6b-002F-POST" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "1zcy6b"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "POST"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "1zcy6b"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:addDoctor/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-3k7fm5-002F-GET" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "3k7fm5"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "GET"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "3k7fm5"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:readAnalisysResults/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-3k7fm5-002F-OPTIONS" {
  cache_namespace      = "3k7fm5"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "3k7fm5"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-3wj1ic-002F-OPTIONS" {
  cache_namespace      = "3wj1ic"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "3wj1ic"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-3wj1ic-002F-POST" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "3wj1ic"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "POST"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "3wj1ic"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:login/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-b7759p-002F-GET" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "b7759p"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "GET"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "b7759p"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:readClinicalRecords/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-b7759p-002F-OPTIONS" {
  cache_namespace      = "b7759p"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "b7759p"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-km15j3-002F-OPTIONS" {
  cache_namespace      = "km15j3"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "km15j3"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-km15j3-002F-PUT" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "km15j3"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "PUT"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "km15j3"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:writeClinicalRecords/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-nka6k7-002F-OPTIONS" {
  cache_namespace      = "nka6k7"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "nka6k7"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-nka6k7-002F-POST" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "nka6k7"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "POST"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "nka6k7"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:addPatient/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-q7jwcr-002F-GET" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "q7jwcr"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "GET"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "q7jwcr"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:patientReadClinicalRecords/invocations"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-q7jwcr-002F-OPTIONS" {
  cache_namespace      = "q7jwcr"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "q7jwcr"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-wryi90-002F-OPTIONS" {
  cache_namespace      = "wryi90"
  connection_type      = "INTERNET"
  http_method          = "OPTIONS"
  passthrough_behavior = "WHEN_NO_MATCH"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }

  resource_id          = "wryi90"
  rest_api_id          = "868ccyrv02"
  timeout_milliseconds = "29000"
  type                 = "MOCK"
}

resource "aws_api_gateway_integration" "tfer--868ccyrv02-002F-wryi90-002F-PUT" {
  cache_key_parameters    = ["method.request.header.Authorization"]
  cache_namespace         = "wryi90"
  connection_type         = "INTERNET"
  content_handling        = "CONVERT_TO_TEXT"
  http_method             = "PUT"
  integration_http_method = "POST"
  passthrough_behavior    = "WHEN_NO_MATCH"
  resource_id             = "wryi90"
  rest_api_id             = "868ccyrv02"
  timeout_milliseconds    = "29000"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:addDevice/invocations"
}
