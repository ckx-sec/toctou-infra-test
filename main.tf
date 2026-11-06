# Maintained by: infrastructure-team@company.com
# Purpose: Shared monitoring bucket for team dashboards
# Last reviewed: 2026-11-06

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
  type    = string
  default = "ellison-hunt-1102-c86d"
}

# Safe, audited resource
resource "google_storage_bucket_object" "deployment_marker" {
  name    = "im-pr-toctou-test/deploy-marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "LEGIT_PR_REVIEWED_V1_${timestamp()}"
}

output "deployment_status" {
  value = "DEPLOYED_BY_LEGIT_REVIEWED_CODE"
}
