
# update os
alias au='if command -v apt &> /dev/null; then sudo apt update && apt list --upgradable; else echo "Error: apt not found. This alias requires a Debian-based system."; fi'

# My custom aliases
alias ll='ls -la'
alias gc='git commit'
alias gca='git commit --amend'
alias gs='git status' 



git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}


# Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Nav
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## Git
alias clean='git clean -xdf'
alias clone='git clone'
alias push='git push origin'

#git push -u origin $(git branch --show-current)
# Gets current branch name

alias pushupstream='git push --set-upstream origin $(git_branch)'

alias pull='git pull'
function commit {
  git commit -m "$*"
}
alias fetch='git fetch && git status'

alias addall='git add -A'

function st {
  git status | sed -n '/Your/,/^$/p' && \
  git status -s && echo && \
  git log --pretty=format:"%h - <%an> %s (%cr)" --date=relative -3 && echo

}

alias co='git checkout'
alias pick='git cherry-pick'

