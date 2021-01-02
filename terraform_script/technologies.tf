resource "kubernetes_deployment" "DevOps" {
    metadata {
        name        = var.project
        namespace   = var.namespace
        labels      = {
            App     = var.app_name
        }
    }


    spec {
        replicas = var.replicas
        selector {
            match_labels = {
                App = var.app_name
        }
        }
        template {
            metadata {
                labels = {
                    App = var.app_name
        }
        } 
        spec {
            container {
                image = var.containers_image["salary"]
                name  = var.app_name

                port {
                    container_port = var.container_port
                }

                resources {
                    limits {
                        cpu    = var.cpu_size
                        memory = var.memory_size
                    }
                    requests {
                        cpu    = var.cpu_size
                        memory = var.memory_size
                    }
                }
            }
        }
        }
    }   
}