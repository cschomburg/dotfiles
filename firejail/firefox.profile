# Firejail profile for Mozilla Firefox (Iceweasel in Debian)
whitelist ${HOME}/.mozilla
whitelist ${HOME}/.cache/mozilla
whitelist ${HOME}/downloads
blacklist /media
include /etc/firejail/firefox.profile
