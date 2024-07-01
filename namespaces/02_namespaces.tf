# Create Tanzu Mission Control workspace
resource "tanzu-mission-control_workspace" "create_workspace" {
  name = "ipablo-ws"

  meta {
    description = "Create workspace through terraform"
    labels = {
      "key1" : "value1",
      "key2" : "value2"
    }
  }
}

# Create Tanzu Mission Control namespace with attached set as 'true'
resource "tanzu-mission-control_namespace" "create_attached_namespace" {
  name                    = "ipablo-ns" # Required
  cluster_name            = var.cluster_name  # Required
  provisioner_name        = var.provisioner     # Default: attached
  management_cluster_name = var.management_cluster     # Default: attached

  meta {
    description = "Create namespace through terraform"
    labels      = { "foo" : "var" }
  }

  spec {
    workspace_name = "ipablo-ws" # Default: default
    attach         = true
  }
}