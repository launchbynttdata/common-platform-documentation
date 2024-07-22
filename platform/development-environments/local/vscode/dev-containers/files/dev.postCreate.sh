#!/bin/bash
work_dir="/workspaces/workplace"

git_token="<PAT>"
git_user="<GIT_USER>"
git_email="<GIT_EMAIL>"

sso_aws_url="<SSO_URL>"
sso_aws_account_id="<SSO_ACCOUNT_ID>"
sso_aws_region="us-east-1"

aws_root_account_id="<ROOT_ACCOUNT_ID>"
aws_sandbox_account_id="<SANDBOX_ACCOUNT_ID>"
aws_region="us-east-2"

# Set your Git token
echo 'export GITHUB_TOKEN="'${git_token}'"' >> ~/.bashrc

# Local user scripts to added to PATH for execution
echo 'export PATH="'${work_dir}'/.localscripts:${PATH}"' >> ~/.bashrc

# Install repo
mkdir -p ~/.bin
echo 'export PATH="${HOME}/.bin/repo:${PATH}"' >> ~/.bashrc
git clone https://github.com/launchbynttdata/git-repo.git ~/.bin/repo
chmod a+rx ~/.bin/repo

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc

# Install Launch CLI as a dev dependency
python -m pip install launch-cli

## Uncomment the following lines if wish to have a local 
## dev source as the install folder
# cd ${work_dir}/launch-cli
# python -m pip install -e '.[dev]'
# python3.12 -m pip install boto3
# cd ${work_dir}

# Set up netrc
echo "Setting ~/.netrc variables"
{   echo "machine github.com"; 
    echo "login ${git_user}"; 
    echo "password ${git_token}"; 
}  >> ~/.netrc
chmod 600 ~/.netrc

# Configure git
git config --global user.name "${git_user}"
git config --global user.email "${git_email}"
git config --global push.autoSetupRemote true

# shell aliases
echo 'alias git_sync="git pull origin main"' >> ~/.bashrc
echo 'alias git_boop="git reset --soft HEAD~1"' >> ~/.bashrc

# Set up AWS Config
mkdir -p ~/.aws
echo "
[default]
region = ${aws_region}
output = json

[profile launch]
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch DSO
sso_account_id = ${sso_aws_account_id}
sso_role_name = AdministratorAccess
region = ${aws_region}
credential_process = aws-sso-util credential-process --profile launch
sso_auto_populated = true

[profile launch-root-admin]
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch Root Account
sso_account_id = ${aws_root_account_id}
sso_role_name = AdministratorAccess
region = ${aws_region}
credential_process = aws-sso-util credential-process --profile launch
sso_auto_populated = true

[profile launch-sandbox-admin]
sso_start_url = ${sso_aws_url}
sso_region = ${sso_aws_region}
sso_account_name = Launch Sandbox Account
sso_account_id = ${aws_sandbox_account_id}
sso_role_name = AdministratorAccess
region = ${aws_region}
credential_process = aws-sso-util credential-process --profile launch
sso_auto_populated = true
" >> ~/.aws/config
