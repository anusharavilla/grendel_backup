################################################################################
#                                                                              #
#            .cshrc file (initial setup file for C-Shells)                     #
#                                                                              #
#  WARNING:  PLEASE READ THE REST OF THIS FILE BEFORE MAKING ANY CHANGES !!!   #
#                                                                              #
################################################################################

if (-d /usr/athena/lib/skeleton) then
	set skeleton=/usr/athena/lib/skeleton
else
	set skeleton=/afs/bp.ncsu.edu/system/common/skeleton
endif

if (-r $skeleton/cshrc) then
	source $skeleton/cshrc
else
	if ($?prompt) then
		echo "WARNING: System-wide initialization files were not found."
		echo "         C-Shell initialization has not been performed."
	endif
	set path = (/bin $HOME/bin /usr/local/bin /usr/bin/X11 /usr/athena/bin \
		    /usr/afsws/bin /usr/ucb /usr/bin .)
	limit coredumpsize 0
	set prompt="eos% "
	set ignoreeof
	umask 077
	alias rm rm -i
endif

if ($?XSESSION) then
    if (-r /usr/athena/bin/end_session) alias logout '/usr/athena/bin/end_session && exit '
    if (-r /usr/bin/end_session) alias logout '/usr/bin/end_session && exit '
endif

################################################################################
#                                                                              #
#     If you would like to modify any of these variables, please make          #
#     the changes in a file called .mycshrc located in the top level           #
#     of your home directory.                                                  #
#                                                                              #
#-----   HOW TO   C U S T O M I Z E   YOUR OWN   E N V I R O N M E N T   ------#
#                                                                              #
#  .mycshrc  This file is sourced by the system to override any default C      #
#            shell variables.  You can use the unset/unalias or set/alias      #
#            commands to customize your own C shell environment.               #
#                                                                              #
#  .xsession This file is invoked by the system to start up your own X11       #
#            session.  This shell script contains various X11 commands to      #
#            customize your initial layout (such as a clock, a bitmap for      #
#            your root window, several xterm with various sizes and fonts,     #
#            etc ...  Do not background your last process (i.e. do not put     #
#            an ambersand after it or else your session will be terminated.    #
#            This last process is used to "gate" your session.  When this      #
#            process exits, the session ends and you are logged out.  To       #
#            terminate this process, type 'logout' in an xterm window or       #
#            invoke the 'end_session' program.                                 #
#                                                                              #
#  .Xstartup This file contains additional X11 commands to customize your      #
#            window session.  This file is similar to the '.xsession' file     #
#            but the system invokes it only AFTER finishing its own set up.    #
#                                                                              #
#  WARNING:  Any changes in this file may disappear one day when the system    #
#            is updated!  Make sure you know what you are doing!!!             #
#                                                                              #
################################################################################
