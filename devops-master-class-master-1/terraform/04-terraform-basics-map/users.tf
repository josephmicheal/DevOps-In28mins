variable "users" {
   default =    {
        Joseph =  { country:"Bangalore", department:"IDIT"}, 
        Kingston =  { country:"Nellai", department:"PETS"}, 
        Leo =  { country:"Chennai", department:"ECNet"}
     }
}


resource "aws_iam_user" "my_iam_users" {
  for_each = var.users
  name     = each.key
  tags = {
    country = each.value.country
    department = each.value.department
  }
}