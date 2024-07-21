#!/bin/bash
echo 'export GITHUB_TOKEN="<PAT_HERE>"' >> ~/.bashrc

# Local user scripts to added to PATH for execution
echo 'export PATH="/workspaces/workplace/.localscripts:${PATH}"' >> ~/.bashrc

# Install repo
mkdir -p ~/.bin
echo 'export PATH="${HOME}/.bin/repo:${PATH}"' >> ~/.bashrc
git clone https://github.com/launchbynttdata/git-repo.git ~/.bin/repo
chmod a+rx ~/.bin/repo

# Install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc

# install Launch CLI as a dev dependency
python -m pip install launch-cli
## Uncomment the following lines if wish to have a local 
## dev source as the install folder
# cd /workspaces/workplace/launch-cli
# python -m pip install -e '.[dev]'
# python3.12 -m pip install boto3
# cd /workspaces/workplace/

# Set up netrc
echo "Setting ~/.netrc variables"
{   echo "machine github.com"; 
    echo "login aaron-christian-nttd"; 
    echo "password ${DELETE_ME_TOKEN}"; 
}  >> ~/.netrc
chmod 600 ~/.netrc

# Configure git
git config --global user.name "aaron-christian-nttd"
git config --global user.email "aaron.christian@nttdata.com"
git config --global push.autoSetupRemote true

# shell aliases
echo 'alias git_sync="git pull origin main"' >> ~/.bashrc
echo 'alias git_boop="git reset --soft HEAD~1"' >> ~/.bashrc

# for dir in /workspaces/workplace/*; do (cd "$dir" && git_sync && make configure); done
mkdir -p ~/.aws
echo "
[default]
region = us-east-2
output = json

[profile launch]
sso_start_url = <REPLACE_WITH_YOUR_URL>
sso_region = us-east-1
sso_account_name = Launch DSO
sso_account_id = <REPLACE_WITH_YOUR_ACCOUNT_ID>
sso_role_name = AdministratorAccess
region = us-east-2
credential_process = aws-sso-util credential-process --profile launch
sso_auto_populated = true

[profile launch-root-admin]
sso_start_url = <REPLACE_WITH_YOUR_URL>
sso_region = us-east-1
sso_account_name = Launch DSO
sso_account_id = <REPLACE_WITH_YOUR_SANDBOX_ACCOUNT_ID>
sso_role_name = AdministratorAccess
region = us-east-2
credential_process = aws-sso-util credential-process --profile launch
sso_auto_populated = true

[profile launch-sandbox-admin]
sso_start_url = <REPLACE_WITH_YOUR_URL>
sso_region = us-east-1
sso_account_name = Launch DSO
sso_account_id = <REPLACE_WITH_YOUR_ROOT_ACCOUNT_ID>
sso_role_name = AdministratorAccess
region = us-east-2
credential_process = aws-sso-util credential-process --profile launch
sso_auto_populated = true
" >> ~/.aws/config
