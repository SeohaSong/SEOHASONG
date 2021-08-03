pip install browser_cookie3 > /dev/null 

dbus-run-session -- bash << STDIN


rm -r ~/.local/share/keyrings 2> /dev/null
yes | gnome-keyring-daemon --unlock > /dev/null

browser_storage=~/.config/chromium
rm -r \$browser_storage 2> /dev/null
chromium-browser\
 --headless --disable-gpu --dump-dom --password-store=gnome\
 --user-data-dir=\$browser_storage\
 https://www.naver.com/\
 > log.html 2> /dev/null


python3 << STDIN_

print("===============================")
import keyring
for item in keyring.get_keyring().get_preferred_collection().get_all_items():
    print("-------------------------------")
    print(item.get_label())
    print(item.get_attributes())

print("===============================")
import browser_cookie3
for cookie in browser_cookie3.chromium(domain_name='.naver.com'):
    print("-------------------------------")
    print(cookie)

STDIN_


rm -r ~/.cache/keyring-* 2> /dev/null

STDIN
