
terraform {
  required_version = "~> 1.1"
  backend "s3" {
    bucket  = "hackathon-2024-terraform-state" # 作成したS3バケット
    region  = "ap-northeast-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
}
