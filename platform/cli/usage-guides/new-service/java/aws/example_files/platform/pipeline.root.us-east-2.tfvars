git_tag = "1.0.2"
logical_product_family = "launch"
logical_product_service = "ecs_ptfrm"
environment = "root"
environment_number = "000"
resource_number = "000"
build_image = "ghcr.io/launchbynttdata/launch-build-agent-aws:latest"
build_image_pull_credentials_type = "SERVICE_ROLE"
additional_codebuild_projects = [{
    name = "trigger_pipeline"
    buildspec = "buildspec.yml"
    description = "Trigger the pipeline based on the event type."
    source_type = "NO_SOURCE"
    artifact_type = "NO_ARTIFACTS"
    build_image = "ghcr.io/launchbynttdata/launch-build-agent-aws:latest"
    build_image_pull_credentials_type = "SERVICE_ROLE"
    environment_variables = [{
        name = "LAUNCH_ACTION"
        value = "trigger-pipeline"
        type = "PLAINTEXT"
      }, {
        name = "IGNORE_INTERNALS"
        value = "false"
        type = "PLAINTEXT"
      }, {
        name = "USERVAR_S3_CODEPIPELINE_BUCKET"
        value = "demo-ecs-ptfrm-pr-event-useast2-root-000-s3-000"
        type = "PLAINTEXT"
      }, {
        name = "INTERNALS_CODEPIPELINE_BUCKET"
        value = "demo-ecs-ptfrm-internals-useast2-root-000-s3-000"
        type = "PLAINTEXT"
      }, {
        name = "APPLICATION_ID_PARAMETER_NAME"
        value = "/github/app/aws-codepipeline-authentication/application_id"
        type = "PLAINTEXT"
      }, {
        name = "INSTALLATION_ID_PARAMETER_NAME"
        value = "/github/app/aws-codepipeline-authentication/installation_id"
        type = "PLAINTEXT"
      }, {
        name = "SIGNING_CERT_SECRET_NAME"
        value = "/github/app/aws-codepipeline-authentication/private_key_secret_id"
        type = "PLAINTEXT"
      }, {
        name = "TARGETENV"
        value = "root"
        type = "PLAINTEXT"
      }, {
        name = "ROLE_TO_ASSUME"
        value = "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
        type = "PLAINTEXT"
      }]
    codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObjectAcl",
        "s3:GetObject",
        "s3:ListBucketMultipartUploads",
        "s3:ListBucketVersions",
        "s3:ListBucket",
        "s3:DeleteObject",
        "s3:PutObjectAcl",
        "s3:ListMultipartUploadParts"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::demo-ecs-ptfrm-pr-event-useast2-root-000-s3-000",
        "arn:aws:s3:::demo-ecs-ptfrm-pr-event-useast2-root-000-s3-000/*",
        "arn:aws:s3:::demo-ecs-ptfrm-pr-merge-useast2-root-000-s3-000",
        "arn:aws:s3:::demo-ecs-ptfrm-pr-merge-useast2-root-000-s3-000/*",
        "arn:aws:s3:::demo-ecs-ptfrm-internals-useast2-root-000-s3-000",
        "arn:aws:s3:::demo-ecs-ptfrm-internals-useast2-root-000-s3-000/*"
      ]
    },
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    },
    {
        "Action": ["sts:AssumeRole"],
        "Effect": "Allow",
        "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
}]
pipelines = [
  {
    name = "internals"
    pipeline_type = "V2"
    create_s3_source = true
    source_stage = {
      stage_name = "Source"
      name = "Source"
      category = "Source"
      provider = "S3"
      configuration = {
        S3ObjectKey = "trigger_pipeline.zip"
        PollForSourceChanges = "false"
      }
      output_artifacts = ["SourceArtifact"]
    }
    stages = [{
        stage_name = "TG-Plan-Git-Webhooks"
        name = "TG-Plan-Git-Webhooks"
        description = "Terragrunt plan git webhooks"
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_hooks"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource webhook --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "TG-Plan-Pipelines"
        name = "TG-Plan-Pipelines"
        description = "Terraform plan pipelines"
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_pipln"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource pipeline --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "Deploy-Git-Webhooks"
        name = "Deploy-Git-Webhooks"
        description = "Deploy git webhooks"
        category = "Build"
        provider = "CodeBuild"
        project_name = "deploy_hooks"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource webhook --apply --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "Deploy-Pipelines"
        name = "Deploy-Pipelines"
        description = "Deploy pipelines"
        category = "Build"
        provider = "CodeBuild"
        project_name = "deploy_pipln"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource pipeline --apply --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }]
  }, {
    name = "pr_event"
    pipeline_type = "V2"
    execution_mode = "SUPERSEDED"
    create_s3_source = true
    source_stage = {
      stage_name = "Source"
      name = "Source"
      category = "Source"
      provider = "S3"
      configuration = {
        S3ObjectKey = "trigger_pipeline.zip"
        PollForSourceChanges = "false"
      }
      output_artifacts = ["SourceArtifact"]
    }
    stages = [{
        stage_name = "Launch-Predict-SemVer"
        name = "Launch-Predict-SemVer"
        description = "Predict semantic version for the next git tag based on the changes in the PR."
        category = "Build"
        provider = "CodeBuild"
        project_name = "semver_predict"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
      "name": "LAUNCH_ACTION",
      "value": "launch-predict-semver",
      "type": "PLAINTEXT"
  },
  {
    "name": "ROLE_TO_ASSUME",
    "value": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type": "PLAINTEXT"
  },
  {
    "name":"APPLICATION_ID_PARAMETER_NAME",
    "value":"/github/app/aws-codepipeline-authentication/application_id",
    "type":"PLAINTEXT"
  },
  {
    "name":"INSTALLATION_ID_PARAMETER_NAME",
    "value":"/github/app/aws-codepipeline-authentication/installation_id",
    "type":"PLAINTEXT"
  },
  {
    "name":"SIGNING_CERT_SECRET_NAME",
    "value":"/github/app/aws-codepipeline-authentication/private_key_secret_id",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    }
  ]
}
EOF
      }, {
        stage_name = "Simulated-Merge"
        name = "Sim-Merge"
        description = "Simulate the merge of the PR branch into the target branch."
        category = "Build"
        provider = "CodeBuild"
        project_name = "sim_merge"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"simulated-merge",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "TG-Plan-Service"
        name = "TG-Plan-Service"
        description = "Terragrunt plan the configuration changes for the infrastructure.(Not pipelines or git webhooks)"
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_svc"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource service --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"sandbox",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "Pre-Deploy-Tests"
        name = "Pre-Deploy-Tests"
        description = "Run regula/conftests/OPA tests for the configuration changes."
        category = "Build"
        provider = "CodeBuild"
        project_name = "pre_deploy_svc"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
     {
         "name": "LAUNCH_ACTION",
         "value": "pre-deploy-test",
         "type": "PLAINTEXT"
     },
     {
         "name": "IS_PIPELINE",
         "value": "true",
         "type": "PLAINTEXT"
     },
     {
         "name": "TARGETENV",
         "value": "sandbox",
         "type": "PLAINTEXT"
     },
     {
         "name": "ROLE_TO_ASSUME",
         "value": "arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000",
         "type": "PLAINTEXT"
     },
     {
       "name":"APPLICATION_ID_PARAMETER_NAME",
       "value":"/github/app/aws-codepipeline-authentication/application_id",
       "type":"PLAINTEXT"
     },
     {
       "name":"INSTALLATION_ID_PARAMETER_NAME",
       "value":"/github/app/aws-codepipeline-authentication/installation_id",
       "type":"PLAINTEXT"
     },
     {
       "name":"SIGNING_CERT_SECRET_NAME",
       "value":"/github/app/aws-codepipeline-authentication/private_key_secret_id",
       "type":"PLAINTEXT"
     }
 ]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    },
  ]
}
EOF
      }, {
        stage_name = "TG-Plan-Git-Webhooks"
        name = "TG-Plan-Git-Webhooks"
        description = "Terragrunt plan git webhooks. This stage will run in pr_event pipeline but would run terragrunt plan just when changes are made in `internals` folder."
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_hooks"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource service --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "TG-Plan-Pipelines"
        name = "TG-Plan-Pipelines"
        description = "Terragrunt plan pipelines. This stage will run in pr_event pipeline but would run terragrunt plan just when changes are made in `internals` folder."
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_pipeln"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource pipeline --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"sandbox",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }]
  }, {
    name = "pr_merge"
    pipeline_type = "V2"
    execution_mode = "SUPERSEDED"
    create_s3_source = true
    source_stage = {
      stage_name = "Source"
      name = "Source"
      category = "Source"
      provider = "S3"
      configuration = {
        S3ObjectKey = "trigger_pipeline.zip"
        PollForSourceChanges = "false"
      }
      output_artifacts = ["SourceArtifact"]
    }
    stages = [{
        stage_name = "TG-Plan-Service"
        name = "TG-Plan-Service"
        description = "Terragrunt plan the configuration changes for the infrastructure.(Not pipelines or git webhooks)"
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_svc"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource service --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"sandbox",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000",
    "type":"PLAINTEXT"
  }
]

EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "Pre-Deploy-Tests-Service"
        name = "Pre-Deploy-Tests-Service"
        description = "Run regula/conftests/OPA tests for the configuration changes."
        category = "Build"
        provider = "CodeBuild"
        project_name = "pre_deploy_svc"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
    {
        "name": "LAUNCH_ACTION",
        "value": "pre-deploy-test",
        "type": "PLAINTEXT"
    },
    {
        "name": "IS_PIPELINE",
        "value": "true",
        "type": "PLAINTEXT"
    },
    {
        "name": "TARGETENV",
        "value": "sandbox",
        "type": "PLAINTEXT"
    },
    {
        "name": "ROLE_TO_ASSUME",
        "value": "arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000",
        "type": "PLAINTEXT"
    },
    {
      "name":"APPLICATION_ID_PARAMETER_NAME",
      "value":"/github/app/aws-codepipeline-authentication/application_id",
      "type":"PLAINTEXT"
    },
    {
      "name":"INSTALLATION_ID_PARAMETER_NAME",
      "value":"/github/app/aws-codepipeline-authentication/installation_id",
      "type":"PLAINTEXT"
    },
    {
      "name":"SIGNING_CERT_SECRET_NAME",
      "value":"/github/app/aws-codepipeline-authentication/private_key_secret_id",
      "type":"PLAINTEXT"
    }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    }
  ]
}
EOF
      }, {
        stage_name = "TG-Plan-Git-Webhooks"
        name = "TG-Plan-Git-Webhooks"
        description = "Terragrunt plan git webhooks. This stage will run in pr_event pipeline but would run terragrunt plan just when changes are made in `internals` folder."
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_hooks"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource webhooks --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "TG-Plan-Pipelines"
        name = "TG-Plan-Pipelines"
        description = "Terragrunt plan pipelines. This stage will run in pr_event pipeline but would run terragrunt plan just when changes are made in `internals` folder."
        category = "Build"
        provider = "CodeBuild"
        project_name = "plan_pipeln"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource pipeline --plan --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"root",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "Trigger-Env"
        name = "Trigger-Env"
        description = "Trigger the environment pipeline. USERVAR_S3_CODEPIPELINE_BUCKET variables specifies the value of the S3 bucket in which trigger script is stored. Based on the value of this variable,it is determined which environment pipeline to trigger."
        category = "Build"
        provider = "CodeBuild"
        project_name = "trigger_env"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name": "LAUNCH_ACTION",
    "value": "trigger-pipeline",
    "type": "PLAINTEXT"
  },
  {
    "name": "USERVAR_S3_CODEPIPELINE_BUCKET",
    "value": "demo-ecs-ptfrm-sandbox-useast2-root-000-s3-000",
    "type": "PLAINTEXT"
  },
  {
    "name": "INTERNALS_CODEPIPELINE_BUCKET",
    "value": "demo-ecs-ptfrm-internals-useast2-root-000-s3-000",
    "type": "PLAINTEXT"
  },
  {
    "name": "IS_PIPELINE_LAST_STAGE",
    "value": "true",
    "type": "PLAINTEXT"
  },
  {
    "name":"APPLICATION_ID_PARAMETER_NAME",
    "value":"/github/app/aws-codepipeline-authentication/application_id",
    "type":"PLAINTEXT"
  },
  {
    "name":"INSTALLATION_ID_PARAMETER_NAME",
    "value":"/github/app/aws-codepipeline-authentication/installation_id",
    "type":"PLAINTEXT"
  },
  {
    "name":"SIGNING_CERT_SECRET_NAME",
    "value":"/github/app/aws-codepipeline-authentication/private_key_secret_id",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject",
        "s3:GetObjectAcl",
        "s3:GetObject",
        "s3:ListBucketMultipartUploads",
        "s3:ListBucketVersions",
        "s3:ListBucket",
        "s3:DeleteObject",
        "s3:PutObjectAcl",
        "s3:ListMultipartUploadParts"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::demo-ecs-ptfrm-sandbox-useast2-root-000-s3-000",
        "arn:aws:s3:::demo-ecs-ptfrm-sandbox-useast2-root-000-s3-000/*",
        "arn:aws:s3:::demo-ecs-ptfrm-internals-useast2-root-000-s3-000",
        "arn:aws:s3:::demo-ecs-ptfrm-internals-useast2-root-000-s3-000/*"
      ]
    },
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    }
  ]
}
EOF
      }, {
        stage_name = "Launch-Apply-SemVer"
        name = "Launch-Apply-SemVer"
        description = "Create a git tag with semantic version predicted in previous stage and push the tag to the repository."
        category = "Build"
        provider = "CodeBuild"
        project_name = "semver_apply"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
    {
        "name": "LAUNCH_ACTION",
        "value": "launch-apply-semver",
        "type": "PLAINTEXT"
    },
    {
        "name": "ROLE_TO_ASSUME",
        "value": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000",
        "type": "PLAINTEXT"
    },
    {
      "name":"APPLICATION_ID_PARAMETER_NAME",
      "value":"/github/app/aws-codepipeline-authentication/application_id",
      "type":"PLAINTEXT"
    },
    {
      "name":"INSTALLATION_ID_PARAMETER_NAME",
      "value":"/github/app/aws-codepipeline-authentication/installation_id",
      "type":"PLAINTEXT"
    },
    {
      "name":"SIGNING_CERT_SECRET_NAME",
      "value":"/github/app/aws-codepipeline-authentication/private_key_secret_id",
      "type":"PLAINTEXT"
    }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    }
  ]
}
EOF
      }]
  }, {
    name = "sandbox"
    pipeline_type = "V2"
    execution_mode = "QUEUED"
    create_s3_source = true
    source_stage = {
      stage_name = "Source"
      name = "Source"
      category = "Source"
      provider = "S3"
      configuration = {
        S3ObjectKey = "trigger_pipeline.zip"
        PollForSourceChanges = "false"
      }
      output_artifacts = ["SourceArtifact"]
    }
    stages = [{
        stage_name = "Deployment"
        name = "Deployment"
        description = "Deploy the infrastructure changes using terragrunt to given environment specified in TARGETENV variable."
        category = "Build"
        provider = "CodeBuild"
        project_name = "tg_deploy"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name":"LAUNCH_ACTION",
    "value":"launch terragrunt --target-environment $TARGETENV --platform-resource service --apply --generation",
    "type":"PLAINTEXT"
  },
  {
    "name":"TARGETENV",
    "value":"sandbox",
    "type":"PLAINTEXT"
  },
  {
    "name":"AWS_DEPLOYMENT_ROLE",
    "value":"arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::538234414982:role/dso-demo_tg_iam-useast2-root-000-role-000"
    }
  ]
}
EOF
      }, {
        stage_name = "Post-Functional-tests"
        name = "Post-Functional-tests"
        category = "Build"
        provider = "CodeBuild"
        project_name = "post_fn_tests"
        buildspec = "buildspec.yml"
        configuration = {
          EnvironmentVariables = <<EOF
[
  {
    "name": "LAUNCH_ACTION",
    "value": "tf-post-deploy-functional-test",
    "type": "PLAINTEXT"
  },
  {
    "name": "TARGETENV",
    "value": "sandbox",
    "type": "PLAINTEXT"
  },
  {
    "name": "ROLE_TO_ASSUME",
    "value": "arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000",
    "type": "PLAINTEXT"
  },
  {
    "name":"APPLICATION_ID_PARAMETER_NAME",
    "value":"/github/app/aws-codepipeline-authentication/application_id",
    "type":"PLAINTEXT"
  },
  {
    "name":"INSTALLATION_ID_PARAMETER_NAME",
    "value":"/github/app/aws-codepipeline-authentication/installation_id",
    "type":"PLAINTEXT"
  },
  {
    "name":"SIGNING_CERT_SECRET_NAME",
    "value":"/github/app/aws-codepipeline-authentication/private_key_secret_id",
    "type":"PLAINTEXT"
  }
]
EOF
        }
        input_artifacts = ["SourceArtifact"]
        codebuild_iam = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "kms:Decrypt",
        "kms:DescribeKey"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::020127659860:role/dso-demo_tg_iam-useast2-sandbox-000-role-000"
    },
    {
      "Action": ["secretsmanager:GetSecretValue"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:secretsmanager:us-east-2:538234414982:secret:github/app/aws-codepipeline-authentication/private_key-??????"
      ]
    },
    {
      "Action": ["ssm:GetParametersByPath", "ssm:GetParameter"],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/application_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/installation_id",
        "arn:aws:ssm:us-east-2:538234414982:parameter/github/app/aws-codepipeline-authentication/private_key_secret_id"
      ]
    }
  ]
}
EOF
      }]
  }]