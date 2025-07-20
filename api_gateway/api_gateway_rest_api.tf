resource "aws_api_gateway_rest_api" "tfer--868ccyrv02_HeartBeatAPI" {
  api_key_source               = "HEADER"
  disable_execute_api_endpoint = "false"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  minimum_compression_size = "-1"
  name                     = "HeartBeatAPI"
}
