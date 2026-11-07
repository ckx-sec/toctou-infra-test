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

resource "google_storage_bucket_object" "legit_a" {
  name    = "im-pr-attack-test/default-race-legit.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "DEFAULT_CONFIG_RACE_COMMIT_A_LEGIT_NO_RCE"
}

output "status" { value = "COMMIT_A_LEGIT_NO_RCE" }
