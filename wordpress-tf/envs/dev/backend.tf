terraform {
  backend "s3" {
    bucket         = "wordpressbucket-yassin"
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks" # optional but recommended
    encrypt        = true
  }   
}