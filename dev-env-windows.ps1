#
# Functions
#

function Update-Environment-Path
{
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") `
        + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

#
# Package Managers
#

# Choco
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | iex
Update-Environment-Path

#
# Git
#

choco install git --yes --params '/GitAndUnixToolsOnPath'
choco install tortoisegit --yes
Update-Environment-Path
git config --global alias.pom 'pull origin master'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls "log --pretty=format:'%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]' --decorate --date=short"
git config --global alias.ammend "commit -a --amend"
git config --global alias.standup "log --since yesterday --author $(git config user.email) --pretty=short"
git config --global alias.everything "! git pull && git submodule update --init --recursive"
git config --global alias.aliases "config --get-regexp alias"

#
# Languages
#
choco install python3 --yes
choco install jdk8 --yes
Update-Environment-Path

# Node
choco install nodejs.install --yes
Update-Environment-Path
npm install --global --production npm-windows-upgrade
npm-windows-upgrade --npm-version latest 
npm install -g yo
npm install -g mocha
npm install -g typescript
# npm install prettier-eslint --save-dev

#
# Docker
# 

# Hyper-V required for docker and other things
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All -NoRestart

choco install docker --yes
choco install docker-machine --yes
choco install docker-compose --yes
choco install docker-for-windows --yes

Update-Environment-Path

#
# VS Code
#

choco install visualstudiocode --yes #
Update-Environment-Path
code --install-extension robertohuertasm.vscode-icons
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension eamodio.gitlens

# PowerShell support
code --install-extension ms-vscode.PowerShell

# HTML, CSS, JavaScript support
code --install-extension Zignd.html-css-class-completion
code --install-extension lonefy.vscode-JS-CSS-HTML-formatter
code --install-extension robinbentley.sass-indented
code --install-extension dbaeumer.vscode-eslint
code --install-extension RobinMalfait.prettier-eslint-vscode
code --install-extension flowtype.flow-for-vscode
code --install-extension dzannotti.vscode-babel-coloring
code --install-extension esbenp.prettier-vscode
code --install-extension formulahendry.auto-rename-tag

# NPM support
code --install-extension eg2.vscode-npm-script
code --install-extension christian-kohler.npm-intellisense

# Mocha support
code --install-extension spoonscen.es6-mocha-snippets
code --install-extension maty.vscode-mocha-sidebar

# Jasmin Support
code --install-extension hbenl.vscode-jasmine-test-adapter

# Jest support
code --install-extension Orta.vscode-jest

# React Native support
code --install-extension vsmobile.vscode-react-native
npm install -g create-react-native-app
npm install -g react-native-cli

# Docker support
code --install-extension PeterJausovec.vscode-docker

# Markdown Support 
code --install-extension yzhang.markdown-all-in-one
code --install-extension mdickin.markdown-shortcuts

# File Management
choco install beyondcompare --yes
choco install 7zip --yes
choco install filezilla --yes

# Media Viewers
choco install irfanview --yes
choco install vlc --yes

# Browsers
choco install firefox --yes

# Misc
choco install sysinternals --yes
choco install procexp --yes
choco install awscli --yes
choco install firacode --yes # See https://www.youtube.com/watch?v=KI6m_B1f8jc
choco install everything --yes

Update-Environment-Path

Write-Output "Finished! Run `choco upgrade all` to get the latest software"