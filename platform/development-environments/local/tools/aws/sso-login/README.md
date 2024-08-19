# AWS SSO login
## **Table of Contents**
1. [Introduction](#1-introduction)
2. [Prerequisites](#2-prerequisites)
3. [Install AWS SSO](#3-install-aws-sso)  
    3.1. [MacOS](#31-macos)  
    3.2. [Windows](#32-windows)  
4. [AWS SSO configuration](#4-aws-sso-configuration)
5. [Appendix](#5-appendix)
## 1. **Introduction**

## 2. **Prerequisites**

## 3. **Install AWS SSO**

### 3.1. MacOS

```sh
$ python -m pip install aws-sso-util
```

```sh
$ aws sso login --profile $YOUR_AWS_PROFILE
```

### 3.2. Windows


## 4. **AWS SSO configuration**
```sh
sso_aws_url="CHANGEME"
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
```
## 5. **Appendix**
- [Official Package `aws-sso-util`](https://pypi.org/project/aws-sso-util/)
- [Official README](https://github.com/benkehoe/aws-sso-util/blob/master/README.md)