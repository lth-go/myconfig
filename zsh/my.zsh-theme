function is_proxy {
  local env_http_proxy="${http_proxy:-}"
  local env_https_proxy="${https_proxy:-}"

  if [[ -n $env_http_proxy ]] || [[ -n $env_https_proxy ]]; then
    echo -n "%{$fg_bold[red]%} "
  fi
}

local ret_status="%(?:%{$fg_bold[blue]%}>> :%{$fg_bold[red]%}>> )"
PROMPT='${ret_status}$(is_proxy)%{$reset_color%}%{$fg[green]%}%~%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$fg[yellow]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%})"
