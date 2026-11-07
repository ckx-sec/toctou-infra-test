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

resource "google_storage_bucket_object" "safe_module" {
  name    = "im-pr-attack-test/module-safe.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "MODULE_RACE_COMMIT_A_SAFE"
}

output "status" { value = "COMMIT_A_SAFE_MODULE_TEST" }
