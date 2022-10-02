resource "aws_ecr_repository" "db" {
    name = "${var.name}-db"
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
}