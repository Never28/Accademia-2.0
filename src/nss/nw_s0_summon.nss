/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Evoca Creature 1,2,3,4,5,6,7,8,9.

effect SetSummonEffect(int nSpellID);

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
    effect eVis;
    int nSpellID = GetSpellId();
    effect eSummon = SetSummonEffect(nSpellID);
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    if (nCasterLevel>=13)
        nCap=1;
    int nDuration =40;
    string sResRef=GetResRef(OBJECT_SELF);
    if(sResRef=="set_27_gsc"){
        int nElemental = Random(4);
        string sSummon;
        switch(nElemental){
            case 0:
                sSummon = "sp_evadt_9_1";
                break;
            case 1:
                sSummon = "sp_evadf_9_1";
                break;
            case 2:
                sSummon = "sp_evadw_9_1";
                break;
            case 3:
                sSummon = "sp_evada_9_1";
                break;
        }
        eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3,FALSE);
        eSummon=EffectSummonCreature(sSummon, VFX_FNF_SUMMON_MONSTER_3);
        eSummon = EffectLinkEffects(eVis,eSummon);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
        return;
    }
    int nClass = GetLastSpellCastClass();
        switch (nSpellID){
            case SPELL_SUMMON_CREATURE_I:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_II:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_III:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_IV:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_V:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_VI:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_VII:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3,FALSE);
                break;
            case SPELL_SUMMON_CREATURE_IX:
                eVis =EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3,FALSE);
                break;
        }
    if(nCasterLevel>=13){
        switch (nSpellID){
            case SPELL_SUMMON_CREATURE_I:
                nCap = 1;
                break;
            case SPELL_SUMMON_CREATURE_II:
                if(nClass == CLASS_TYPE_RANGER)
                    nCap = 2;
                nCap = 1;
                break;
            case SPELL_SUMMON_CREATURE_III:
                if(nClass == CLASS_TYPE_RANGER)
                    nCap = 2;
                else if(nClass == CLASS_TYPE_BARD)
                    nCap =2;
                else
                    nCap =1;
                break;
            case SPELL_SUMMON_CREATURE_IV:
                if(nClass == CLASS_TYPE_RANGER)
                    nCap = 4;
                else if(nClass == CLASS_TYPE_BARD)
                    nCap =2;
                else
                    nCap =2;
                break;
            case SPELL_SUMMON_CREATURE_V:
                if(nClass == CLASS_TYPE_BARD)
                    nCap =4;
                else
                    nCap =2;
                break;
            case SPELL_SUMMON_CREATURE_VI:
                if(nClass == CLASS_TYPE_BARD)
                    nCap =4;
                else
                    nCap =2;
                break;
            case SPELL_SUMMON_CREATURE_VII:
                nCap = 4;
                break;
            case SPELL_SUMMON_CREATURE_VIII:
                nCap = 4;
                break;
            case SPELL_SUMMON_CREATURE_IX:
                nCap = 4;
                break;
        }
    }
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
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

