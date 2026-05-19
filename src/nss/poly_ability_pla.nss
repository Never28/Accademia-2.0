/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Alleato Planare Superiore.

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
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    effect eGate;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
    effect eLink = EffectLinkEffects(eDur, EffectParalyze());
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);
    int nAge = GetHitDice(OBJECT_SELF);
    int nDC;
    int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
    int nAppearance = GetAppearanceType(OBJECT_SELF);
    int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    if (GetIsObjectValid(oTarget)){
        if(!GetIsReactionTypeFriendly(oTarget)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_PLANAR_BINDING));
            if(nRacial == RACIAL_TYPE_OUTSIDER){
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)){
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                }
            }
        }
    }
    else{
        int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
        float fDelay = 3.0;
        if(nAlign==ALIGNMENT_EVIL){
            if(nDruidLv==40 && nLore>=43)
                eSummon = EffectSummonCreature("sp_evmce_8_4", VFX_FNF_SUMMON_GATE, 3.0);
            else if(nDruidLv>=31 && nLore>=34)
                eSummon = EffectSummonCreature("sp_evmce_8_3", VFX_FNF_SUMMON_GATE, 3.0);
            else if(nDruidLv>=21 && nLore>=24)
                eSummon = EffectSummonCreature("sp_evmce_8_2", VFX_FNF_SUMMON_GATE, 3.0);
            else
                eSummon = EffectSummonCreature("sp_evmce_8_1", VFX_FNF_SUMMON_GATE, 3.0);
        }
        else if(nAlign==ALIGNMENT_GOOD){
            if(nDruidLv==40 && nLore>=43)
                eSummon = EffectSummonCreature("sp_evmcg_8_4", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else if(nDruidLv>=31 && nLore>=34)
                eSummon = EffectSummonCreature("sp_evmcg_8_3", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else if(nDruidLv>=21 && nLore>=24)
                eSummon = EffectSummonCreature("sp_evmcg_8_2", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else
                eSummon = EffectSummonCreature("sp_evmcg_8_1", VFX_FNF_SUMMON_CELESTIAL, fDelay);
        }
        else {
            if(nDruidLv==40 && nLore>=43)
                eSummon = EffectSummonCreature("sp_evmw_8_4", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else if(nDruidLv>=31 && nLore>=34)
                eSummon = EffectSummonCreature("sp_evmw_8_3", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else if(nDruidLv>=21 && nLore>=24)
                eSummon = EffectSummonCreature("sp_evmw_8_2", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else
                eSummon = EffectSummonCreature("sp_evmw_8_1", VFX_FNF_SUMMON_MONSTER_3, 3.0);
        }
    }
    SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
}

