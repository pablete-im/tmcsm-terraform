variable "endpoint" {
    description = "The endpoint URL of your Tanzu Mission Control Self-Managed deployment."
    type = string
}

variable "oidc_issuer" {
    description = "OIDC Issuer URL."
    type = string
}

variable "username" {
    description = "User enrolled in the IDP associated to Tanzu Mission Control Self-Managed."
    type = string
}

variable "password" {
    description = "Password for user enrolled in the IDP associated to Tanzu Mission Control Self-Managed."
    type = string
}

variable "ca_file" {
    description = "Path to Host's root ca set. The certificates issued by the issuer should be trusted by the host accessing TMC Self-Managed via TMC terraform provider."
    type = string
}

variable "cluster_group" {
    description = "Name of the cluster group to attach the cluster to."
    type = string
    default = "default"
}

variable "management_cluster" {
    description = "Name of the SPV Cluster that will create this workload cluster."
    type = string
}

variable "provisioner" {
    description = "Name of the provisioner namespace in vSpehre that will host this cluster."
    type = string
}

variable "cluster_name" {
    description = "Name of the cluster to be created."
    type = string
}