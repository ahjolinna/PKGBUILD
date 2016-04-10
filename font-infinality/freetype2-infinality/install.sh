post_install() {
	cat <<- EOF
                ==>If you have been using freetype2-infinality from the CCR,
                the runtime file that came with it has been saved as
                /etc/X11/xinit/xinitrc.d/infinality-settings.pacsave and the new
                one was installed in its place. You can manually delete
                infinality-settings.sh.pacsave as it is not needed anymore.

                ==>If you are using [multilib], please install/upgrade
                lib32-freetype2-infinality, too.
                
		==> Infinality environment variables are located in the file /etc/profile.d/infinality-settings.sh. Change it according to your taste.
		
		==> Fontconfig files have moved to fontconfig-infinality package which should be installed and configured separately.
		
		==> For best experience, install either Windows, Apple or Google fonts.	More information is available at http://www.infinality.net.
	EOF
}

post_upgrade() {
  post_install
}

post_remove() {
  cat << EOF
  freetype2-infinality was removed.
EOF
}
