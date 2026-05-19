//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons in the Area are frozen in time
    except the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oArea = GetArea(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime = EffectTimeStop();
    int nRoll = 1 + d4();
    object oXx;
    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    int EntangleCap = GetLocalInt(OBJECT_SELF,"a_16");
    if(EntangleCap==0){
        SetLocalInt(OBJECT_SELF,"a_16",1);
        oXx = GetFirstObjectInArea(oArea);
        while(oXx!=OBJECT_INVALID){
            DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, OBJECT_SELF, 6.0));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            oXx=GetNextObjectInArea(oArea);
        }
        DelayCommand(300.0, SetLocalInt(OBJECT_SELF,"a_16",0));
    }
    else
        SendMessageToPC(OBJECT_SELF,"Questa magia e' lanciabile solo una volta ogni 5 minuti");
}
