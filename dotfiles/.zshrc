# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

bindkey '^[[D' beginning-of-line      # [Home] - Go to beginning of line

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

## test zsh-git-prompt
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions extract z)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal a__ember_auto_import__ =/***liases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# python
# alias python="/usr/local/bin/python3"


# load zsh-git-prompt
# can use houfeng0923/zsh-git-prompt instead
# source "/usr/local/opt/zsh-git-prompt/zshrc.sh"

# nvm
# default brew config (bak)

# export NVM_DIR="$HOME/.nvm"
# . "$(brew --prefix nvm)/nvm.sh"

# # place this after nvm initialization!
# autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

if [ ! "$(type -w __init_nvm)" = '__init_nvm: function' ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack' 'ember' 'vue' 'create-react-app')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    # . "$NVM_DIR"/nvm.sh
    . "$(brew --prefix nvm)/nvm.sh" # --no-use
    unset __node_commands
    unset -f __init_nvm
    load-nvmrc
    add-zsh-hook chpwd load-nvmrc
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

#java

#export JAVA_HOME=/usr/libexec/java_home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home
export PATH=$JAVA_HOME:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
# cnpm
# alias cnpm="npm --registry=https://registry.npm.taobao.org \
# --cache=$HOME/.npm/.cache/cnpm \
# --disturl=https://npm.taobao.org/dist \
# --userconfig=$HOME/.cnpmrc"


# alias app
alias xargs="xargs "
alias subl="open -a Sublime\ Text.app"
alias idea="open -a IntelliJ\ IDEA.app"
alias coded="code --disable-extensions --max-memory "

# alias chrome="open -a Google\ Chrome.app"
alias as="open -a Android\ Studio.app"
alias chrome="mktemp -d | xargs -I % open -a /Applications/Google\ Chrome.app -n --args --user-data-dir=%  --no-first-run --disable-translate"

# nginx
# export PATH="/opt/nginx/sbin:$PATH"

## z
. `brew --prefix`/etc/profile.d/z.sh

## export PATH="$HOME/.yarn/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


## android adb

export PATH="/Users/houfeng/soft/platform-tools:$PATH"

### npm alisa

alias nr="npm run "

### git alias
alias gls="git ls"
alias gcm="git cm"
alias gco="git co"
alias gaa="git add --all"
alias gc1="git clone --depth=1"
alias gdsf="git dsf"
alias gacm="git add --all && git cm"
alias lg="lazygit -f"
alias glg="lazygit"
alias gpls="git pl && git ps"
alias gpp="git pp "
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# Virtual Environment Wrapper
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
# source /usr/local/bin/virtualenvwrapper.sh




### key

bindkey "[D" backward-word
bindkey "[C" forward-word
# bindkey "^[a" beginning-of-line
# bindkey "^[e" end-of-line

### alias cat

alias cat="ccat -G Plaintext=\"darkred\""
#alias cat="bat"
alias oldcat='/bin/cat'

### yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"

alias y='yarn'
alias yw='yarn why'
alias yi='_a(){ yarn info $1 versions}; _a'

## conda

export PATH=opt/anaconda3/bin/:$PATH

### flutter
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

export ANDROID_HOME=/Users/houfeng/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

export FLUTTER_HOME=/Users/houfeng/flutter-sdk
export PATH=$PATH:$FLUTTER_HOME/bin

### chrome driver
export CHROMEDRIVER_CDNURL=http://npm.taobao.org/mirrors/chromedriver

### fzf and alias

export FZF_DEFAULT_OPTS='--height 80% --reverse --border'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#alias vimf="vim $(fzf --height 50%)"


fzfp() {
fzf --height 100% --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'
alias tt='fzf --height 100% --preview '"'"'[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {}  || highlight -O ansi -l {} || coderay {} || cat {}) 2> /dev/null | head -500'"'"
}

# fzf git show ***
fgs() {
fzf --height 100%  --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always'
}


# https://github.com/SidOfc/dotfiles/blob/d07fa3862e/zsh/kp
kp() {
### PROCESS
# mnemonic: [K]ill [P]rocess
# show output of "ps -ef", use [tab] to select one or multiple entries
# press [enter] to kill selected processes and go back to the process list.
# or press [escape] to go back to the process list. Press [escape] twice to exit completely.

local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

if [ "x$pid" != "x" ]
then
  echo $pid | xargs kill -${1:-9}
  kp
fi
}

## super autojump

sj() {
 cd `j -s | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[select:path]'" | awk '{print $2}'`
}


# ulimit
ulimit -Sn 4096 && ulimit -Sl unlimited


# tmux

alias t="tmux"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
