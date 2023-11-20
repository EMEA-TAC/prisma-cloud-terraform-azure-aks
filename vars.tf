variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "resource-rg" {
  description = "Resource Group name"
}

variable "num_node" {
  description = "Number of nodes"
}

variable "machine_type" {
  description = "Machine type"
}

variable "k8s_version" {
  description = "k8s version"

}

variable "admin_username" {
  default = "demo"
}

variable "cluster_name" {
 description = "Cluster name"
}

variable "dns_prefix" {
  description = "DNS prefix"
}

variable "region" {
  description = "Azure region"
}

variable "user" {
  description = "Prisma Cloud username"
}

variable "password_pcc" {
  description = "Prisma Cloud Password"
}

variable "console" {
  description = "Prisma Cloud console address"
}

variable "orchestrator" {
  description = "Orchestrator type kubernertes, openshift, ecs"
}

variable "console_type" {
  description = "Console deployment type SAAS or selfhosted"
}


variable "runtime" {
  description = "Container runtime docker,crio,containerd"
}
