 sudo dnf remove --oldinstallonly -y > /dev/null 2>&1
 val=$(sudo grubby --info=ALL | gawk 'match($0, /kernel="\/boot\/vmlinuz-0-rescue-([A-z_0-9]*)["]/, ary) {print ary[1]}')
 sudo grubby --remove-kernel=/boot/vmlinuz-0-rescue-$val > /dev/null 2>&1
