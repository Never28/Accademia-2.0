/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Alleato Planare Inferiore.

int MultisummonPreSummon(object oPC,int nCapCreature)
{
    int i=1;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    int nAssociate = nAssociate;
    while(GetIsObjectValid(oSummon)){
        i++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
    i = i - 1;
    oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    string sSummon;
    int nCap;
    int nTotalCap = nCapCreature;
    while(GetIsObjectValid(oSummon)){
        sSummon = GetTag(oSummon);
        if(sSummon == "sp_evgs_1")
            nCap = 1;
        if(sSummon == "sp_evgs_2")
            nCap = 2;
        if(sSummon == "sp_evgs_4")
            nCap = 4;
        nTotalCap = nTotalCap + nCap;
        if(nTotalCap<=4){
            AssignCommand(oSummon, SetIsDestroyable(FALSE, FALSE, FALSE));
            AssignCommand(oSummon, DelayCommand(1.0, SetIsDestroyable(TRUE, FALSE, FALSE)));
        }
        else{
            AssignCommand(oSummon, SetIsDestroyable(TRUE, FALSE, FALSE));
            DestroyObject(oSummon,0.2);
            nTotalCap = nTotalCap - nCap;
        }
        i--;
        oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, i);
    }
    return nTotalCap;
}

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCap=4;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    if (nCasterLevel>=13)
        nCap=2;
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
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
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
            if(nCasterLevel==40 && nLore>=43)
                eSummon = EffectSummonCreature("sp_evmce_5_4", VFX_FNF_SUMMON_GATE, 3.0);
            else if(nCasterLevel>=31 && nLore>=34)
                eSummon = EffectSummonCreature("sp_evmce_5_3", VFX_FNF_SUMMON_GATE, 3.0);
            else if(nCasterLevel>=21 && nLore>=24)
                eSummon = EffectSummonCreature("sp_evmce_5_2", VFX_FNF_SUMMON_GATE, 3.0);
            else if(nCasterLevel>=13)
                eSummon = EffectSummonCreature("sp_evmce_5_1", VFX_FNF_SUMMON_GATE, 3.0);
            else
                eSummon = EffectSummonCreature("sp_evmce_5_n", VFX_FNF_SUMMON_GATE, 3.0);
        }
        else if(nAlign==ALIGNMENT_GOOD){
            if(nCasterLevel==40 && nLore>=43)
                eSummon = EffectSummonCreature("sp_evmcg_5_4", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else if(nCasterLevel>=31 && nLore>=34)
                eSummon = EffectSummonCreature("sp_evmcg_5_3", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else if(nCasterLevel>=21 && nLore>=24)
                eSummon = EffectSummonCreature("sp_evmcg_5_2", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else if(nCasterLevel>=13)
                eSummon = EffectSummonCreature("sp_evmcg_5_1", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            else
                eSummon = EffectSummonCreature("sp_evmcg_5_n", VFX_FNF_SUMMON_CELESTIAL, fDelay);
        }
        else {
            if(nCasterLevel==40 && nLore>=43)
                eSummon = EffectSummonCreature("sp_evmw_5_4", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else if(nCasterLevel>=31 && nLore>=34)
                eSummon = EffectSummonCreature("sp_evmw_5_3", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else if(nCasterLevel>=21 && nLore>=24)
                eSummon = EffectSummonCreature("sp_evmw_5_2", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else if(nCasterLevel>=13)
                eSummon = EffectSummonCreature("sp_evmw_5_1", VFX_FNF_SUMMON_MONSTER_3, 3.0);
            else
                eSummon = EffectSummonCreature("sp_evmw_5_n", VFX_FNF_SUMMON_MONSTER_3, 3.0);
        }
    }
    if (nCasterLevel>=13){
        int NewSummon = MultisummonPreSummon(OBJECT_SELF,nCap);
        switch(NewSummon){
            case 1:
                SendMessageToPC(OBJECT_SELF,"Quest'evocazione assorbe una minima parte della tua energia magica");
                break;
            case 2:
                SendMessageToPC(OBJECT_SELF,"Quest'evocazione consuma notevolmente la tua energia magica");
                break;
            case 3:
                SendMessageToPC(OBJECT_SELF,"Quest'evocazione consuma quasi totalmente la tua energia magica");
                break;
            case 4:
                SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
                break;
        }
    }
    else
        SendMessageToPC(OBJECT_SELF,"Quest'evocazione prosciuga la tua energia magica");
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
}
