#!/usr/bin/env zsh

# initialize snippet history file
SNIPPET_FILE=~/.zsh_snippets
typeset -Ag zshSnippetArr

ZSH_SNIPPETS_VERSION="0.0.1"
TAG="ZSH_SNIPPETS"

# init
if [ ! -e "$SNIPPET_FILE" ]; then
	$(which touch) $SNIPPET_FILE
	$(which chmod) +x $SNIPPET_FILE
	_clean_zsh_snippets
fi

# util functions

log_info() {
	local message; message=$1
	echo "[$TAG] INFO - $message"
}

## snippet related functions

_show_zsh_snippets_version() {
    echo $ZSH_SNIPPETS_VERSION
}

_show_zsh_snippets_file() {
	echo $SNIPPET_FILE
}

_clean_zsh_snippets() {
	zshSnippetArr=()
	# serialize current snippets to file
	typeset -p zshSnippetArr > $SNIPPET_FILE
}

_add_zsh_snippets() {
	if [ $# -lt 2 ]; then
		echo "Usage: _add_zsh_snippets <key> <value>"
		exit 1
	fi

	source $SNIPPET_FILE
	zshSnippetArr[$1]="$2"
    typeset -p zshSnippetArr > $SNIPPET_FILE
}

_delete_zsh_snippets() {
	if [ $# -lt 1 ]; then
		echo "Usage: _delete_zsh_snippets <key> <value>"
		exit 1
	fi

	source $SNIPPET_FILE
	unset zshSnippetArr[$1]
    typeset -p zshSnippetArr > $SNIPPET_FILE
}

_list_zsh_snippets() {
	source $SNIPPET_FILE
	local snippetList="$(print -a -C 2 ${(kv)zshSnippetArr})"

	echo "$snippetList"
}

zsh-snippets-widget-list() {
	source $SNIPPET_FILE
	local snippetList="$(print -a -C 2 ${(kv)zshSnippetArr})"
	zle -M "$snippetList"
}
zle -N zsh-snippets-widget-list

zsh-snippets-widget-expand() {
    emulate -L zsh
    setopt extendedglob
    local MATCH

	# _read_zsh_snippets
	source $SNIPPET_FILE

    # http://stackoverflow.com/questions/20832433/what-does-lbufferm-a-za-z0-9-do-in-zsh
    LBUFFER=${LBUFFER%%(#m)[.\-+:|_a-zA-Z0-9]#}
    LBUFFER+=${zshSnippetArr[$MATCH]:-$MATCH}

	zle -M "" # clean screen after snippet expansion
}
zle -N zsh-snippets-widget-expand

# command handler
zsh_snippets() {
	if [ $# -lt 1 ]; then
		echo "Usage: $0 [add|delete|list]"
	else
		local cmd; cmd=$1
		local shortcut; shortcut=$2
		local snippet; snippet=$3

		case $cmd in
			add)
				_add_zsh_snippets $shortcut $snippet
				log_info "'$shortcut' snippet is added"
				;;
			delete)
				_delete_zsh_snippets $shortcut
				log_info "'$shortcut' snippet is deleted"
				;;
			list)
				_list_zsh_snippets
				;;
		esac
	fi

}

# add completion file to fpath
fpath+="`dirname $0`"