effect SetSummonEffect(int nSpellID)
{
    object oPC=OBJECT_SELF;
    int nFNF_Effect;
    int nElemental = Random(4);
    string sSummon;
    int nCasterLevel = GetCasterLevel(oPC);
    int nClass = GetLastSpellCastClass();
    int nEvil = GetAlignmentGoodEvil(oPC);
    int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
    switch (nSpellID){
        case SPELL_SUMMON_CREATURE_I:
            switch (nClass){
                case CLASS_TYPE_BARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmb_1_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmb_1_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmb_1_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmb_1_1";
                    else
                        sSummon = "sp_evmb_1_n";
                    break;
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_1_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_1_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_1_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_1_1";
                    else
                        sSummon = "sp_evmw_1_n";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_1_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_1_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_1_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_1_1";
                    else
                        sSummon = "sp_evmw_1_n";
                    break;
                case CLASS_TYPE_RANGER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evar_1_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evar_1_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evar_1_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evar_1_1";
                    else
                        sSummon = "sp_evar_1_n";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_1_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_1_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_1_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evad_1_1";
                    else
                        sSummon = "sp_evad_1_n";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_1_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_1_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_1_2";
                        else if(nCasterLevel>=13)
                            sSummon = "sp_evad_1_1";
                        else
                            sSummon = "sp_evad_1_n";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_1_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_1_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_1_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmce_1_1";
                            else
                                sSummon = "sp_evmce_1_n";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_1_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_1_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_1_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmcg_1_1";
                            else
                                sSummon = "sp_evmcg_1_n";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_1_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_1_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_1_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmw_1_1";
                            else
                                sSummon = "sp_evmw_1_n";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_II:
            switch (nClass){
                case CLASS_TYPE_BARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmb_2_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmb_2_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmb_2_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmb_2_1";
                    else
                        sSummon = "sp_evmb_2_n";
                    break;
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_2_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_2_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_2_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_2_1";
                    else
                        sSummon = "sp_evmw_2_n";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_2_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_2_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_2_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_2_1";
                    else
                        sSummon = "sp_evmw_2_n";
                    break;
                case CLASS_TYPE_RANGER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evar_2_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evar_2_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evar_2_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evar_2_1";
                    else
                        sSummon = "sp_evar_2_n";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_2_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_2_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_2_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evad_2_1";
                    else
                        sSummon = "sp_evad_2_n";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_2_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_2_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_2_2";
                        else if(nCasterLevel>=13)
                            sSummon = "sp_evad_2_1";
                        else
                            sSummon = "sp_evad_2_n";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_2_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_2_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_2_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmce_2_1";
                            else
                                sSummon = "sp_evmce_2_n";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_2_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_2_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_2_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmcg_2_1";
                            else
                                sSummon = "sp_evmcg_2_n";
                        }
                        else{
                                if(nCasterLevel==40 && nLore>=43)
                                    sSummon = "sp_evmw_2_4";
                                else if(nCasterLevel>=31 && nLore>=34)
                                    sSummon = "sp_evmw_2_3";
                                else if(nCasterLevel>=21 && nLore>=24)
                                    sSummon = "sp_evmw_2_2";
                                else if(nCasterLevel>=13)
                                    sSummon = "sp_evmw_2_1";
                                else
                                    sSummon = "sp_evmw_2_n";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_III:
            switch (nClass){
                case CLASS_TYPE_BARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmb_3_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmb_3_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmb_3_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmb_3_1";
                    else
                        sSummon = "sp_evmb_3_n";
                    break;
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_3_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_3_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_3_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_3_1";
                    else
                        sSummon = "sp_evmw_3_n";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_3_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_3_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_3_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_3_1";
                    else
                        sSummon = "sp_evmw_3_n";
                    break;
                case CLASS_TYPE_RANGER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evar_3_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evar_3_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evar_3_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evar_3_1";
                    else
                        sSummon = "sp_evar_3_n";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_3_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_3_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_3_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evad_3_1";
                    else
                        sSummon = "sp_evad_3_n";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_3_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_3_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_3_2";
                        else if(nCasterLevel>=13)
                            sSummon = "sp_evad_3_1";
                        else
                            sSummon = "sp_evad_3_n";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_3_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_3_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_3_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmce_3_1";
                            else
                                sSummon = "sp_evmce_3_n";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_3_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_3_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_3_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmcg_3_1";
                            else
                                sSummon = "sp_evmcg_3_n";
                        }
                        else{
                                if(nCasterLevel==40 && nLore>=43)
                                    sSummon = "sp_evmw_3_4";
                                else if(nCasterLevel>=31 && nLore>=34)
                                    sSummon = "sp_evmw_3_3";
                                else if(nCasterLevel>=21 && nLore>=24)
                                    sSummon = "sp_evmw_3_2";
                                else if(nCasterLevel>=13)
                                    sSummon = "sp_evmw_3_1";
                                else
                                    sSummon = "sp_evmw_3_n";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_IV:
            switch (nClass){
                case CLASS_TYPE_BARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmb_4_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmb_4_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmb_4_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmb_4_1";
                    else
                        sSummon = "sp_evmb_4_n";
                    break;
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_4_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_4_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_4_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_4_1";
                    else
                        sSummon = "sp_evmw_4_n";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_4_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_4_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_4_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_4_1";
                    else
                        sSummon = "sp_evmw_4_n";
                    break;
                case CLASS_TYPE_RANGER:

                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evar_4_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evar_4_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evar_4_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evar_4_1";
                    else
                        sSummon = "sp_evar_4_n";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_4_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_4_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_4_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evad_4_1";
                    else
                        sSummon = "sp_evad_4_n";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_4_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_4_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_4_2";
                        else if(nCasterLevel>=13)
                            sSummon = "sp_evad_4_1";
                        else
                            sSummon = "sp_evad_4_n";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_4_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_4_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_4_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmce_4_1";
                            else
                                sSummon = "sp_evmce_4_n";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_4_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_4_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_4_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmcg_4_1";
                            else
                                sSummon = "sp_evmcg_4_n";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_4_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_4_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_4_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmw_4_1";
                            else
                                sSummon = "sp_evmw_4_n";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_V:
            switch (nClass){
                case CLASS_TYPE_BARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmb_5_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmb_5_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmb_5_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmb_5_1";
                    else
                        sSummon = "sp_evmb_5_n";
                    break;
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_5_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_5_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_5_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_5_1";
                    else
                        sSummon = "sp_evmw_5_n";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_5_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_5_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_5_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_5_1";
                    else
                        sSummon = "sp_evmw_5_n";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_5_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_5_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_5_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evad_5_1";
                    else
                        sSummon = "sp_evad_5_n";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_5_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_5_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_5_2";
                        else if(nCasterLevel>=13)
                            sSummon = "sp_evad_5_1";
                        else
                            sSummon = "sp_evad_5_n";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_5_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_5_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_5_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmce_5_1";
                            else
                                sSummon = "sp_evmce_5_n";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_5_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_5_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_5_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmcg_5_1";
                            else
                                sSummon = "sp_evmcg_5_n";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_5_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_5_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_5_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmw_5_1";
                            else
                                sSummon = "sp_evmw_5_n";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_VI:
            switch (nClass){
                case CLASS_TYPE_BARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmb_6_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmb_6_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmb_6_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmb_6_1";
                    else
                        sSummon = "sp_evmb_6_n";
                    break;
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_6_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_6_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_6_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evmw_6_1";
                    else
                        sSummon = "sp_evmw_6_n";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_6_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_6_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_6_2";
                    else
                        sSummon = "sp_evmw_6_1";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_6_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_6_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_6_2";
                    else if(nCasterLevel>=13)
                        sSummon = "sp_evad_6_1";
                    else
                        sSummon = "sp_evad_6_n";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_6_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_6_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_6_2";
                        else if(nCasterLevel>=13)
                            sSummon = "sp_evad_6_1";
                        else
                            sSummon = "sp_evad_6_n";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_6_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_6_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_6_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmce_6_1";
                            else
                                sSummon = "sp_evmce_6_n";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_6_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_6_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_6_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmcg_6_1";
                            else
                                sSummon = "sp_evmcg_6_n";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_6_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_6_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_6_2";
                            else if(nCasterLevel>=13)
                                sSummon = "sp_evmw_6_1";
                            else
                                sSummon = "sp_evmw_6_n";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_VII:
            switch (nClass){
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_7_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_7_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_7_2";
                    else
                        sSummon = "sp_evmw_7_1";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_7_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_7_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_7_2";
                    else
                        sSummon = "sp_evmw_7_1";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evad_7_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evad_7_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evad_7_2";
                    else
                        sSummon = "sp_evad_7_1";
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                            sSummon = "sp_evad_7_4";
                        else if(nCasterLevel>=31 && nLore>=34)
                            sSummon = "sp_evad_7_3";
                        else if(nCasterLevel>=21 && nLore>=24)
                            sSummon = "sp_evad_7_2";
                        else
                            sSummon = "sp_evad_7_1";
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_7_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_7_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_7_2";
                            else
                                sSummon = "sp_evmce_7_1";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_7_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_7_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_7_2";
                            else
                                sSummon = "sp_evmcg_7_1";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_7_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_7_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_7_2";
                            else
                                sSummon = "sp_evmw_7_1";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_VIII:
            switch (nClass){
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_8_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_8_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_8_2";
                    else
                        sSummon = "sp_evmw_8_1";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_8_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_8_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_8_2";
                    else
                        sSummon = "sp_evmw_8_1";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43){
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_4";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_4";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_4";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_4";
                                break;
                        }
                    }
                    else if(nCasterLevel>=31 && nLore>=34)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_3";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_3";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_3";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_3";
                                break;
                        }
                    else if(nCasterLevel>=21 && nLore>=24)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_2";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_2";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_2";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_2";
                                break;
                        }
                    else
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_1";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_1";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_1";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_1";
                                break;
                        }
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_4";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_4";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_4";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_4";
                                break;
                        }
                        else if(nCasterLevel>=31 && nLore>=34)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_3";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_3";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_3";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_3";
                                break;
                        }
                        else if(nCasterLevel>=21 && nLore>=24)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_2";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_2";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_2";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_2";
                                break;
                        }
                        else
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_8_1";
                                break;
                            case 1:
                                sSummon = "sp_evadf_8_1";
                                break;
                            case 2:
                                sSummon = "sp_evadw_8_1";
                                break;
                            case 3:
                                sSummon = "sp_evada_8_1";
                                break;
                        }
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_8_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_8_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_8_2";
                            else
                                sSummon = "sp_evmce_8_1";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_8_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_8_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_8_2";
                            else
                                sSummon = "sp_evmcg_8_1";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_8_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_8_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_8_2";
                            else
                                sSummon = "sp_evmw_8_1";
                        }
                    }
                    break;
                }
            break;
        case SPELL_SUMMON_CREATURE_IX:
            switch (nClass){
                case CLASS_TYPE_SORCERER:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_9_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_9_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_9_2";
                    else
                        sSummon = "sp_evmw_9_1";
                    break;
                case CLASS_TYPE_WIZARD:
                    if(nCasterLevel==40 && nLore>=43)
                        sSummon = "sp_evmw_9_4";
                    else if(nCasterLevel>=31 && nLore>=34)
                        sSummon = "sp_evmw_9_3";
                    else if(nCasterLevel>=21 && nLore>=24)
                        sSummon = "sp_evmw_9_2";
                    else
                        sSummon = "sp_evmw_9_1";
                    break;
                case CLASS_TYPE_DRUID:
                    if(nCasterLevel==40 && nLore>=43)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_4";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_4";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_4";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_4";
                                break;
                        }
                    else if(nCasterLevel>=31 && nLore>=34)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_3";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_3";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_3";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_3";
                                break;
                        }
                    else if(nCasterLevel>=21 && nLore>=24)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_2";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_2";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_2";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_2";
                                break;
                        }
                    else
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_1";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_1";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_1";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_1";
                                break;
                        }
                    break;
                case CLASS_TYPE_CLERIC:
                    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,OBJECT_SELF)){
                        if(nCasterLevel==40 && nLore>=43)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_4";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_4";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_4";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_4";
                                break;
                        }
                        else if(nCasterLevel>=31 && nLore>=34)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_3";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_3";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_3";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_3";
                                break;
                        }
                        else if(nCasterLevel>=21 && nLore>=24)
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_2";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_2";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_2";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_2";
                                break;
                        }
                        else
                        switch(nElemental){
                            case 0:
                                sSummon = "sp_evadt_9_1";
                                break;
                            case 1:
                                sSummon = "sp_evadf_9_1";
                                break;
                            case 2:
                                sSummon = "sp_evadw_9_1";
                                break;
                            case 3:
                                sSummon = "sp_evada_9_1";
                                break;
                        }
                    }
                    else{
                        if(nEvil==ALIGNMENT_EVIL){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmce_9_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmce_9_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmce_9_2";
                            else
                                sSummon = "sp_evmce_9_1";
                        }
                        else if(nEvil==ALIGNMENT_GOOD){
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmcg_9_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmcg_9_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmcg_9_2";
                            else
                                sSummon = "sp_evmcg_9_1";
                        }
                        else{
                            if(nCasterLevel==40 && nLore>=43)
                                sSummon = "sp_evmw_9_4";
                            else if(nCasterLevel>=31 && nLore>=34)
                                sSummon = "sp_evmw_9_3";
                            else if(nCasterLevel>=21 && nLore>=24)
                                sSummon = "sp_evmw_9_2";
                            else
                                sSummon = "sp_evmw_9_1";
                        }
                    }
                    break;
                }
            break;
        }
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}
