git_tag = "1.3.0"

logical_product_family = "demo"
logical_product_service = "springboot"
environment             = "sandbox"
environment_number      = "000"
resource_number         = "000"
region                  = "us-east-2"

force_new_deployment = true
redeploy_on_apply = true

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
  task_exec_policy = {
    name       = "taskexecpolicy"
    max_length = 60
  }
}

alb_sg = {
  description         = "Allow traffic from everywhere on 80 and 8080"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}

ecs_svc_security_group = {
  ingress_rules       = ["http-80-tcp", "http-8080-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}

containers = [
  {
    name      = "launch-api"
    image_tag = "538234414982.dkr.ecr.us-east-2.amazonaws.com/launch-api:0.0.1-dev"
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
    port_mappings = [{
      # port mappings should also change in target group and ecs security group
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
      },
      {
        # port mappings should also change in target group and ecs security group
        containerPort = 5005
        hostPort      = 5005
        protocol      = "tcp"
    }]
  }
]

target_groups = [
  {
    backend_protocol = "HTTP"
    backend_port     = 8080
    target_type      = "ip"
    health_check = {
      path                = "/actuator/health"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      matcher             = "200"
    }
  }
]

http_tcp_listeners = [
  {
    port        = 8080
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

vpc_id = "vpc-099fd3eb16bcdfafc"
private_subnets = [
  "subnet-0e13d45c866b2e7b2",
  "subnet-0c9280cbd4c3a01dd",
  "subnet-0369ba8e77a48792b",
]
ecs_cluster_arn = "arn:aws:ecs:us-east-2:020127659860:cluster/demo-ecs_ptfrm-useast2-sandbox-000-fargate-000"

runtime_platform = [{
  cpu_architecture        = "AMD64",
  operating_system_family = "LINUX"
}]

ecs_exec_role_custom_policy_json = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Resource": [
        "arn:aws:kms:us-east-2:538234414982:key/ba37724b-ea39-45a5-a938-713fb9f88112"
      ]
    },
    {
      "Action": [
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetRandomPassword",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:ListSecretVersionIds"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:example/actuator/password-*",
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:example/actuator/username-*",
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:example/postgres/password-*",
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:example/postgres/username-*"
      ]
    }
]}
EOF
