## RealmSCEC #

###### Features: #
*   Change server with one click
*   Call for event with one click

RealmSCEC knows what realm and server you are in!    
This means you can use predefined messages in which you include your current location making calling your mates for events even faster.
#### How to run it#
It's written in [AHK](http://www.autohotkey.com/) this means you need to have Autohotkey installed in order to use it or to compile the code. You can also ask your friend that have Autohotkey already installed to compile it for you. This way you wont have to install anything.    
Why I wont compile it myself and provide you with `.exe` along with the source code? I belive you shouldn't trust `.exe` files from unknown sources, I want to make sure that you know what you are using before you use it.

#### How to use it #
###### Changing servers #
There are few ways of changing servers:
*

#### How to add custom callouts#
Edit `callouts.ini` where first word is callout name that will be used on button or menu item and after `=` sign is the message your intet to send.    
Use `$server` and `$realm` pseudo variables that will be then replaced with respectively your current server and realm.   
This means `Sphinx=/g $server $realm Sphinx!` will produce button 'Sphinx' that once pressed will send guild message `AfricaSouthWest Urgle Sphinx!` if you happen to be in said server and realm.





