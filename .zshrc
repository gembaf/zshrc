#=================================================
#  Basic Configure
#=================================================

# viモード
bindkey -v

# エディタの設定
export EDITOR=vim

# 言語・文字コード設定
export LANG=ja_JP.UTF-8

# ビープ音を鳴らさない
setopt NO_BEEP

# 最近行ったディレクトリを記憶
setopt AUTO_PUSHD

# pushdの履歴を残さない
setopt PUSHD_IGNORE_DUPS

# リンクへ移動するとき実際のディレクトリへ移動
setopt CHASE_LINKS

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#=================================================
#  Color
#=================================================

# 色設定
# $fg[色名]/$bg[色名]$reset_color で色表示
autoload -U colors && colors

# 色定数
GREEN="%{$fg[green]%}"
GREEN_B="%{$fg_bold[green]%}"
BLUE="%{$fg[blue]%}"
BLUE_B="%{$fg_bold[blue]%}"
RED="%{$fg[red]%}"
RED_B="%{$fg_bold[red]%}"
CYAN="%{$fg[cyan]%}"
CYAN_B="%{$fg_bold[cyan]%}"
YELLOW="%{$fg[yellow]%}"
YELLOW_B="%{$fg_bold[yellow]%}"
MAGENTA="%{$fg[magenta]%}"
MAGENTA_B="%{$fg_bold[magenta]%}"
RESET="%{$reset_color%}"

#=================================================
#  Complement
#=================================================

# コマンドの補完
autoload -U compinit && compinit

# 補完機能の拡張
setopt EXTENDED_GLOB

# TAB1回でリスト表示
setopt AUTO_LIST

# TAB連打でメニュー表示
setopt AUTO_MENU

# ドットファイルも対象に含める
setopt GLOBDOTS

# 語の途中でもカーソル位置で補完
setopt COMPLETE_IN_WORD

# =の後のパス名なども補完
setopt MAGIC_EQUAL_SUBST

# 補完候補を詰めて表示
setopt LIST_PACKED

# 候補一覧選択を横進みにする
setopt LIST_ROWS_FIRST

# 補完候補を色付きで表示
# .dircolorsの反映
eval `dircolors ~/.zsh/myconf/.dir_colors -b`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# 補完対象の一覧を上下左右に移動できる
zstyle ':completion:*:default' menu select=2


#=================================================
#  History
#=================================================

# ヒストリファイルの指定
HISTFILE="$HOME/.zsh_histfile"

# 履歴件数の指定
HISTSIZE=1000
SAVEHIST=100000

# 重複した履歴を保存しない
setopt HIST_IGNORE_DUPS

# 履歴を共有
setopt SHARE_HISTORY

# 余分な空白を削除して履歴を保存
setopt HIST_REDUCE_BLANKS

# 入力の途中でもヒストリ検索
#autoload history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey -v "^P" history-beginning-search-backward-end
#bindkey -v "^N" history-beginning-search-forward-end
#bindkey -a "^P" history-beginning-search-backward-end
#bindkey -a "^N" history-beginning-search-forward-end

#=================================================
#  Alias
#=================================================

alias ls="ls -F --color"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias lr="ls -R"

#=================================================
#  Prompt
#=================================================

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt PROMPT_SUBST

# コマンド実行後に右プロンプトを消す
#setopt TRANSIENT_RPROMPT

# VCS_INFOの使用
autoload -Uz VCS_INFO_get_data_git && VCS_INFO_get_data_git 2> /dev/null

PROMPT_USER='${CYAN_B}[${MAGENTA_B}%n${YELLOW_B}@${BLUE_B}%m${CYAN_B}]$RESET'
PROMPT_GIT='`git-current-branch`'
PROMPT_DIR='${CYAN_B}['${PROMPT_GIT}'${GREEN_B}%~${CYAN_B}]${RESET}'
PROMPT_ROLE='${CYAN_B} %(!.#.$) >$RESET'

PROMPT="${PROMPT_USER}${PROMPT_DIR}"$'\n'"[${RED_B}Ins${RESET}]${PROMPT_ROLE}"

#------------------------------------------------
#  branch名の取得
#------------------------------------------------
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
    color=$RED_B
  else
    color=$RED
  fi
  echo "$color$name$action $RESET"
}

#------------------------------------------------
#  viのモードの取得
#  PROMPTのセット
#------------------------------------------------
function zle-line-init zle-keymap-select {
  PROMPT="${PROMPT_USER}${PROMPT_DIR}"$'\n'

  case $KEYMAP in
    vicmd)
      PROMPT="${PROMPT}[${BLUE_B}Nor${RESET}]"
      ;;
    main|viins)
      PROMPT="${PROMPT}[${RED_B}Ins${RESET}]"
      ;;
  esac
  PROMPT="${PROMPT}${PROMPT_ROLE}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

#=================================================
#  Vim Keybind
#=================================================

#------------------------------------------------
#  Insert Mode
#------------------------------------------------

# 1文字移動
bindkey -v '^F^L' forward-char
bindkey -v '^F^H' backward-char

# <C-y>でundo
bindkey -v '^Y' vi-undo-change

# <C-u>でカーソルの左側だけ削除する
bindkey -v '^U' backward-kill-line

# <C-o>で現在の行をコマンドラインスタックに積む
bindkey -v '^O' push-line

# jjでNormalモード
bindkey -v 'jj' vi-cmd-mode

# <C-n>で補完開始
bindkey -v '^N' expand-or-complete

# 補完メニュー表示時に'hjkl'で選択
# <C-p>で補完バック
zmodload -i zsh/complist
bindkey -M menuselect \
  '^P' up-line-or-history \
  'k' up-line-or-history \
  '^J' down-line-or-history \
  'j' down-line-or-history \
  'h' backward-char \
  'l' forward-char

# <C-k>で補完確定
bindkey -v '^K' accept-line

# <C-d>でDeleteキーと同じ動き
bindkey -v '^D' vi-delete-char

#------------------------------------------------
#  Normal(Command) Mode
#------------------------------------------------
#<C-o>で現在の行をコマンドラインスタックに積む
bindkey -a '^O' push-line

# Normalモード時に<C-m>で<CR>+Insert_modeに移行
vicmd_accept-line(){
  zle accept-line
  zle vi-insert
}
zle -N vicmd_accept-line
bindkey -a '^M' vicmd_accept-line






