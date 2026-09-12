#!/system/bin/busybox sh

MODPATH="${0%/*}"

# Using util_functions.sh
[ -f "$MODPATH/util_functions.sh" ] && . "$MODPATH/util_functions.sh" || abort "! util_functions.sh not found!"

# Periodically hexpatch delete custom ROM props (read targets from file)
TARGETS_FILE="$MODPATH/hexpatch_targets.list"
if [ -f "$TARGETS_FILE" ]; then
  set --
  while IFS= read -r line; do
    line=$(echo "$line" | sed 's/#.*//' | tr -d '[:space:]')
    [ -n "\( line" ] && set -- " \)@" "$line"
  done < "$TARGETS_FILE"
  [ \( # -gt 0 ] && hexpatch_deleteprop " \)@"
fi
