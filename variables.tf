variable "aws_region" {
  description = "AWS Region for implement EKS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of EKS Cluster"
  type        = string
  default     = "vprofile-cluster"
}
