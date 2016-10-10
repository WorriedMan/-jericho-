******************************************
*					 *
*    Resource:   bank			 *
*    Version:    2.3			 *
*					 *
*    Made by:    50p			 *
*					 *
******************************************

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

1. Short Description
2. Installation
3. Events
 3.I) How they work?
 3.II) Little example
4. Exported functions
5. About me / Contact
6. Licence

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

----------------------------
1. Short Description
----------------------------

Bank resource was the first bank system
for MTA:SA DM. It wasn't good at the
beggining because it used a function that
wiped all the accounts from accounts.xml.
I decided to use SQL database instead.
After that people started downloading it
and liked it very much. When MTA:SA 1.0
was released, bank stopped working.
I had to rewrite lots of code due to
outdated functions.

Since 2.2, players' bank balance gets
saved into MTA's built-in account system.
Yes, again, because that system works now.

==========================================

----------------------------
2. Installation
----------------------------

Just copy&paste bank.zip (which you
downloaded) into <MTA SERVER>\resources\
folder (where MTA SERVER is folder of the
server)
If your server was running at the time of
installation, just type: refresh
in console or /refresh in chat box. Of
course you must be logged in as admin to
use these commands.

==========================================

----------------------------
3. Events
----------------------------

If you would like to add something to the
resource you can make a new resource and
manage bank from there because MTA gave
us possibility to add custom events. I
took advantage of it and it works great.
There are 5 working events and 2 in WIP
state which aren't triggered at all.
Here is a list of them 5:
- onPlayerWithdrawMoney
- onPlayerDepositMoney
- onPlayerTransferMoney
- onPlayerEnterBank
- onPlayerLeaveBank

---------------------
3.I) How they work?
---------------------

It's as simple as other events. You just
attach a function (handler) which is
called when an event occures.

NOTE: Full documentation will be
available on MTA wiki, not sure when.

--------------------
3.II) Little example
--------------------

This example shows how to tell the player
that he entered ATM.

addEventHandler( "onPlayerEnterBank", getRootElement(),
    function( bankMarker, atm )
        if atm then
            outputChatBox( "You entered ATM", source )
        end
    end
)

==========================================

-----------------------------
4. Exported functions
-----------------------------

To allow scripters extend the bank system
they can use exported functions. There are
couple of functions which may come handy.
Here is a list of them all:
- getBankID
- getBankPosition
- getBankMarker
- getBankName
- getBankMarkers
- getBankEntranceMarker
- getBankExitMarker
- countBanks
- getBankAccountBalance
- setBankAccountBalance
- getPlayersInBank
- getPlayerBank
- withdrawPlayerMoney
- depositPlayerMoney
- isPlayerInBank
- getPlayerBalance
- setPlayerBalance

NOTE: Full documentation will be
available on MTA wiki, not sure when.

==========================================

-----------------------------
5. About me
-----------------------------

I've been scripting for MTA since its
release. I'm self-learner and know other
languages. Do you want to know more?
You can get in touch with me over PM on
MTA forums:
http://forum.mtasa.com/memberlist.php?mode=viewprofile&u=19953

==========================================

-----------------------------
6. Licence
-----------------------------

This work is licensed under the Creative 
Commons Attribution-Non-Commercial 2.0 
UK: England & Wales License. 
To view a copy of this license, visit:
http://creativecommons.org/licenses/by-nc/2.0/uk/

NO WARRANTY
THE SOFTWARE IS DISTRIBUTED IN THE HOPE THAT IT WILL BE USEFUL,
BUT WITHOUT ANY WARRANTY. IT IS PROVIDED "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT 
NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND 
FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE 
QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH YOU. SHOULD THE
SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY 
SERVICING, REPAIR OR CORRECTION.