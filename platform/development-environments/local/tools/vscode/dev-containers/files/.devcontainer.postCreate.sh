#!/usr/bin/bash
# This script is ran within the dev container and does not make
# changes to the host machine. It is used to set up the dev container.

work_dir="/workspaces/CHANGEME"
git_token="CHANGEME"

sso_aws_url="CHANGEME"
sso_aws_region="us-east-1"

aws_root_account_id="CHANGEME"
aws_prod_account_id="CHANGEME"
aws_sandbox_account_id="CHANGEME"
aws_region="us-east-2"

github_public_user="CHANGEME"
github_public_email="CHANGEME@CHANGEME.com"

# Set your ENV vars
echo 'export GITHUB_TOKEN='${git_token} >> ~/.bashrc
echo 'export GOPRIVATE="github.com/launchbynttdata"' >> ~/.bashrc

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

# Install aws-sso-util as a make check dependency
python -m pip install aws-sso-util

# Install Launch CLI as a dev dependency
python -m pip install launch-cli

python -m pip install ruamel_yaml

## Uncomment the following lines if wish to have a local 
## dev source as the install folder
# cd ${work_dir}/launch-cli
# python -m pip install -e '.[dev]'
# python3.12 -m pip install boto3
# cd ${work_dir}

# Set up netrc
echo "Setting ~/.netrc variables"
echo machine github.com >> ~/.netrc
echo login ${github_public_user} >> ~/.netrc
echo password ${git_token} >> ~/.netrc
chmod 600 ~/.netrc

# Configure git
git config --global user.name ${github_public_user}
git config --global user.email ${github_public_email}
git config --global push.autoSetupRemote true
git config --global --add safe.directory '*'
git config --global credential.credentialStore cache

# shell aliases
echo 'alias git_sync="git pull origin main"' >> ~/.bashrc # Alias to sync the repo with the main branch
echo 'alias git_boop="git reset --soft HEAD~1"' >> ~/.bashrc # Alias to undo the last local commit but keep the changes

# Set up AWS Config
# Default profile is set to the Launch Sandbox Account.
mkdir -p ~/.aws
echo "
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
" >> ~/.aws/config

echo "Dev container setup complete"