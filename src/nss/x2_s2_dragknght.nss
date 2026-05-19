/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Cavaliere del Drago.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCap=4;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration =40;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    string sSummon1;
    string sSummon2;
    string sSummon3;
    string sSummon4;
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if(nCasterLevel==40 && nLore>=43)
        eSummon = EffectSummonCreature("sp_dragk_4");
    else if(nCasterLevel>=31 && nLore>=34)
        eSummon = EffectSummonCreature("sp_dragk_3");
    else if(nCasterLevel>=21 && nLore>=24)
        eSummon = EffectSummonCreature("sp_dragk_2");
    else if(nCasterLevel>=13)
        eSummon = EffectSummonCreature("sp_dragk_1");
    else
        eSummon = EffectSummonCreature("sp_dragk_n");
    eSummon = EffectLinkEffects(eVis,eSummon);
    SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
}


