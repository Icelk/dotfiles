if status --is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        # ↓ Very bad!
        sleep 1
        exec startx -- -keeptty
    end
end

if status --is-interactive
    set fish_greeting

    starship init fish | source
    
    source ~/.aliases
end


function on_exit --on-event fish_exit
    # Now logging out!
end

function fish_user_key_bindings
    bind \cH backward-kill-path-component
end
