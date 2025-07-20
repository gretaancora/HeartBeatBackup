resource "aws_api_gateway_stage" "tfer--868ccyrv02-002F-dev" {
  cache_cluster_enabled = "false"
  cache_cluster_size    = "0.5"
  deployment_id         = "hdp2cy"
  rest_api_id           = "868ccyrv02"
  stage_name            = "dev"
  xray_tracing_enabled  = "false"
}
