terraform {
  backend "s3" {
    bucket         = "wordpressbucket-yassin"
    key            = "dev/terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
  }   
}