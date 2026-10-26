# Pakk ut en fil basert på filtype (tar, zip, 7z, rar, etc.)
function extract() {
  if [ -f "$1" ]; then
    case $1 in
      *.tar.bz2) tar xvjf "$1"    ;;
      *.tar.gz)  tar xvzf "$1"    ;;
      *.bz2)     bunzip2 "$1"     ;;
      *.rar)     rar x "$1"       ;;
      *.gz)      gunzip "$1"      ;;
      *.tar)     tar xvf "$1"     ;;
      *.tbz2)    tar xvjf "$1"    ;;
      *.tgz)     tar xvzf "$1"    ;;
      *.zip)     unzip "$1"       ;;
      *.Z)       uncompress "$1"  ;;
      *.7z)      7z x "$1"        ;;
      *)         echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Oppdater Homebrew-pakker; fjerner quarantine på claude og restarter ollama ved oppdatering
function update() {
  brew update || return 1
  local outdated
  outdated=$(brew outdated --quiet) || return 1
  brew upgrade --yes || return 1
  if grep -qx claude-code <<< "$outdated"; then
    xattr -d com.apple.quarantine "$(which claude)"
  fi
  if grep -qx ollama <<< "$outdated"; then
    brew services restart ollama
  fi
}
