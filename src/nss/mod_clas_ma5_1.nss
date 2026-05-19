/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per famigli infernali.

void MultisummonPreSummonSpe(object oPC)
{
    int i=1;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    while(GetIsObjectValid(oSummon)){
        AssignCommand(oSummon, SetIsDestroyable(FALSE, FALSE, FALSE));
        AssignCommand(oSummon, DelayCommand(1.0, SetIsDestroyable(TRUE, FALSE, FALSE)));
        i++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
}

#include "x2_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    object oPC = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oPC);
    int nDuration = 40;
    effect eSummon,eSummon2,eSummon3,eSummon4;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    int nCap = 4;
    eSummon = EffectSummonCreature("sp_arcimago_1");
    eSummon2 = EffectSummonCreature("sp_arcimago_2");
    eSummon3 = EffectSummonCreature("sp_arcimago_3");
    eSummon4 = EffectSummonCreature("sp_arcimago_4");
    eSummon = EffectLinkEffects(eVis,eSummon);
    SendMessageToPC(oPC,"Quest'evocazione assorbe totalmente tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetLocation(oPC));
    DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetLocation(oPC), RoundsToSeconds(nDuration)));
    DelayCommand(0.5,MultisummonPreSummonSpe(oPC));
    DelayCommand(0.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon2, GetLocation(oPC), RoundsToSeconds(nDuration)));
    DelayCommand(1.0,MultisummonPreSummonSpe(oPC));
    DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon3, GetLocation(oPC), RoundsToSeconds(nDuration)));
    DelayCommand(1.5,MultisummonPreSummonSpe(oPC));
    DelayCommand(1.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon4, GetLocation(oPC), RoundsToSeconds(nDuration)));
}

