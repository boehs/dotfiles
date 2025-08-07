#!/usr/bin/env nu
use std-rfc/kv *
job spawn {
    # Check if gpg-agent's socket exists
    let agent_socket = (gpgconf --list-dirs agent-socket | str trim)
    if not ($agent_socket | path exists) {
        gpgconf --launch gpg-agent
    }

    # Ensure the environment variable is set
    let ssh_auth_sock = (gpgconf --list-dirs agent-ssh-socket | str trim)
    if ($ssh_auth_sock | is-empty) {
        print "Failed to determine SSH_AUTH_SOCK."
    } else {
        kv set -u SSH_AUTH_SOCK $ssh_auth_sock
    }
}
