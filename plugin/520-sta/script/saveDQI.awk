#!/usr/bin/awk -f
BEGIN {
  print "Exporting DQI value to DVC system"
}
{
   if ($1 != "") {
      system("dqr_set_dqi "$1" "$2)
   }
}
END {
}
