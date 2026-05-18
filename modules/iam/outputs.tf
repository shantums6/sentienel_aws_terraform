output "instance_profile_name" {
  description = "The name of the instance profile to attach to an EC2 instance"
  value       = aws_iam_instance_profile.this.name
}
