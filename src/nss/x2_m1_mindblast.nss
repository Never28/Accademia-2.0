//::///////////////////////////////////////////////
//:: Cone: Mindflayer Mind Blast
//:: x2_m1_mindblast
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Anyone caught in the cone must make a
    Will save (DC 17) or be stunned for 3d4 rounds
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: Dec 5/02
//:://////////////////////////////////////////////

#include "x2_i0_spells"

void main()
{
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,OBJECT_SELF);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nDamage, nDamStrike; // for level drain
    int nDC;
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
        nDC = 10 + nSag + nMutaLv;
    }
    else{
        nDC = nAge+10;
    }
   object oTarget = GetSpellTargetObject();
   DoMindBlast(nDC, d4(1), 15.0f);
}

