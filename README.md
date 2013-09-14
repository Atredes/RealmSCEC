## RealmSCEC
######This script was written by lazy person for lazy people. You might not be lazy enough to see why it would be useful
#### Features: #
*   Change server with one click
*   Call for event with one click


RealmSCEC knows what realm and server you are in.     
This means you can use predefined messages in which you include your current location making calling your mates for events even faster.
#### How to run it#
It's written in [AHK](http://www.autohotkey.com/) this means you need to have Autohotkey installed in order to use it or to compile the code. You can also ask your friend who have Autohotkey already installed to compile it for you. This way you wont have to install anything.    
**Why I wont compile it myself** and provide you with `.exe` along with the source code? I believe you shouldn't trust `.exe` files from unknown sources, I want to make sure that you know what you are using before you use it.   

**Will work:**
With browsers (including kong), flash projectors, Steam.    
**WONT work:**
With resized (zoomed in/out) game window, fullscreen whether stretched (there are people like that...) or not (not supported at all)   
######Note: "wont work" simply means it doesn't work now, in the state as it is. It's simple enough to make it work at any setup. Contribute.
 

#### How it works? #
The best way to find out is just to read the code and [AHK documentation](http://www.autohotkey.com/docs/).   
Short version? It clicks faster than you do. 
* *How it knows what server I'm in?* It knows what server you are in because you **joined this server using this script**.    
Event callouts **wont work properly** if you change servers manually.   
* *Ok that's good to know, but how it knows what realm I'm in?*  It checks the name on the portal when you enter the realm. Just like you do.        
 
######It does not interfere in game client.


#### How to use it #
There are few ways of changing servers and using event callouts:
* Using main GUI that is displayed once you run the program
* Using ingame GUI that is visible while you hold down specified key or combination of keys
* Using ingame menu list that is displayed once you press specified key or combination of keys
* Using custom commands (only for server changing)

#### How to add custom callouts#
Edit `callouts.ini`    
First word is callout name that will be used on button or menu item and after `=` sign is the message your intent to send.    
Use `$server` and `$realm` pseudo variables that will be then replaced respectively with your current server and realm.   
This means `Sphinx=/g $server $realm Sphinx!` will produce button 'Sphinx' that once pressed will send guild message `AfricaSouthWest Urgle Sphinx!` if you happen to be in said server and realm.
#### How to add custom icons for callouts#
In `events` folder include `.png` file using the same name you used in `callouts.ini`.      
This way `sphinx.png` becomes icon for `Sphinx=/g $server $realm Sphinx!` callout.






