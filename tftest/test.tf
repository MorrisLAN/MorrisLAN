terraform {
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = ">= 1.20.0"
    }
  }
}

provider "rancher2" {
  api_url   = "https://rancher.104.248.174.2.sslip.io"
  token_key = "7dfv94dprgwrntm7k5jxnff4hdzf2mhh88kpvk8jljm59dm6c4nvcd"
  insecure  = true
}

resource "rancher2_cluster_v2" "k3s_cluster" {
  name                = "k3s-cluster"
  kubernetes_version  = "v1.24.0+k3s1"

  rke_config {
    machine_pools {
      name                = "k3s-node-pool"  # Required name for the machine pool
      control_plane_role  = true
      etcd_role           = true
      worker_role         = true
      quantity            = 3
      machine_config {
        kind = "HarvesterMachineConfig"  # Specify the machine config kind
        name = rancher2_machine_config_v2.harvester_config.id
      }
    }
  }

  cloud_credential_secret_name = "<existing-harvester-cloud-credential-id>"
}

resource "rancher2_machine_config_v2" "harvester_config" {
  generate_name = "harvester-machine-config"
  
  harvester_config {
    cpu_count    = 2
    memory_size  = "4Gi"
    ssh_user     = "rancher"  # Required ssh_user argument
    vm_namespace = "default"  # Required vm_namespace argument

    disk_info = [{
      size       = "40Gi"           # Disk size specified directly as a string
      image_name = "ubuntu-20.04"    # Image name specified directly as a string
    }]

    network_info = [{
      name = "lan"  # Replace with the appropriate Harvester network name
    }]
  }
}
