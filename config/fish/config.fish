if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec scripts/wayland.sh
    end
end

if status --is-interactive
    set fish_greeting

    set -px PATH ~/.cargo/bin ~/dev/Rust/osxcross/target/bin ~/.local/bin
    set -px PYTHONSTARTUP ~/.config/python/startup.py

    bind \cb "bg"

    # Fix https://github.com/mozilla/sccache/issues/837
    SCCACHE_IDLE_TIMEOUT=0 sccache --start-server &> /dev/null
    
    source ~/.aliases
end

if status --is-interactive && ! status --is-login
    starship init fish | source
end

function on_exit --on-event fish_exit
    # Now logging out!
end

function ps
    paru -Ss --color=always $argv[1] | $PAGER
end

function pu
    paru -Suy --removemake

    set diff (echo "q" | pacdiff)

    if test -n "$diff"
        doas pacdiff
    end
end

function gds
    git diff --stat --stat-width (tput cols) --color=always $argv | cat
end

function fish_user_key_bindings
    bind \cH backward-kill-word
end

function sshp
    while true
        ssh -TND 41523 icelk.dev
        sleep 2
    end
end
