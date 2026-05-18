resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# The count loop allows you to pass a list of policies and attach all of them!
resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.managed_policy_arns[count.index]
}

resource "aws_iam_instance_profile" "this" {
  name = var.profile_name
  role = aws_iam_role.this.name
}
