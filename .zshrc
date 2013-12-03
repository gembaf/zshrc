#=================================================
#  Basic Configure
#=================================================

# コマンドの補完
autoload -U compinit && compinit

# 色設定
# $fg[色名]/$bg[色名]$reset_color で色表示
autoload -U colors && colors

# VCS_INFOの使用
autoload -Uz VCS_INFO_get_data_git && VCS_INFO_get_data_git 2> /dev/null

# 言語・文字コード設定
export LANG=ja_JP.UTF-8

# ビープ音を鳴らさない
setopt NO_BEEP

# 連続した同じコマンドをヒストリに追加しない
setopt HIST_IGNORE_DUPS

# 最近行ったディレクトリを記憶
setopt AUTO_PUSHD

# 語の途中でもカーソル位置で補完
setopt COMPLETE_IN_WORD

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt PROMPT_SUBST

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


#=================================================
#  Alias
#=================================================

alias ls="ls -F --color"
alias la="ls -a"
alias lr="ls -R"


#=================================================
#  Color
#=================================================

# .dircolorsの反映
eval `dircolors ~/.zsh/myconf/.dir_colors -b`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# 色定数
GREEN="%{$fg[green]%}"
RED="%{$fg[red]%}"
RED_BOLD="%{%B$fg[red]%}"
CYAN="%{$fg[cyan]%}"
YELLOW="%{$fg[yellow]%}"
MAGENTA="%{$fg[magenta]%}"

#=================================================
#  Prompt
#=================================================

function git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=$GREEN
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=$YELLOW
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=$RED_BOLD
  else
    color=$RED
  fi
  echo "[$color$name$action%{$reset_color%}]$CYAN--%{$reset_color%}"
}

p_info='$CYAN(%n@%m)--%{$reset_color%}'
p_git='`git-current-branch`'
p_under='$CYAN%(!.#.$) > %{$reset_color%}'

PROMPT=$p_info$p_git$'\n'$p_under
RPROMPT='$GREEN [%~]%{$reset_color%}'


