output "lambda_function_url" {
  description = "L'URL di invocazione della funzione Lambda"
  value       = aws_lambda_function_url.fastify_lambda_url.function_url
}