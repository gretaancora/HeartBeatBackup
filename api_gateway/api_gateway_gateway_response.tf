resource "aws_api_gateway_gateway_response" "tfer--868ccyrv02-002F-DEFAULT_4XX" {
  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "gatewayresponse.header.Access-Control-Allow-Methods" = "'OPTIONS,PUT'"
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }

  response_type = "DEFAULT_4XX"
  rest_api_id   = "868ccyrv02"
}

resource "aws_api_gateway_gateway_response" "tfer--868ccyrv02-002F-DEFAULT_5XX" {
  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "gatewayresponse.header.Access-Control-Allow-Methods" = "'OPTIONS,PUT'"
    "gatewayresponse.header.Access-Control-Allow-Origin"  = "'*'"
  }

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }

  response_type = "DEFAULT_5XX"
  rest_api_id   = "868ccyrv02"
}
