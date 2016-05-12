# Yay! High voltage and arrows!

prompt_setup_ebvalaim(){
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
  ZSH_THEME_VIRTUALENV_PREFIX="("
  ZSH_THEME_VIRTUALENV_SUFFIX=")"

  base_prompt='[%{$fg[magenta]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%} %{$fg[cyan]%}%0~%{$reset_color%}]%{$reset_color%}'
  post_prompt='%{$fg[cyan]%}$%{$reset_color%} '

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_ebvalaim_precmd)
}

prompt_ebvalaim_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local venvinfo=$(virtualenv_prompt_info)
  local venvinfo_nocolor=$(echo "$venvinfo" | perl -pe "s/%\{[^}]+\}//g")
  local exp_nocolor="$(print -P \"$venvinfo_nocolor$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
  local prompt_length=${#exp_nocolor}

  local nl=""

  if [[ $prompt_length -gt 40 ]]; then
    nl=$'\n%{\r%}';
  fi
  if [[ ${#gitinfo} -gt 0 ]]; then
    gitinfo=" ($gitinfo)";
  fi
  PROMPT="$venvinfo$base_prompt$gitinfo$nl$post_prompt"
}

prompt_setup_ebvalaim


