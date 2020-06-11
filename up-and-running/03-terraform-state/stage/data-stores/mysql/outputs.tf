output "address" {
    value           = aws_db_instance.example03.address
    description     = "DB Connection endpoint"
}

output "port" {
    value           = aws_db_instance.example03.port
    description     = "DB Port"
}