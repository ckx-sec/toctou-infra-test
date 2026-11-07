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

resource "google_storage_bucket_object" "legit" {
  name    = "im-pr-attack-test/legit-marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "LEGIT_COMMIT_A_CLEAN_CODE"
}

output "status" { value = "LEGIT_CODE_NO_RCE" }
