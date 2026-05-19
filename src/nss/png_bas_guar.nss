//::///////////////////////////////////////////////
//:: Associate: Heartbeat
//:: NW_CH_AC1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move towards master or wait for him
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:: Updated On: Jul 25, 2003 - Georg Zoeller
//:://////////////////////////////////////////////

#include "X0_INC_HENAI"
#include "X2_INC_SUMMSCALE"
#include "X2_INC_SPELLHOOK"

void main()
{
    AssignCommand(OBJECT_SELF,ClearAllActions());
    DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tra_t1"))));
}




