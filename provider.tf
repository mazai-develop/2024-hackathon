provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      Env       = "hackathon-2024"
      ManagedBy = "terraform"
    }
  }
}
