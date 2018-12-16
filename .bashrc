# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#if ! ps -p $SSH_AGENT_PID > /dev/null
#then 
#	export SSH_AGENT=`ssh-agent`
#fi
#eval $SSH_AGENT

# not everything lives here
#if [ -f ~/.ssh/github_id_rsa ] && [ ! -f ~/.vim/bundle/vundle ]; then
#  mkdir -p ~/.vim/bundle
#  git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
#  vim +PluginInstal +qall
#  vim +BundleUpdate +qall
#fi
  
#THAT HISTORY IS MINE, DAMMIT
unset HISTSIZE 
unset HISTFILESIZE
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# environment stuff
source /usr/share/doc/git*/contrib/completion/git-prompt.sh
PS1='[\u@\h`__git_ps1` \W]\$ '
export EDITOR="/usr/bin/vim"
alias check="xmllint --noout --xinclude --postvalid --noent"
alias moo="xcowsay 'that thing you started is done now'"

# Accountability
export ANSIBLE_CONFIG="/home/pete/ansible-games/ansible.cfg"
export BODHI_USER="immanetize"
export GITHUB_USER="immanetize"

# ssh stuff
[ -S /run/user/$(id -u)/keyring/ssh ] || gnome-keyring-daemon --replace -C /run/user/$(id -u)/keyring 
export SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"
systemctl --user set-environment SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"

# aliases
alias dotfiles="/usr/bin/vcsh dotfiles"
