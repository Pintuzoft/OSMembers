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
    ReplyToCommand ( client, "Members!!!^neven more members!!! :D" );
    return Plugin_Handled;
}
