#include <sourcemod>
#include <sdktools>
#include <cstrike>


public Plugin myinfo = {
	name = "OSMembers",
	author = "Pintuz",
	description = "OldSwedes Members plugin",
	version = "0.01",
	url = "https://github.com/Pintuzoft/OSMembers"
}

public void OnPluginStart ( ) {
	RegConsoleCmd ( "sm_members", Command_Members );
}

public Action Command_Members ( int client, int args ) {
    ReplyToCommand ( client, "Members!!! \n even more members ^n even more members \r even more members ^r even more members" );

    /* print several lines to chat */

    


    return Plugin_Handled;
}
