terraform {
  required_version = ">= 1.2.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

variable "project_id" {
  default = "ellison-hunt-1102-c86d"
}

resource "google_storage_bucket_object" "safe" {
  name    = "im-pr-attack-test/safe-v2.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "SAFE_COMMIT_A_DEFAULT_RACE_V2"
}

output "status" { value = "SAFE_COMMIT_A_V2" }
