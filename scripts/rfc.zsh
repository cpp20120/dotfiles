export _ZO_FZF_OPTS='
    --no-sort --height 75% --reverse --margin=0,1 --exit-0 --select-1
    --bind ctrl-f:page-down,ctrl-b:page-up
    --bind pgdn:preview-page-down,pgup:preview-page-up
    --prompt="❯ "
    --color bg+:#262626,fg+:#dadada,hl:#f09479,hl+:#f09479
    --color border:#303030,info:#cfcfb0,header:#80a0ff,spinner:#36c692
    --color prompt:#87afff,pointer:#ff5189,marker:#f09479
    --preview "([[ -e '{2..}/README.md' ]] && bat --color=always --style=numbers --line-range=:50 '{2..}/README.md') || exa --color=always --group-directories-first --oneline {2..}"
'