module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.19.1"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  # Cấu hình mạng
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  # Public access tới API server để bạn có thể chạy kubectl từ máy cá nhân
  cluster_endpoint_public_access = true

  # Ở version 19, người chạy Terraform (IAM Role/User) mặc định sẽ 
  # tự động có quyền admin (system:masters) ngầm định từ AWS.
  # Nếu bạn muốn cấp quyền cho người khác, bạn sẽ cần bật manage_aws_auth_configmap (tùy chọn)
  # manage_aws_auth_configmap = true

  # Cấu hình Managed Node Group
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name           = "node-group-1"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
    two = {
      name           = "node-group-2"
      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
