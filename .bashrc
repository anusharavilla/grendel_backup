################################################################################
#                                                                              #
#            .bash_login file (terminal setup file)                            #
#                                                                              #
#  Note:  This file is only read when bash first starts.                       #
#                                                                              #
#  WARNING:  PLEASE READ THE REST OF THIS FILE BEFORE MAKING ANY CHANGES !!!   #
#                                                                              #
################################################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

################################################################################
#                                                                              #
#     If you would like to modify any of these variables, please make          #
#     the changes in a file called .mybashrc located in the top level          #
#     of your home directory.                                                  #
#                                                                              #
#-----   HOW TO   C U S T O M I Z E   YOUR OWN   E N V I R O N M E N T   ------#
#                                                                              #
#  .mybashrc This file is sourced by the system to override any default bash   #
#            shell variables.                                                  #
#                                                                              #
#  .xsession This file is invoked by the system to start up your own X11       #
#    - or -  session.  This shell script contains various X11 commands to      #
#  .Xclients customize your initial layout (such as a clock, a bitmap for      #
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

