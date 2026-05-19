/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Evoca Ombra.

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCap=4;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER,OBJECT_SELF);
    int nDuration =40;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    string sSummon1;
    string sSummon2;
    string sSummon3;
    string sSummon4;
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    if(nCasterLevel==30 && nLore>=43 && GetHasFeat(FEAT_EPIC_EPIC_SHADOWLORD,OBJECT_SELF))
        eSummon = EffectSummonCreature("sp_shadowd_4");
    else if(nCasterLevel>=21 && nLore>=34 && GetHasFeat(FEAT_EPIC_EPIC_SHADOWLORD,OBJECT_SELF))
        eSummon = EffectSummonCreature("sp_shadowd_3");
    else if(nCasterLevel>=11 && nLore>=24 && GetHasFeat(FEAT_EPIC_EPIC_SHADOWLORD,OBJECT_SELF))
        eSummon = EffectSummonCreature("sp_shadowd_2");
    else if(nCasterLevel>=10)
        eSummon = EffectSummonCreature("sp_shadowd_1");
    else
        eSummon = EffectSummonCreature("sp_shadowd_n");
    eSummon = EffectLinkEffects(eVis,eSummon);
    SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, GetSpellTargetLocation());
}

