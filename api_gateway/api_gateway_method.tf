resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-1zcy6b-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "1zcy6b"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-1zcy6b-002F-POST" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "6h6mfj"
  http_method      = "POST"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "1zcy6b"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-3k7fm5-002F-GET" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "w9sbec"
  http_method      = "GET"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "3k7fm5"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-3k7fm5-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "3k7fm5"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-3wj1ic-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "3wj1ic"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-3wj1ic-002F-POST" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "POST"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "3wj1ic"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-b7759p-002F-GET" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "w9sbec"
  http_method      = "GET"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "b7759p"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-b7759p-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "b7759p"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-km15j3-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "km15j3"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-km15j3-002F-PUT" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "w9sbec"
  http_method      = "PUT"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "km15j3"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-nka6k7-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "nka6k7"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-nka6k7-002F-POST" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "w9sbec"
  http_method      = "POST"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "nka6k7"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-q7jwcr-002F-GET" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "f6femo"
  http_method      = "GET"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "q7jwcr"
  rest_api_id = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-q7jwcr-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "q7jwcr"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-wryi90-002F-OPTIONS" {
  api_key_required = "false"
  authorization    = "NONE"
  http_method      = "OPTIONS"
  resource_id      = "wryi90"
  rest_api_id      = "868ccyrv02"
}

resource "aws_api_gateway_method" "tfer--868ccyrv02-002F-wryi90-002F-PUT" {
  api_key_required = "false"
  authorization    = "CUSTOM"
  authorizer_id    = "f6femo"
  http_method      = "PUT"

  request_parameters = {
    "method.request.header.Authorization" = "true"
  }

  resource_id = "wryi90"
  rest_api_id = "868ccyrv02"
}
