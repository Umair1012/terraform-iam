variable "iam_user" {
  type = string
  default = "devops-user-miseacademy"
}
variable "iam_group" {
  type = string
  default = "DevOpsGroup_Miseacademy"
}

variable "iam_policies" {
  type = list(string)
  default = [
     "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
     "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}