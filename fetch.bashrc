# ==============================================================================
# BASH ENTERPRISE CONFIG - FINAL PRO EDITION
# Optimized for: i7-6600U | UHD 520 | bspwm
# ==============================================================================

# --- System & History ---
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
shopt -s histappend
shopt -s checkwinsize

# --- Catppuccin Mocha Palette (RGB) ---
C_BG="30;30;46"
C_BLUE="137;180;250"
C_LAVENDER="180;190;254"
C_GREEN="166;227;161"
C_RED="243;139;168"

# --- Powerline Prompt Engine ---
__build_prompt() {
    local EXIT="$?"
    local ICON_USER="󰭹"
    local ICON_DIR="󰉋"
    local ICON_GIT="󰊢"

    # 1. User Segment (Blue, turns Red on error)
    local SEG1_BG=$C_BLUE
    [[ $EXIT -ne 0 ]] && SEG1_BG=$C_RED
    local S1="\[\e[48;2;${SEG1_BG}m\e[38;2;${C_BG}m\] ${ICON_USER} Neko \[\e[0m\]"

    # 2. Transition 1 (User -> Dir)
    local T1="\[\e[38;2;${SEG1_BG}m\e[48;2;${C_LAVENDER}m\]\[\e[0m\]"

    # 3. Directory Segment with Green Slashes
    # Logic: Colors only the "/" characters green within the path
    local RAW_DIR="\w"
    local COLORED_DIR="${RAW_DIR//\//\\[\e[38;2;${C_GREEN}m\\]/\\[\e[38;2;${C_BG}m\\]}"
    local S2="\[\e[48;2;${C_LAVENDER}m\e[38;2;${C_BG}m\] ${ICON_DIR} ${COLORED_DIR} \[\e[0m\]"

    # 4. Git Integration (Dynamic Label with Git Logo)
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local BRANCH=$(git branch --show-current)
        local T2="\[\e[38;2;${C_LAVENDER}m\e[48;2;${C_GREEN}m\]\[\e[0m\]"
        local S3="\[\e[48;2;${C_GREEN}m\e[38;2;${C_BG}m\] ${ICON_GIT} ${BRANCH} \[\e[0m\]"
        local TAIL="\[\e[38;2;${C_GREEN}m\]\[\e[0m\]"
        PS1="${S1}${T1}${S2}${T2}${S3}${TAIL} "
    else
        local TAIL="\[\e[38;2;${C_LAVENDER}m\]\[\e[0m\]"
        PS1="${S1}${T1}${S2}${TAIL} "
    fi
}

PROMPT_COMMAND=__build_prompt

# --- Professional Aliases ---
# Added --classify to show directories/ with a trailing slash
alias ls='ls --color=auto --group-directories-first --classify'
alias ll='ls -al --classify'
alias grep='grep --color=auto'
alias ..='cd ..'

# Config shortcuts for your bspwm/sxhkd setup
alias bspconf='nano ~/.config/bspwm/bspwmrc'
alias sxhkdconf='nano ~/.config/sxhkd/sxhkdrc'
