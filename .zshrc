# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting eza sudo colorize grc tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ==================================== ALIASES ===============================================

# HTB essentials
alias www='python3 -m http.server 80'
alias www8='python3 -m http.server 8000'
alias nl='nc -lvnp'
alias fuf='ffuf -k -mc 200,301,302,403'

# TTY upgrade one-liner
alias tty-upgrade='python3 -c "import pty;pty.spawn(\"/bin/bash\")"'

# Add host to /etc/hosts quickly
# Usage: addhost 10.10.11.1 target.htb
addhost() { echo "$1  $2" | sudo tee -a /etc/hosts; }

# Set target IP and auto-update hosts
target() {
    export IP=$1
    export HOST=${2:-target.htb}
    echo "$IP  $HOST" | sudo tee -a /etc/hosts
    echo "[+] Target set: $IP ($HOST)"
}

# Quick nmap
alias nf='nmap -sCV -p- --min-rate 5000'
alias nq='nmap -sCV --top-ports 1000'

# Reverse shell listener with rlwrap for arrow keys
alias rl='rlwrap nc -lvnp'

# Search CVEs from terminal
cve() {
    curl -s "https://cve.circl.lu/api/search/$1" | python3 -m json.tool | grep -E "id|summary" | head -30
}
# Usage: cve flask
# Usage: cve werkzeug

# CVE search - multiple sources
cve() {
    echo "\n[+] NVD Results for: $1"
    curl -s "https://services.nvd.nist.gov/rest/json/cves/2.0?keywordSearch=$1&resultsPerPage=5" | \
        python3 -c "
import sys,json
d=json.load(sys.stdin)
for v in d.get('vulnerabilities',[]):
    c=v['cve']
    print(f\"\nCVE: {c['id']}\")
    print(f\"Severity: {c.get('metrics',{}).get('cvssMetricV31',[{}])[0].get('cvssData',{}).get('baseSeverity','N/A')}\")
    print(f\"Summary: {c['descriptions'][0]['value'][:200]}\")
"
}

# Quick exploit search via exploit-db
searchcve() {
    searchsploit $1 | head -20
}
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.0.0'
export PATH=$PATH:~/go/bin

#Tools 
alias cat="batcat"
alias ls="eza -a --color=always --group-directories-first"
alias la="eza -la --color=always --group-directories-first"
