#!/bin/csh -f
#set verbose = 1
set prog = $0:t
if (($1 == "-h") || ($1 == "--help")) then
   echo "Usage: $prog [--server|--local] [--all] <variable>"
   exit -1
endif

if ($?SVN_ROOT == 0) then
   if {(test -e .dop/env/SVN_ROOT)} then
      setenv SVN_ROOT  `cat .dop/env/SVN_ROOT`
   else
      setenv SVN_ROOT  $HOME/SVN_ROOT
   endif
endif

if ($1 == "--root") then
   shift argv
   set env_home=$1
   shift argv
else if ($1 == "--server") then
   shift argv
   set env_home=$SVN_ROOT
else if ($1 == "--local") then
   shift argv
   set env_home=$PWD
else
   set env_home=.
endif

if ($1 == "--script") then
   set script_mode=1
   shift argv
else if ($1 == "--csv") then
   set csv_mode=1
   shift argv
else if ($1 == "--tcl") then
   set tcl_mode=1
   shift argv
endif

if ($1 == "--all") then
   shift argv
   set env_list = `(cd $env_home/.dop/env/; ls -a . )`
   set script_mode=1
else
   set env_list=""
   while ($1 != "")
      set env_list =($env_list $1)
      shift argv
   endif
endif

if {(test -d $env_home/.dop/env/)} then
   foreach env_name ( $env_list )
      set fname=$env_home/.dop/env/$env_name
      if {(test -f $fname)} then
         if ($?script_mode) then
            echo "$env_name = `cat $fname`"
         else if ($?csv_mode) then
            echo "$env_name `cat $fname`"
         else if ($?tcl_mode) then
            echo "set env($env_name) {`cat $fname`}"
         else
            echo `cat $fname`
         endif
      endif
   end
else
   echo "ERROR: '$env_home' is not a valid working directory!"
   exit 1
endif

exit 0
