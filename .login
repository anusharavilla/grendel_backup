################################################################################
#                                                                              #
#            .login file (terminal setup file)                                 #
#                                                                              #
#  Note:  This file is only read once after the .cshrc file when log in.       #
#         It will not be read again for subsequent shells.                     #
#                                                                              #
#  WARNING:  PLEASE READ THE REST OF THIS FILE BEFORE MAKING ANY CHANGES !!!   #
#                                                                              #
################################################################################

if (-d /usr/athena/lib/skeleton) then
	set skeleton=/usr/athena/lib/skeleton
else
	set skeleton=/afs/bp.ncsu.edu/system/common/skeleton
endif

if (-r $skeleton/login) then
	source $skeleton/login
else
	if ($?prompt) then
		echo "WARNING: System-wide initialization files were not found."
		echo "         Login initialization has not been performed."
	endif
	stty dec
	switch ($term)
	case xterm:
		setenv DISPLAY unix:0
		set noglob; unsetenv TERMCAP; eval `resize`; unset noglob
		breaksw
	default:
		set term=vt100
		setenv TERMCAP /etc/termcap
		breaksw
	endsw
	setenv TERM $term
endif

################################################################################
#                                                                              #
#     If you would like to modify the login initialization sequence, please    #
#     make the changes in a file called .mylogin located in the top level      #
#     of your home directory.  Your ~/.mylogin file is used only to set up     #
#     your terminal type.  For other customizations, please refer to the       #
#     comments in your default ~/.cshrc.                                       #
#                                                                              #
#  WARNING:  Any changes in this file may disappear one day when the system    #
#            is updated!  Make sure you know what you are doing!!!             #
#                                                                              #
################################################################################
