provider "aws" {
  region = var.region
}

resource "aws_iam_role" "fastify_api_lambda_role" {
  name = "fastify_api_lambda_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "fastify_api_lambda_managed_policy" {
  role       = aws_iam_role.fastify_api_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "fastify_lambda" {
  filename         = "${path.module}/../build/function.zip"
  function_name    = "fastifyAPIOnAWSLambda"
  role             = aws_iam_role.fastify_api_lambda_role.arn
  handler          = "src/lambda.handler"
  source_code_hash = filebase64sha256("${path.module}/../build/function.zip")
  runtime          = "nodejs20.x"
  environment {
    variables = {
      NODE_ENV = "production"
    }
  }
}

resource "aws_lambda_function_url" "fastify_lambda_url" {
  function_name = aws_lambda_function.fastify_lambda.function_name
  authorization_type = "NONE"
}