#!/usr/bin/env nu

# detect the current operating system by matching over `sys host`'s name field

let os = match (sys host | get name) {
  Darwin => "mac",
  linux => "linux",
  windows => "windows",
  _ => "unknown"
}

let mappings = {
  "shell/nushell": {
    "mac": "~/Library/Application Support/nushell",
    "excludes": [history.txt, plugin.msgpackz]
  },
  "shell/ghostty": {
    "mac": "~/.config/ghostty/",
  },
  "code/nvim": {
    "mac": '~/.config/nvim/',
  },
  "shell/atuin.toml": {
    "mac": '~/.config/atuin/config.toml',
  },
  "shell/mise.toml": {
    "mac": '~/.config/mise/config.toml',
  },
}

def "main restore" [] {
  print "Restoring files"
  $mappings | items { |local,v|
    let foreign = $v | get $os
    if $foreign != null {
      let local_path = $'./($local)' | path expand
      mut foreign_path = $foreign | path expand
      if ($local_path | path type) == "dir" and ($local_path | path basename) == ($foreign_path | path basename) {
        $foreign_path = ($foreign_path | path dirname)
      }
      print $'restoring ($local_path) to ($foreign_path)'
      cp -r $local_path $foreign_path
    }
  }
}

def "main backup" [] {
  print "Backing up files"
  $mappings | items { |local,v|
    let foreign = $v | get -i $os
    if $foreign == null {
      return "error: foreign path not found"
    }
    mut local_path = $'./($local)' | path expand
    let unexpanded_local_path = $local_path
    let foreign_path = $foreign | path expand
    # if both paths are directories with the same name, remove the last part of the path so its not /dir/dir/
    if ($foreign_path | path type) == "dir" and ($local_path | path basename) == ($foreign_path | path basename) {
      $local_path = ($local_path | path dirname)
    }
    print $'backing up ($foreign_path) to ($local_path)'
    cp -r $foreign_path $local_path
    # for each path in excludes, remove it from the local path
    let excludes = $v | get -i excludes
    if $excludes != null {
      for $exclude in $excludes {
        let exclude_path = $unexpanded_local_path | path join $exclude
        if ($exclude_path | path exists) {
          rm -r $exclude_path
        }
      }
    }
    return "ok"
  }
}

def "main" [] {
  print "Please provide a subcommand: restore, backup"
}
