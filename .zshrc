
#よくわからん
autoload -U compinit
compinit

#ディレクトリ名だけでcdできる
#setopt auto_cd

#タブとか押したときにビープ音が鳴らない
setopt NO_beep

#スペルチェック
#setopt correct_all

#最近行ったディレクトリを記憶している
setopt autopushd

# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

#よくわからん
autoload -U colors
colors

#エイリアス系
alias la="ls -a"
alias lr="ls -R"
alias ls="ls -F --color"
alias pd="pwd"
alias e="emacs"
alias v="vim"

#よくわからん
export LANG=ja_JP.UTF-8
setopt COMPLETE_IN_WORD

#大文字と小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#色は.dir_colors参照
eval `dircolors ~/.dir_colors -b`
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# 色
######################################
# デフォルト          0
# 明るくする          1
# 下線をつける        4
# 前景と背景の逆転    7
# 非表示              8
#
# 赤 31
# 緑 32
# 黄 33
# 青 34
# 紫 35
# 空 36
# 灰 37
######################################

GREEN=$'%{\e[0;32m%}'
BLUE=$'%{\e[0;34m%}'
CYAN=$'%{\e[0;36m%}'
PURPLE=$'%{\e[0;35m%}'
YELLOW=$'%{\e[0;33m%}'
LIGHT_GRAY=$'%{\e[0;37m%}'

DEFAULT=$'%{\e[0m%}'

# プロンプト
PROMPT="$CYAN(%n@%m)-(%(!.#.$))-----
-->"
RPROMPT="$CYAN [%~]$DEFAULT"

# Ruby gem
export GEM_HOME=$HOME/local/share/rubygems/gems
export RUBYLIB=$HOME/local/share/rubygems/lib
export RB_USER_INSTALL=true

