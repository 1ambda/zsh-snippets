# zsh-snippets

Persistent zsh-snippets based on [willghatch/zsh-snippets](https://github.com/willghatch/zsh-snippets)

- add, udpate, delete, list snippets
- supports auto-completion

![](https://github.com/1ambda/zsh-snippets/blob/master/images/usage_high.gif)

## Install: zplug

Setup aliases and widgets whihle binding keys with them

- `CTRL-S CTRL-S` expands the specified snippet
- `CTRL-S CTRL-A` lists existing snippets

```
# in .zshrc
zplug "1ambda/zsh-snippets"
alias zsp="zsh_snippets"
bindkey '^S^S' zsh-snippets-widget-expand  # CTRL-S CTRL-S (expand)
bindkey '^S^A' zsh-snippets-widget-list    # CTRL-S CTRL-A (list)
```

## Usage

All commands and snippets are auto-completed by stroking `tab` key

```
# add a `gj` snippet
$ zsp add gj "| grep java | grep -v grep"

# list snippets
# or type binded key `^s^a` (ctrl+s ctrl+a)
$ zsp list

# expand a snippet
# '!' means your current cursor in terminal, type your binded key `^s^s` (ctrl+s ctrl+s)
$ ps -ef gj!

# will be expanded into
$ ps -ef | grep java | grep -v grep

# delete a snippet
zsp delete gj
```

## Development

Load local zsh-snippets

```
// in .zshrc

zplug "$SOMEWHERE/zsh-snippets", from:local, use:'snippets.plugin.zsh'
```

## License

MIT



