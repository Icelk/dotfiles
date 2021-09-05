#!/usr/bin/sh

echo "Will use doas. Edit the 'doas' variable in this script to use sudo instead."
doas="doas"

doas echo "Thanks!"

themes='pack_1/abstract_ring_alt
pack_1/circle
pack_3/lone
pack_1/angular_alt
pack_4/sphere
pack_2/hexagon_dots_alt
pack_4/rings_2'

root="https://github.com/adi1090x/files/raw/master/plymouth-themes/themes/"

set -e

for theme in $themes; do
    path="$root/$theme.tar.gz"
    theme_name="$(basename $theme)"
    name="$theme_name.tar.gz"
    curl -L $path -o $name
    tar -xf $name
    $doas chown -R root:root $theme_name
    $doas rm -rf "/usr/share/plymouth/themes/$theme_name"
    $doas mv $theme_name /usr/share/plymouth/themes/
    rm $name
done

echo
echo "Complete!"
echo "You can change the theme by using '# plymouth-set-default-theme -R <theme-name>'."
echo "Installed:"
for theme in $themes; do
    echo $(basename $theme)
done
