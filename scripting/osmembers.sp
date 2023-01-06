#include <sourcemod>
#include <sdktools>
#include <cstrike>

char error[255];
char memberName[64];
Database members;

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
public void OnMapStart ( ) {
    checkConnection ( );
}

public Action Command_Members ( int client, int args ) {
    printMembers ( client );
    return Plugin_Handled;
}

public void checkConnection ( ) {
    if ( members == null || members == INVALID_HANDLE ) {
        databaseConnect ( );
    }
}
public void databaseConnect ( ) {
    if ( ( members = SQL_Connect ( "members", true, error, sizeof(error) ) ) != null ) {
        PrintToServer ( "[OSMembers]: Connected to members database!" );
    } else {
        PrintToServer ( "[OSMembers]: Failed to connect to members database! (error: %s)", error );
    }
}

public void printMembers ( int client ) {
    char playerName[64];
    char steamid[32];
    PrintToChat ( client, " \x04Members:" );
    for ( int player = 1; player <= MaxClients; player++ ) {
        if ( playerIsReal ( player ) ) {
            GetClientName ( player, playerName, sizeof(playerName) );
            GetClientAuthId ( player, AuthId_Steam2, steamid, sizeof(steamid) );
            fetchMember ( steamid );
            if ( strcmp ( memberName, "-" ) != 0 ) {
                PrintToChat ( client, " \x05- %s is recognized as member: %s", playerName, memberName );
                continue;
            } else {
                PrintToChat ( client, " \x05- %s is not a member", playerName );
                continue;
            }
        }
    }
}

public void fetchMember ( char steamid[32] ) {
    char query[255];
    DBStatement stmt;
    query = "SELECT name FROM user WHERE steamid = ?";

    if ( ( stmt = SQL_PrepareQuery ( members, query, error, sizeof(error) ) ) == null ) {
        SQL_GetError ( members, error, sizeof(error) );
        PrintToServer("[OSMembers]: Failed to prepare query[0x01] (error: %s)", error);
        Format ( memberName, sizeof(memberName), "-" );
    }

    SQL_BindParamString ( stmt, 0, steamid, false );

    if ( ! SQL_Execute ( stmt ) ) {
        SQL_GetError ( members, error, sizeof(error));
        PrintToServer("[OSMembers]: Failed to query[0x02] (error: %s)", error);
        Format ( memberName, sizeof(memberName), "-" );
    }

    if ( SQL_FetchRow ( stmt ) ) {
        SQL_FetchString ( stmt, 0, memberName, sizeof(memberName) );
    } else {
        Format ( memberName, sizeof(memberName), "-" );
    }
}

public bool playerIsReal ( int player ) {
    if ( IsClientInGame ( player ) && 
         ! IsFakeClient ( player ) &&
         ! IsClientSourceTV ( player ) ) {
        return true;
    }
    return false;
}


