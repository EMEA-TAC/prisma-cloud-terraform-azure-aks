provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = var.resource-rg
  location = var.region

  tags = {
    environment = "EMEA-TAC-LAB"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.cluster_name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.k8s_version

  default_node_pool {
    name            = "default"
    node_count      = var.num_node
    vm_size         = var.machine_type
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "EMEA-TAC-LAB"
  }
}

resource "local_file" "kubeconfig" {
  depends_on = [ azurerm_kubernetes_cluster.default ]
  content = azurerm_kubernetes_cluster.default.kube_config_raw
  filename = "kubeconfig"
}

resource "null_resource" "defender_deploy" {
    depends_on = [ local_file.kubeconfig ]

    provisioner "local-exec" {
      command = "python generate_daemonset.py -u ${var.user} -p ${var.password_pcc} -c ${var.console} -o ${var.orchestrator} -r ${var.runtime} -t ${var.console_type}"
    }
     provisioner "local-exec" {
      command = "kubectl --kubeconfig ./kubeconfig create ns twistlock --insecure-skip-tls-verify"
    } 
    provisioner "local-exec" {
      command = "kubectl --kubeconfig ./kubeconfig apply -f daemonset.yaml --insecure-skip-tls-verify"
    }  
}
