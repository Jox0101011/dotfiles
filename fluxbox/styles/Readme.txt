Hi there,

Here are just a few words to explain how to use this style, and especially change the colour of the titlebars and buttons so that they fit your background picture and icons theme. Or this is at least how I conceived this style to be used.

It's actually very simple. To change the colour of the titlebar you just need to replace the file /pixmaps/titlefcs.xpm. To change the colours of the buttons you need to specify a few variables in these executable files in the script folder: button_border, colorize_buttons, create_pixmaps. These files are commented for easier use and need ImageMagick to work. The scripts in the pebbles-ambiance folder put the buttons on the bottom of the titlebar, this is for gtk themes where the menu has the same coulour than the titlebar (it doen't look very good when a window is "shaded" though because then the menu disappears but well...) and the scripts in the pebbles-cook folder put the buttons vertically centered on the titlebar.

In my ~/.fluxbox/init file I've got the following:

session.screen0.titlebar.right:	Close 
session.screen0.titlebar.left:	Minimize Maximize Shade Stick 

I don't like buttons everywhere on the titlebars so the "Minimize" button is made transparent, and the "Stick" button is only visible when in the "Stuck" state (IMHO that is usefull to see).

Now about the colours. I give the "Close" button (which is isolated on the right to avoid clicking on it by mistake) a gradient of a colour on the top right of the wallpaper (picked with gcolor2), and the buttons on the left are a gradient of a colour in the icons theme I use.

To finish just a few general considerations: in Linux you should never run on your system scripts downloaded on the internet from unknow sources and without undestanding what they do, especially if they require you to give your administrator password. I suggest you read and try to understand what these 3 scripts are doing, ImageMagick is a great picture manipulator ! Anyway of course you don't need to be root to use this, all I do is to modify (mogrify in the ImageMagick language) the pixmaps in the style folder.

"It always looks better when you've made it yourself". Making styles for Fluxbox is very easy, so if you don't find what you're looking for just do like I did: just do it!

Enjoy and take care,
Thierry, Vienna, Austria.

Update 21.2.2011:

In the bonus-material you will find the following:

* a folder .colours with 12 colour schemes for the terminal
* my .Xresources file (always a work in progress but you might pick something useful for you there)
* in the .fluxbox folder all the icons I use in the menu (19x19)
* ... and the menu-colours file I [include] to change the terminal colour scheme from the menu
* the fonts for the toolbar (Birds of a Feather, gives a feeling of lightness and freedom) and the menu title
* a small script to replace the menu title with the date (should also work with cron). Just use it like this: script-name /path/to/menu/file (use a test file first and change the date format to your liking)
* the small scripts to change the terminal colour scheme from the menu. A small arrow in the menu then shows the scheme used.

In the Winter I can't work in the garden...

