#pragma semicolon 1

#include <sourcemod>
#include <vip_core>
#include <NCIncs/nc_rpg>

public Plugin myinfo =
{
	name = "[VIP] [NCRPG] Exp Multiplier",
	author = "R1KO",
	version = "1.0"
};

static const char g_szFeature[] = "NCRPGExpMultiplier";

public void OnPluginStart()
{
	if(VIP_IsVIPLoaded())
	{
		VIP_OnVIPLoaded();
	}
}

public void OnPluginEnd()
{
	if(CanTestFeatures() && GetFeatureStatus(FeatureType_Native, "VIP_UnregisterFeature") == FeatureStatus_Available)
	{
		VIP_UnregisterFeature(g_szFeature);
	}
}

public void VIP_OnVIPLoaded()
{
	VIP_RegisterFeature(g_szFeature, FLOAT, HIDE);
}

public Action NCRPG_OnPlayerGiveExpPre(int iClient, int &iExperience, char[] szEvent)
{
	if(VIP_IsClientVIP(iClient) && VIP_IsClientFeatureUse(iClient, g_szFeature))
	{
		float fMultiplier = VIP_GetClientFeatureFloat(iClient, g_szFeature);
		if(fMultiplier)
		{
			iExperience = RoundToCeil(float(iExperience)*fMultiplier);
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}
