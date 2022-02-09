source ~/.zsh/.zshrc

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/local/share/rubygems/gems/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
eval "$(rbenv init -)"
