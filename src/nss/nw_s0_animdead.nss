/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Animare i Morti.

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
        nCap=1;
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
    if(nCasterLevel==40 && nLore>=43)
        eSummon = EffectSummonCreature("sp_animdead_4");
    else if(nCasterLevel>=31 && nLore>=34)
        eSummon = EffectSummonCreature("sp_animdead_3");
    else if(nCasterLevel>=21 && nLore>=24)
        eSummon = EffectSummonCreature("sp_animdead_2");
    else if(nCasterLevel>=13)
        eSummon = EffectSummonCreature("sp_animdead_1");
    else
        eSummon = EffectSummonCreature("sp_animdead_n");
    eSummon = EffectLinkEffects(eVis,eSummon);
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
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
}

