if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

if status --is-interactive
    set fish_greeting

    set -px PATH ~/.cargo/bin ~/dev/Rust/Kvarn/target/release ~/dev/Rust/osxcross/target/bin ~/.local/bin

    starship init fish | source
    
    source ~/.aliases
end


function on_exit --on-event fish_exit
    # Now logging out!
end

function ps
    paru -Ss --color=always $argv[1] | $PAGER
end

function pu
    paru

    set diff (echo "q" | pacdiff)

    if test -n "$diff"
        doas pacdiff
    end
end

function fish_user_key_bindings
    bind \cH backward-kill-word
end
