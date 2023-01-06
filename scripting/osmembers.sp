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
    char name[64];
    char steamid[32];
    /* loop players and check database for user info */

    for ( int player = 1; player <= MaxClients; player++ ) {
        if ( playerIsReal ( player ) ) {
            GetClientName ( player, name, sizeof ( name ) );
            GetClientAuthId ( player, AuthId_Steam2, steamid, sizeof ( steamid ) );
            PrintToChat ( client, "Player: %S - SteamID: %s", name, steamid );
        }
    }

    return Plugin_Handled;
}

public bool playerIsReal ( int player ) {
    if ( IsClientInGame ( player ) && 
         ! IsFakeClient ( player ) &&
         ! IsClientSourceTV ( player ) ) {
        return true;
    }
    return false;
}


