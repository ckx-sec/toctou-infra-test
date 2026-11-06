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
  content = "EVIL_REPLACED_TOCTOU_GIT_PROOF"
}

output "marker_content" {
  value = "EVIL_REPLACED"
}
