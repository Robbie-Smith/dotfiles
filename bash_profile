[[ -s ~/.bashrc ]] && source ~/.bashrc
export CLICOLOR=1
export TERM=xterm-256color
export LSCOLORS=GxFxCxDxBxegedabagaced
export PATH=/usr/local/bin:$PATH
export EDITOR=atom
export GOPATH=$HOME/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  export PS1="\n$RED\u $PURPLE@ $GREEN\W $RESETCOLOR$GREENBOLD\$(parse_git_branch)\n$BLUE → $RESETCOLOR"
  PS1="\$(~/.rvm/bin/rvm-prompt) $PS1"
  export PS2=" | → $RESETCOLOR"
}

prompt

alias bash='atom ~/.dotfiles/bash_profile'
alias reload='source ~/.dotfiles/bash_profile'
alias vim='nvim'
alias ls="ls -GFh"
alias show='ls'
alias c='clear'
alias home="cd ~"
alias up='cd ..'
alias be='bundle exec'
alias back='cd -'
alias opencov="open coverage/index.html"
alias mod1="cd ~/Turing/1module"
alias mod2="cd ~/Turing/2module"
alias mod3="cd ~/Turing/3module"
alias drills="cd ~/exercism"
alias browse="hub browse"
alias g='git'
alias ga="git add ."
alias gs="git status"
alias gcm="git commit -m"
alias gpo="git push origin"
alias gb="git branch"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gmaster="git checkout master"
alias gac="git add . && git commit -m"
alias gpom="git pull origin master"
alias showdotfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidedotfiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias today="open http://today.turing.io"

function lazygit() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  git add .
  git commit -m "$1"
  git push -u origin "${BRANCH}"
}

function lazyrails() {
  rails new "$1" -d postgresql --skip-test-unit --skip-spring -T
  cd "$1"
  echo 'gem "rspec-rails", :group => [:development, :test]' >> Gemfile
  echo 'gem "capybara", :group => [:development, :test]' >> Gemfile
  echo 'gem "factory_girl_rails", :group => [:development, :test]' >> Gemfile
  echo 'gem "launchy", :group => [:development, :test]' >> Gemfile
  echo 'gem "database_cleaner", :group => [:development, :test]' >> Gemfile
  echo 'gem "faker", :group => [:development, :test]' >> Gemfile
  echo 'gem "pry", :group => [:development, :test]' >> Gemfile
  echo 'gem "shoulda-matchers", :group => [:development, :test]' >> Gemfile
  bundle
  rails g rspec:install
  mkdir spec/support
  mkdir spec/features
  mkdir spec/models
  touch spec/support/factory_girl.r b
}

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

md () { mkdir -p "$@" && cd "$@";}

# git aware prompt
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# get current branch in git repo
function parse_git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo -e "\033[m|\033[33m${BRANCH} \033[m${STAT}\033[m|\033[m"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits="R${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="→${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="✖${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="✗${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo -e "\033[31m${bits}\033[m"
	else
		echo -e " \033[32m✓\033[m"
	fi
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# fd - cd to selected directory
fd() {
  DIR=`find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# fda - including hidden directories
fda() {
  DIR=`find ${1:-.} -type d 2> /dev/null | fzf-tmux` && cd "$DIR"
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
  cd "$DIR"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}


# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf-tmux --query="$1" --select-1 --exit-0) &&
  tmux switch-client -t "$session"
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
# RVM integration
frb() {
  local rb
  rb=$((echo system; rvm list | grep ruby | cut -c 4-) |
       awk '{print $1}' |
       fzf-tmux -l 30 +m --reverse) && rvm use $rb
}
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
