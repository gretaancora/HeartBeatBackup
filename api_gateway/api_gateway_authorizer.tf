resource "aws_api_gateway_authorizer" "tfer--6h6mfj" {
  authorizer_result_ttl_in_seconds = "3600"
  authorizer_uri                   = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:checkAdminGroupAuth/invocations"
  identity_source                  = "method.request.header.Authorization"
  name                             = "AdminAuth"
  rest_api_id                      = "868ccyrv02"
  type                             = "TOKEN"
}

resource "aws_api_gateway_authorizer" "tfer--f6femo" {
  authorizer_result_ttl_in_seconds = "3600"
  authorizer_uri                   = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:checkPatientGroupAuth/invocations"
  identity_source                  = "method.request.header.Authorization"
  name                             = "PatientAuth"
  rest_api_id                      = "868ccyrv02"
  type                             = "TOKEN"
}

resource "aws_api_gateway_authorizer" "tfer--w9sbec" {
  authorizer_result_ttl_in_seconds = "3600"
  authorizer_uri                   = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:832059618623:function:checkDoctorGroupAuth/invocations"
  identity_source                  = "method.request.header.Authorization"
  name                             = "DoctorAuth"
  rest_api_id                      = "868ccyrv02"
  type                             = "TOKEN"
}
