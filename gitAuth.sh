#!/bin/bash

# Setup repo
curl -sL https://gerrit.googlesource.com/git-repo/+/refs/heads/stable/repo?format=TEXT | base64 --decode > repo
chmod a+rx repo && sudo cp repo /usr/bin/repo

# Setup git auth
git config --global user.email ${GIT_MAIL}
git config --global user.name ${GIT_NAME}
git config --global color.ui true
git config --global core.editor nano
git config --global credential.helper store
echo "https://${GIT_NAME}:${GIT_TOKEN}@github.com" > ~/.git-credentials
# Setup google git cookies
git clone -q https://${GIT_TOKEN}@github.com/${GIT_NAME}/google-git-cookies --depth=1 cookies
chmod a+x ./cookies/setup_cookies.sh && ./cookies/setup_cookies.sh &>/dev/null
rm -rf cookies
