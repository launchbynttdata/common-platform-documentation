logical_product_service = "springboot"
environment             = "sandbox"
environment_number      = "000"
resource_number         = "000"
logical_product_family  = "launch"
region                  = "us-east-2"

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
    image_tag = "538234414982.dkr.ecr.us-east-2.amazonaws.com/launch-api:s1"
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
    environment = {
      "spring.datasource.url"                                            = "jdbc:postgresql://aarti-private-postgres-db.cafhcpgcbext.us-east-2.rds.amazonaws.com:5432/postgres"
      "spring.datasource.username"                                       = "postgres"
      "spring.datasource.password"                                       = "postgres"
      "spring.datasource.driverClassName"                                = "org.postgresql.Driver"
      "spring.main.banner-mode"                                          = "off"
      "spring.session.jdbc.initialize-schema"                            = "always"
      "spring.sql.init.mode"                                             = "always"
      "spring.sql.init.platform"                                         = "postgres"
      "spring.sql.init.continue-on-error"                                = "true"
      "spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation" = "true"
      "spring.jpa.show-sql"                                              = "true"
      "spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation" = "true"
      "spring.jpa.generate-ddl"                                          = "true"
      "spring.jpa.properties.hibernate.format_sql"                       = "true"
      "spring.jpa.defer-datasource-initialization"                       = "true"
      "spring.jpa.properties.hibernate.use_sql_comments"                 = "true"
      "spring.jpa.hibernate.ddl-auto"                                    = "none"
      "spring.jpa.properties.hibernate.dialect"                          = "org.hibernate.dialect.PostgreSQLDialect"
      "actuator_username"                                                = "test"
      "actuator_password"                                                = "test"
      "logging.level.org.springframework"                                = "DEBUG"
    }

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

vpc_id = "vpc-02c510a9108940807"
private_subnets = [
  "subnet-0fe7bc519009725f8",
  "subnet-0b6f7d708521d653d",
  "subnet-01492caeb02671079",
]
ecs_cluster_arn = "arn:aws:ecs:us-east-2:020127659860:cluster/launch-springboot-useast2-sandbox-000-fargate-000"

runtime_platform = [{
  cpu_architecture        = "ARM64",
  operating_system_family = "LINUX"
}]

ecs_exec_role_custom_policy_json = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"ecr:GetAuthorizationToken\",\n        \"ecr:BatchCheckLayerAvailability\",\n        \"ecr:GetDownloadUrlForLayer\",\n        \"ecr:BatchGetImage\"\n      ],\n      \"Resource\": \"*\"\n    }\n  ]\n}"
