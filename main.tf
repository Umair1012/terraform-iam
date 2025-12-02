# Provider
provider "aws" {
  region = "us-east-1"
}

# IAM user
resource "aws_iam_user" "user" {
  name = "devops-user-miseacademy"
}
# IAM Group
resource "aws_iam_group" "group" {
  name = "DevOpsGroup_Miseacademy"
}

# Assign user to group
resource "aws_iam_user_group_membership" "membership" {
  user = aws_iam_user.user.name
  groups = [aws_iam_group.group.name]
}

# Attach Policies to Group
resource "aws_iam_group_policy_attachment" "group_policies" {
  for_each = {
    "AmazonEC2FullAccess" = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    "AmazonS3FullAccess" = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }
  group = aws_iam_group.group.name
  policy_arn = each.value
}

# Create IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "EC2Role_Miseacademy"
  assume_role_policy = jsonencode({
    Version= "2012-10-17",
    Statement= [{
            Effect= "Allow"
            Principal= {
                Service= "ec2.amazonaws.com"
            },
            Action= "sts:AssumeRole"
        }]
})
}

# Attach Policies to IAM role
resource "aws_iam_role_policy_attachment" "ec2_role_polic" {
  for_each = {
    "AmazonEC2FullAccess" = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    "AmazonS3FullAccess" = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }
  role = aws_iam_role.ec2_role.name
  policy_arn = each.value
}

# Create Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile_Miseacademy"
  role = aws_iam_role.ec2_role.name
}