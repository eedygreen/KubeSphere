variable "namespace" {
    description =   "This variable carries the name of namespaces"
    type        =   string
    default     =   "demo-project"
}

variable "project" {
    description = "This is the name for the project"
    type        = string
    default     = "devops-backend"
}

variable "app_name" {
    description =  "The name of the application, i.e the pod name"
    type        =  string
    default     =  "kubeshpere-project"
}

variable "memory_size" {
    description = "This is the memory size for pods"
    type        = string
    default     = "128Mi"
}

variable "cpu_size" {
    description = "The size for cup usage"
    type        = string
    default     = "200m"
}

variable "volume_size" {
    description = "The volume size for images"
    type        = string
    default     = ""
}

variable "containers_image" {
    description  = "The name of the containers from dockerhub"
    type         = map(string)
    default      = {
       k6        = "loadimpact/k6",                    
       apisix    = "apache/apisix",                    
       ethereum  = "ethereum/client-go",               
       drools    = "jboss/drools-workbench-showcase",  
       dapr      = "daprio/daprd",                     
       keda      = "kedacore/keda",                    
       delta     = "", # delta                       
       spark3    = "" # spark 3.0
       salary    = "roadrunner11/salary-pred:firstpush"                     
    }

}

/*
variable "image_deploy" {
    description = "The number of image to deploy"
    type        = number
    default     = 
}
*/

variable "replicas" {
    description = "Number of replicas"
    type        = number
    default     = 1
}

variable "kubernetes_version" {
    description = "Current version of kubernetes in used"
    default     = "1.13.3"
}

variable "container_port" {
    description = "The port number used by the container"
    type        = number
    default     = 80
}