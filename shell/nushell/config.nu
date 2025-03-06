$env.path ++= ["/opt/homebrew/bin"]
$env.path ++= ["~/.cargo/bin"]
$env.path ++= ["~/Library/Python/3.9/bin"]

$env.config.show_banner = false

# we love vim
$env.config.buffer_editor = "vim"
$env.config.edit_mode = 'vi'

source ./prompt.nu

# plugins
source ~/.local/share/atuin/init.nu
use ($nu.default-config-dir | path join mise.nu)
let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force
source ./zoxide.nu

# carapace
def --env get-env [name] { $env | get $name }
def --env set-env [name, value] { load-env { $name: $value } }
def --env unset-env [name] { hide-env $name }
let carapace_completer = {|spans|
  # if the current command is an alias, get it's expansion
  let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)

  # overwrite
  let spans = (if $expanded_alias != null  {
    # put the first word of the expanded alias first in the span
    $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
  } else {
    $spans | skip 1 | prepend ($spans.0)
  })

  carapace $spans.0 nushell ...$spans
  | from json
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let multiple_completers = {|spans|
    match $spans.0 {
        z => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: $multiple_completers
}
