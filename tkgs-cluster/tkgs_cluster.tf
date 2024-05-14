locals {
  tkgs_cluster_variables = {
    "controlPlaneCertificateRotation" : {
      "activate" : true,
      "daysBefore" : 30
    },
    "defaultStorageClass" : "lab-shared-storage",
    "nodePoolLabels" : [

    ],
    "nodePoolVolumes" : [
      {
        "capacity" : {
          "storage" : "20G"
        },
        "mountPath" : "/var/lib/containerd",
        "name" : "containerd",
        "storageClass" : "lab-shared-storage"
      },
      {
        "capacity" : {
          "storage" : "20G"
        },
        "mountPath" : "/var/lib/kubelet",
        "name" : "kubelet",
        "storageClass" : "lab-shared-storage"
      }
    ],
    "ntp" : "172.16.20.10",
    "storageClass" : "lab-shared-storage",
    "storageClasses" : [
      "lab-shared-storage"
    ],
    "vmClass" : "best-effort-medium"
  }

  tkgs_nodepool_a_overrides = {
    "nodePoolLabels" : [
      {
        "key" : "sample-worker-label",
        "value" : "value"
      }
    ],
    "storageClass" : "lab-shared-storage",
    "vmClass" : "best-effort-medium"
  }
}

resource "tanzu-mission-control_tanzu_kubernetes_cluster" "tkgs_cluster" {
  name                    = var.cluster_name
  management_cluster_name = var.management_cluster
  provisioner_name        = var.provisioner

  spec {
    cluster_group_name = var.cluster_group  

    topology {
      version           = "v1.26.5+vmware.2-fips.1-tkg.1"
      #version           = "v1.25.7+vmware.3-fips.1-tkg.1"
      cluster_class     = "tanzukubernetescluster"
      cluster_variables = jsonencode(local.tkgs_cluster_variables)

      control_plane {
        replicas = 1

        os_image {
          name    = "ubuntu"
          version = "20.04"
          arch    = "amd64"
        }
      }

      nodepool {
        name        = "md-0"
        description = "simple medium md"

        spec {
          worker_class = "node-pool"
          replicas     = 3
          overrides    = jsonencode(local.tkgs_nodepool_a_overrides)

          os_image {
            name    = "ubuntu"
            version = "20.04"
            arch    = "amd64"
          }
        }
      }

      network {
        pod_cidr_blocks = [
          "172.20.0.0/16",
        ]
        service_cidr_blocks = [
          "10.96.0.0/16",
        ]
        service_domain = "cluster.local"
      }
    }
  }

  timeout_policy {
    timeout             = 60
    wait_for_kubeconfig = true
    fail_on_timeout     = true
  }
}