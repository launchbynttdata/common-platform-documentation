# AWS cli config

```
sso_aws_url="https://d-9067900a0a.awsapps.com/start/#"
sso_aws_region="us-east-1"

aws_root_account_id="CHANGEME"
aws_prod_account_id="CHANGEME"
aws_sandbox_account_id="CHANGEME"
aws_region="us-east-2"

[default]
region = ${aws_region}
output = json
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch Sandbox Account
sso_account_id = ${aws_sandbox_account_id}
sso_role_name = AdministratorAccess
credential_process = aws-sso-util credential-process --profile launch-sandbox-admin
sso_auto_populated = true

[profile launch-prod-admin]
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch Production
sso_account_id = ${aws_prod_account_id}
sso_role_name = AdministratorAccess
region = ${aws_region}
credential_process = aws-sso-util credential-process --profile launch-prod-admin
sso_auto_populated = true

[profile launch-root-admin]
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch Root Account
sso_account_id = ${aws_root_account_id}
sso_role_name = AdministratorAccess
region = ${aws_region}
credential_process = aws-sso-util credential-process --profile launch-root-admin
sso_auto_populated = true

[profile launch-sandbox-admin]
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch Sandbox Account
sso_account_id = ${aws_sandbox_account_id}
sso_role_name = AdministratorAccess
region = ${aws_region}
credential_process = aws-sso-util credential-process --profile launch-sandbox-admin
sso_auto_populated = true