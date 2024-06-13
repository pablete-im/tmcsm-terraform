# Create Tanzu Mission Control source secret with attached set as default value.
resource "tanzu-mission-control_repository_credential" "git_credential" {
  name = "git-credential" # Required

  scope {
    cluster {
      name                    = var.cluster_name # Required
      provisioner_name        = var.provisioner    # Default: attached
      management_cluster_name = var.management_cluster    # Default: attached
    }
  }

  meta {
    description = "Create Git Repository Credential through terraform"
    labels      = { "key" : "value" }
  }

  spec {
    data {
      username_password {
        username = var.git_repo_username
        password = var.git_repo_password
      }
    }
  }
}