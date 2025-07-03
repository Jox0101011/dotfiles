echo "Hi user !"
sleep 1
echo "welcome to my dotfiles"
echo "lets go?"
echo "moving kitty config in 5 seconds; cancel?..."
git clone https://github.com/dexpota/kitty-themes/tree/master/themes kitty/kitty-themes
sleep 2
mv kitty "$HOME"/.config/kitty
echo "moving in 5 seconds vim & nvim; cancel?..."
sleep 5
mv vim-\&-nvim/vim/vimrc "$HOME"/.vimrc
mv vim-\&-nvim/vim/vim "$HOME"/.vim
echo "Moved with sucess."
sleep 2
echo "Installing packages pacman!...cancel?"
packages/./strap.sh
sudo cat packages/packages_pacman.txt | sudo pacman -S
sleep 5
echo "Installing yay packages...cancel?"
yay -S --needed - <packages/packages_yay.txt
echo "xfce4..; make it"
