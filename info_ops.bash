# --------------------------------------------------
#
# Setup special invocation of info
#
# --------------------------------------------------

# Figure out an alias for info command because we need to use -d args to
# specify info directories. Tried using INFOPATH but it seems INFOPATH
# does not honor order in a predictable way.  And yes, I tried it,
# exaustively in all combinations.
#
# Order matters, later dirs override earlier dirs
t_infoDirs+=" /usr/local/opt/findutils/share/info"
t_infoDirs+=" /usr/share/info"
t_infoDirs+=" /Applications/Emacs.app/Contents/Resources/info"
t_infoDirs+=" ${HOME}/pkg/emacs-24.3/info"
t_infoDirs+=" /usr/local/opt/gettext/share/info"
t_infoDirs+=" /usr/local/opt/findutils/share/info"
t_infoDirs+=" /usr/local/share/info"
t_infoDirs+=" ${HOME}/dev/info"

for i in ${t_infoDirs}; do
    if [ -d $i ]; then
        t_infoDirsReal+=" -d $i"
    fi
done

if [ "${t_infoDirsReal}" != ""  ]; then
    alias info="command info ${t_infoDirsReal}"
fi
unset -v t_infoDirs
unset -v t_infoDirsReal
