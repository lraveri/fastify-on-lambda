output "lambda_function_url" {
  description = "Lambda function URL"
  value       = aws_lambda_function_url.fastify_lambda_url.function_url
}