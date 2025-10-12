resource "aws_iam_user" "mathew" {
  name = "mathew"
}

resource "aws_iam_user_login_profile" "user_login" {
  user = aws_iam_user.mathew.name
  //pgp_key = "keybase:username"
  password_reset_required = true
}



resource "aws_iam_group" "AdminRole" {
  name = "AdminRole"

}


resource "aws_iam_user_group_membership" "mathew" {
  user = aws_iam_user.mathew.name

  groups = [
    aws_iam_group.AdminRole.name
  ]
}

resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.AdminRole.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


