#=================================================
#  Basic Configure
#=================================================

# 色設定
# $fg[色名]/$bg[色名]$reset_color で色表示
autoload -U colors && colors

# 言語・文字コード設定
export LANG=ja_JP.UTF-8

# ビープ音を鳴らさない
setopt NO_BEEP

# 最近行ったディレクトリを記憶
setopt AUTO_PUSHD

# リンクへ移動するとき実際のディレクトリへ移動
setopt CHASE_LINKS

# pushdの履歴を残さない
setopt PUSHD_IGNORE_DUPS

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#=================================================
#  Complement
#=================================================

# コマンドの補完
autoload -U compinit && compinit

# 補完機能の拡張
setopt EXTENDED_GLOB

# ドットファイルも対象に含める
setopt GLOBDOTS

# 語の途中でもカーソル位置で補完
setopt COMPLETE_IN_WORD

# =の後のパス名なども補完
setopt MAGIC_EQUAL_SUBST

# 補完候補を詰めて表示
setopt LIST_PACKED

# 補完候補を色付きで表示
# .dircolorsの反映
eval `dircolors ~/.zsh/myconf/.dir_colors -b`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# 補完対象の一覧を上下左右に移動できる
zstyle ':completion:*:default' menu select=2

#=================================================
#  Command History
#=================================================

# ヒストリファイルの指定
HISTFILE="$HOME/.zsh_histfile"

# 履歴件数の指定
HISTSIZE=100000
SAVEHIST=100000

# 重複した履歴を保存しない
setopt HIST_IGNORE_DUPS

# 履歴を共有
setopt SHARE_HISTORY

# 余分な空白を削除して履歴を保存
setopt HIST_REDUCE_BLANKS

#autoload history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^P" history-beginning-search-backward-end
#bindkey "^N" history-beginning-search-forward-end

#=================================================
#  Alias
#=================================================

alias ls="ls -F --color"
alias la="ls -a"
alias lr="ls -R"

#=================================================
#  Color
#=================================================

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

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt PROMPT_SUBST

# VCS_INFOの使用
autoload -Uz VCS_INFO_get_data_git && VCS_INFO_get_data_git 2> /dev/null

# branch名の取得
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


