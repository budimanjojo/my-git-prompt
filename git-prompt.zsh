autoload -U colors && colors                    # enable colors in prompt
setopt promptsubst                              # enable function in prompt

## The symbols and color, modify to your liking
#_background_color="%{$bg[white]%}"
_branch_name_prefix_symbol="%{$fg[yellow]%}["
_branch_name_suffix_symbol="%{$fg[yellow]%}]"
_has_modifications_symbol="%{$fg[red]%}✎  " 
_has_modifications_cached_symbol="%{$fg[green]%}✍  "
_has_adds_symbol="%{$fg[green]%}✚  "
_has_deletions_symbol="%{$fg[red]%}✖  "
_has_deletions_cached_symbol="%{$fg[green]%}▬  "
_ready_to_commit_symbol="%{$fg[green]%}☻   "
_has_untracked_files_symbol="%{$fg[red]%}✭  "
_is_clean_symbol="%{$fg[green]%}✔ "
_is_dirty_symbol="%{$fg[red]%}✘ "
_enable_right_return_status=yes
_return_status_color="%{$fg[red]%}"
_enable_right_date=no
# colors
_commits_ahead_color="%{$fg[green]%}"
_commits_behind_color="%{$fg[green]%}"
_date_color="%{$fg[green]%}"

## Check if git is dirty or clean
function show_git_prompt() {
  # check if it is a git repository
  local check_is_git="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
  if [[ $check_is_git == "true" ]]; then
    local is_a_git_repo=true; fi
  if [[ $is_a_git_repo == true ]]; then
  local prompt="${_background_color}"
  local git_status="$(git status --porcelain 2> /dev/null)"
  local current_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  local upstream="$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)"
  if [[ $git_status =~ ($'\n'|^).M ]]; then prompt+="${_has_modifications_symbol}"; fi
  if [[ $git_status =~ ($'\n'|^)M ]]; then prompt+="${_has_modifications_cached_symbol}"; fi
  if [[ $git_status =~ ($'\n'|^)A ]]; then prompt+="${_has_adds_symbol}"; fi
  if [[ $git_status =~ ($'\n'|^).D ]]; then prompt+="${_has_deletions_symbol}"; fi
  if [[ $git_status =~ ($'\n'|^)D ]]; then prompt+="${_has_deletions_cached_symbol}"; fi
  if [[ $git_status =~ ($'\n'|^)[MAD] && ! $git_status =~ ($'\n'|^).[MAD\?] ]]; then prompt+="${_ready_to_commit_symbol}"; fi
  if [[ $(\grep -c "^??" <<< $git_status) -gt 0 ]]; then prompt+="${_has_untracked_files_symbol}";fi
  local commits_diff="$(git log --pretty=oneline --topo-order --left-right ${git_status}...${upstream} 2> /dev/null)"
  local commits_ahead="$(git log --oneline ${upstream}.. 2> /dev/null | wc -l | tr -d ' ')"
  local commits_behind="$(git log --oneline ..${upstream} 2> /dev/null | wc -l | tr -d ' ')"
  if [[ $commits_behind -gt 0 ]]; then
    prompt+="${_commits_behind_color}← ${commits_behind} "
  else
    prompt+="%{$fg[red]%}← _ ";
    if [[ $commits_ahead -gt 0 ]]; then
      prompt+="${_commits_ahead_color}${commits_ahead}→ ";
    else
      prompt+="%{$fg[red]%}_→  "
    fi
  fi
  prompt+="$_branch_name_prefix_symbol""${current_branch}""${_branch_name_suffix_symbol} "
  local clean_or_dirty="$(git diff --shortstat 2> /dev/null | tail -n1)"
  if [[ -n ${clean_or_dirty} ]]; then
    prompt+="${_is_dirty_symbol}"
  else
    prompt+="${_is_clean_symbol}";
  fi
  prompt+=%{$reset_color%}
  echo -n "${prompt}"
else
  prompt="$(right_date)"
  echo -n "${prompt}"
fi
}

_newline=$'\n'
_lineup=$'\e[1A'
_linedown=$'\e[1B'

function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

function right_date() {
  if [[ ${_enable_right_date} == "yes" ]]; then
    echo "${_date_color}%D{%a,%d %b %y}"
  fi
}

function right_return_code() {
  if [[ ${_enable_right_return_status} == "yes" ]]; then
    echo "${_return_status_color} %?↵ "
  fi
}

PROMPT='${_background_color}${fg[green]%}╭─%n@%{$fg[yellow]%}%M %{$fg[red]%}%~${_newline}%}%{$fg[green]%}╰─$(prompt_char) %{$reset_color%}'

RPROMPT='%{${_lineup}%}$(show_git_prompt)$(right_return_code)%{${_linedown}%}%{$reset_color%}'
