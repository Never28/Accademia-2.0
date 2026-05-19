#include "NW_I0_GENERIC"

void main()
{
    object oMinion = OBJECT_SELF;
    string sTag = GetTag(oMinion);
    string sFactionMin = GetSubString(sTag,10,3);
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC)==TRUE){
        string sTotale = GetLocalString(oPC,"gilda");
        string sFaction = GetSubString(sTotale,3,3);
        if(sFaction == "goo" && sFactionMin == "mal"){
            AdjustReputation(oPC,oMinion,-100);
            AdjustReputation(oMinion,oPC,-100);
        }
        else if(sFaction == "evi" && sFactionMin == "buo"){
            AdjustReputation(oPC,oMinion,-100);
            AdjustReputation(oMinion,oPC,-100);
        }
        oPC = GetNextPC();
    }
    AssignCommand(oMinion,WalkWayPoints(FALSE, 0.0));
}
