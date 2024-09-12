git_tag = "1.1.0"

environment = "root"
instance_env = 0
instance_resource = 0
logical_product_family = "demo"
logical_product_service = "ecs_app"
bulk_lambda_functions = {
  pr_opened = {
    name = "opened"
    zip_file_path = "lambda.zip"
    handler = "codeBuildHandler.lambda_handler"
    environment_variables = {
      CODEBUILD_ENV_VARS_MAP = <<EOF
        {
          "SOURCE_REPO_URL": "repository.clone_url",
          "FROM_BRANCH": "pull_request.head.ref",
          "TO_BRANCH": "pull_request.base.ref",
          "MERGE_COMMIT_ID": "pull_request.head.sha"
        }
      EOF
      CODEBUILD_PROJECT_NAME = "demo-ecs_app_trigger_pipeline-useast2-root-000-cb-000"
      CODEBUILD_URL = "https://us-east-2.console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-2"
      GIT_SERVER_URL = "https://github.com"
      GIT_SECRET_SM_ARN = "<GIT_SECRET_SM_ARN>"
      LOGGING_LEVEL = "INFO"
      USERVAR_S3_CODEPIPELINE_BUCKET = "demo-ecs-app-pr-event-useast2-root-000-s3-000"
      VALIDATE_DIGITAL_SIGNATURE = "false"
      WEBHOOK_EVENT_TYPE = "opened"
    }
    attach_policy_json = true
    cors = {
      allow_credentials = true
      allow_origins = ["*"]
      allow_methods = ["*"]
      allow_headers = ["date", "keep-alive"]
      expose_headers = ["keep-alive", "date"]
      max_age = 86400
    }
    policy_json = <<EOF
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": [
                "codebuild:startBuild"
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
            "Action": [ "secretsmanager:GetSecretValue" ],
            "Effect": "Allow",
            "Resource": "*"
          }
        ]
      }
    EOF
  }
  pr_closed = {
    name = "closed"
    zip_file_path = "lambda.zip"
    handler = "codeBuildHandler.lambda_handler"
    environment_variables = {
      CODEBUILD_ENV_VARS_MAP = <<EOF
        {
          "SOURCE_REPO_URL": "repository.clone_url",
          "FROM_BRANCH": "pull_request.head.ref",
          "TO_BRANCH": "pull_request.base.ref",
          "MERGE_COMMIT_ID": "pull_request.merge_commit_sha"
        }
      EOF
      CODEBUILD_PROJECT_NAME = "demo-ecs_app_trigger_pipeline-useast2-root-000-cb-000"
      CODEBUILD_URL = "https://us-east-2.console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-2"
      GIT_SERVER_URL = "https://github.com"
      GIT_SECRET_SM_ARN = "<GIT_SECRET_SM_ARN>"
      LOGGING_LEVEL = "INFO"
      USERVAR_S3_CODEPIPELINE_BUCKET = "demo-ecs-app-pr-merge-useast2-root-000-s3-000"
      VALIDATE_DIGITAL_SIGNATURE = "false"
      WEBHOOK_EVENT_TYPE = "closed"
    }
    attach_policy_json = true
    cors = {
      allow_credentials = true
      allow_origins = ["*"]
      allow_methods = ["*"]
      allow_headers = ["date", "keep-alive"]
      expose_headers = ["keep-alive", "date"]
      max_age = 86400
    }
    policy_json = <<EOF
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": [
                "codebuild:startBuild"
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
            "Action": [ "secretsmanager:GetSecretValue" ],
            "Effect": "Allow",
            "Resource": "*"
          }
        ]
      }
    EOF
  }
  pr_edited = {
    name = "edited"
    zip_file_path = "lambda.zip"
    handler = "codeBuildHandler.lambda_handler"
    environment_variables = {
      CODEBUILD_ENV_VARS_MAP = <<EOF
        {
          "SOURCE_REPO_URL": "repository.clone_url",
          "FROM_BRANCH": "pull_request.head.ref",
          "TO_BRANCH": "pull_request.base.ref",
          "MERGE_COMMIT_ID": "pull_request.head.sha"
        }
      EOF
      CODEBUILD_PROJECT_NAME = "demo-ecs_app_trigger_pipeline-useast2-root-000-cb-000"
      CODEBUILD_URL = "https://us-east-2.console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-2"
      GIT_SERVER_URL = "https://github.com"
      GIT_SECRET_SM_ARN = "<GIT_SECRET_SM_ARN>"
      LOGGING_LEVEL = "INFO"
      USERVAR_S3_CODEPIPELINE_BUCKET = "demo-ecs-app-pr-event-useast2-root-000-s3-000"
      VALIDATE_DIGITAL_SIGNATURE = "false"
      WEBHOOK_EVENT_TYPE = "edited"
    }
    attach_policy_json = true
    cors = {
      allow_credentials = true
      allow_origins = ["*"]
      allow_methods = ["*"]
      allow_headers = ["date", "keep-alive"]
      expose_headers = ["keep-alive", "date"]
      max_age = 86400
    }
    policy_json = <<EOF
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": [
                "codebuild:startBuild"
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
            "Action": [ "secretsmanager:GetSecretValue" ],
            "Effect": "Allow",
            "Resource": "*"
          }
        ]
      }
    EOF
  }
  pr_sync = {
    name = "synchronize"
    zip_file_path = "lambda.zip"
    handler = "codeBuildHandler.lambda_handler"
    environment_variables = {
      CODEBUILD_ENV_VARS_MAP = <<EOF
        {
          "SOURCE_REPO_URL": "repository.clone_url",
          "FROM_BRANCH": "pull_request.head.ref",
          "TO_BRANCH": "pull_request.base.ref",
          "MERGE_COMMIT_ID": "pull_request.head.sha"
        }
      EOF
      CODEBUILD_PROJECT_NAME = "demo-ecs_app_trigger_pipeline-useast2-root-000-cb-000"
      CODEBUILD_URL = "https://us-east-2.console.aws.amazon.com/codesuite/codebuild/projects?region=us-east-2"
      GIT_SERVER_URL = "https://github.com"
      GIT_SECRET_SM_ARN = "<GIT_SECRET_SM_ARN>"
      LOGGING_LEVEL = "INFO"
      USERVAR_S3_CODEPIPELINE_BUCKET = "demo-ecs-app-pr-event-useast2-root-000-s3-000"
      VALIDATE_DIGITAL_SIGNATURE = "false"
      WEBHOOK_EVENT_TYPE = "synchronize"
    }
    attach_policy_json = true
    cors = {
      allow_credentials = true
      allow_origins = ["*"]
      allow_methods = ["*"]
      allow_headers = ["date", "keep-alive"]
      expose_headers = ["keep-alive", "date"]
      max_age = 86400
    }
    policy_json = <<EOF
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Action": [
                "codebuild:startBuild"
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
            "Action": [ "secretsmanager:GetSecretValue" ],
            "Effect": "Allow",
            "Resource": "*"
          }
        ]
      }
    EOF
  }
}