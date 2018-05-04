local ret_status="%(?:%{$fg_bold[blue]%}>> :%{$fg_bold[red]%}>> )"
PROMPT='${ret_status}%{$reset_color%}%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$fg[yellow]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%})"
