resource "aws_iam_user" "db" {
  name = "${var.name}-db-user"
  tags = {
    Name = var.name
  }
}

resource "aws_iam_access_key" "db" {
  user = aws_iam_user.db.name
}


resource "aws_iam_role" "db" {
  name = "${var.name}-db-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "s3.amazonaws.com"
        }
      },
    ]
  })

  tags = { 
    name = "${var.name}-db-role"
  }
}
resource "aws_iam_role_policy_attachment" "db" {
  role       = aws_iam_role.db.id
  policy_arn = aws_iam_policy.db.arn
}

resource "aws_iam_policy" "db" {
  name   = "${var.name}db-s3-policy"
  policy = data.aws_iam_policy_document.db.json
}

// aws lambda service role


data "aws_iam_policy_document" "db" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:ListBucket",
      "s3:ListObjects",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = ["arn:aws:s3:::${var.name}-db-bucket/*",
    ]
  }
}
