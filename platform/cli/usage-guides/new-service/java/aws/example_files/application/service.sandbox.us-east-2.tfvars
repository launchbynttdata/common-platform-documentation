
logical_product_service = "springbootex"
environment             = "sandbox"
environment_number      = "000"
resource_number         = "000"
logical_product_family  = "launch"
region                  = "us-east-2"

# Ensure you have a profile by this name in your ~/.aws/config file
aws_profile = "launch-sandbox-admin"

resource_names_map = {
  # Platform
  ecs_cluster = {
    name = "fargate"
  }
  vpce_sg = {
    name = "vpce-sg"
  }
  vpce_sg = {
    name = "vpc"
  }
  namespace = {
    name = "ns"
  }
  # Application
  alb = {
    name       = "alb"
    max_length = 31
  }
  alb_tg = {
    name       = "albtg"
    max_length = 31
  }
  ecs_task = {
    name       = "td"
    max_length = 60
  }
  ecs_service = {
    name       = "svc"
    max_length = 60
  }
  ecs_sg = {
    name       = "ecssg"
    max_length = 60
  }
  alb_sg = {
    name       = "albsg"
    max_length = 60
  }
  vpc = {
    name       = "vpc"
    max_length = 60
  }
  alb_http_listener = {
    name       = "http"
    max_length = 60
  }
  alb_https_listener = {
    name       = "https"
    max_length = 60
  }
  s3_logs = {
    name       = "logs"
    max_length = 31
  }
}

alb_sg = {
  description         = "Allow traffic from everywhere on 80"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}

ecs_svc_security_group = {
  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

containers = [
  {
    name      = "ecs-app"
    image_tag = "0.0.1"
    essential = true
    log_configuration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/fargate/task/demo-app-server"
        awslogs-region        = "us-east-2"
        awslogs-create-group  = "true"
        awslogs-stream-prefix = "demoapp"
      }
    }
    environment = {
      FLASK_RUN_PORT = "8081"
    }
    port_mappings = [{
      # port mappings should also change in target group and ecs security group
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]
  }
]

target_groups = [
  {
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "ip"
  }
]

http_tcp_listeners = [
  {
    port        = 80
    protocol    = "HTTP"
    action_type = "forward"
    redirect    = {}
  }
]

https_listeners = []

enable_service_discovery = false

tags = {
  Purpose = "terratest examples"
  Env     = "sandbox"
  Team    = "dso"
}

vpc_id          = "vpc-0b15fce443b3ac6e3"
private_subnets = ["subnet-09105353b31045a33", "subnet-0fc0f8eefa05ffbcc", "subnet-06d18377479309a4b"]
ecs_cluster_arn = "arn:aws:ecs:us-east-2:020127659860:cluster/launch-ecs-useast2-sandbox-000-fargate-000"