output "website_url" {
  value = aws_lb.marketing_web.dns_name

}
output "mathew-user-password" {
  value     = aws_iam_user_login_profile.user_login.password
  sensitive = true
}

//terraform output -raw mathew-user-password

//Vgo$sQY$xd{G&|$sMsp6