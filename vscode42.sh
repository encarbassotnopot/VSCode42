#!/bin/sh

wget -O /tmp/code.tar.gz 'https://code.visualstudio.com/sha/download?build=stable&os=linux-x64'
mkdir -p ~/.local/share/vscode/
tar xvzf /tmp/code.tar.gz -C ~/.local/share/vscode/ --strip-components=1
mkdir -p ~/.local/share/icons/hicolor/
cp ~/.local/share/vscode/resources/app/out/media/code-icon.svg ~/.local/share/icons/hicolor/
grep -q '^export PATH=$PATH:$HOME/.local/share/vscode/' ~/.zshrc
if [ $? -eq 1 ]; then
	echo '# VSCode path' >> ~/.zshrc
	echo 'export PATH=$PATH:$HOME/.local/share/vscode/' >> ~/.zshrc
fi
cat <<EOF > $HOME/.local/share/applications/vscode.desktop
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=$HOME/.local/share/vscode/code %F
Icon=$HOME/.local/share/icons/hicolor/code-icon.svg
Type=Application
StartupNotify=false
StartupWMClass=vscode
Categories=TextEditor;Development;IDE;
MimeType=application/x-vscode-workspace;
Actions=new-empty-window;
Keywords=vscode;

[Desktop Action new-empty-window]
Name=New Empty Window
Name[de]=Neues leeres Fenster
Name[es]=Nueva ventana vacía
Name[fr]=Nouvelle fenêtre vide
Name[it]=Nuova finestra vuota
Name[ja]=新しい空のウィンドウ
Name[ko]=새 빈 창
Name[ru]=Новое пустое окно
Name[zh_CN]=新建空窗口
Name[zh_TW]=開新空視窗
Exec=$HOME/.local/share/vscode/code --new-window %F
Icon=$HOME/.local/share/icons/hicolor/code-icon.svg
EOF
