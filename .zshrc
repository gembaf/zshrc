#================================================
#  Basic Configure
#================================================

# ビープ音を鳴らさない
setopt NO_beep

# 連続した同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 最近行ったディレクトリを記憶
setopt autopushd

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


#================================================
#  Alias
#================================================

alias ls="ls -F --color"
alias la="ls -a"
alias lr="ls -R"


#================================================
#  Color
#================================================

# .dircolorsの反映
eval `dircolors ~/.zsh/myconf/.dir_colors -b`
zstyle ':completion:*:default' list-colors ${LS_COLORS}


#================================================
#  Prompt
#================================================

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





#よくわからん
autoload -U compinit
compinit

#よくわからん
autoload -U colors
colors

#よくわからん
export LANG=ja_JP.UTF-8
setopt COMPLETE_IN_WORD

