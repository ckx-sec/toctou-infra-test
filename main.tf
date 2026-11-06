terraform {
  required_version = ">= 1.2.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

resource "google_storage_bucket_object" "marker" {
  name    = "toctou-im-git-proof.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "INFRA_MANAGER_GIT_LEGIT_V1"
}

output "marker_content" {
  value = "LEGIT_V1"
}
