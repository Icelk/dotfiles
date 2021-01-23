#
# ~/.profile
#

[[ -f ~/.aliases ]] && . ~/.aliases

[[ -f ~/.login ]] && . ~/.login

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
