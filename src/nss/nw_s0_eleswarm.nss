/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Sciame Elementale.

/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Animare i Morti.

void SafeDestroyObject(object oObject)
{
    int Clean = GetLocalInt(oObject,"CleanMob");
    Clean == Clean +6;
    if(Clean==1800){
        SetIsDestroyable(TRUE);
        if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
        if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
        if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
        DestroyObject(oObject);
    }
    SetLocalInt(oObject,"CleanMob",Clean);
}

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

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oPC = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oPC);
    int nDuration = 40;
    effect eSummon,eSummon2,eSummon3,eSummon4;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    int nCap = 4;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration * 2;
    int SwarmCap = GetLocalInt(OBJECT_SELF,"a_10");
    if(SwarmCap==0){
        SetLocalInt(OBJECT_SELF,"a_10",1);
        int nRandom,nRandom2,nRandom3,nRandom4;
        nRandom = Random(4)+1;
        nRandom2 = Random(4)+1;
        nRandom3 = Random(4)+1;
        nRandom4 = Random(4)+1;
        string sRandom,sRandom2,sRandom3,sRandom4;
        int nLore = GetSkillRank(SKILL_LORE,OBJECT_SELF,TRUE);
        if(nCasterLevel==40 && nLore>=43){
            sRandom = "sp_elesw"+IntToString(nRandom)+"_4";
            eSummon = EffectSummonCreature(sRandom);
            eSummon2 = EffectSummonCreature(sRandom);
            eSummon3 = EffectSummonCreature(sRandom);
            eSummon4 = EffectSummonCreature(sRandom);
        }
        else if(nCasterLevel>=31 && nLore>=34){
            sRandom = "sp_elesw"+IntToString(nRandom)+"_3";
            eSummon = EffectSummonCreature(sRandom);
            eSummon2 = EffectSummonCreature(sRandom);
            eSummon3 = EffectSummonCreature(sRandom);
            eSummon4 = EffectSummonCreature(sRandom);
        }
        else if(nCasterLevel>=21 && nLore>=24){
            sRandom = "sp_elesw"+IntToString(nRandom)+"_2";
            eSummon = EffectSummonCreature(sRandom);
            eSummon2 = EffectSummonCreature(sRandom);
            eSummon3 = EffectSummonCreature(sRandom);
            eSummon4 = EffectSummonCreature(sRandom);
        }
        else{
            sRandom = "sp_elesw"+IntToString(nRandom)+"_1";
            eSummon = EffectSummonCreature(sRandom);
            eSummon2 = EffectSummonCreature(sRandom);
            eSummon3 = EffectSummonCreature(sRandom);
            eSummon4 = EffectSummonCreature(sRandom);
        }
        if(GetResRef(OBJECT_SELF)=="set_51_tfc"){
            sRandom = "sp_elesw2_3";
            eSummon = EffectSummonCreature(sRandom);
            eSummon2 = EffectSummonCreature(sRandom);
            eSummon3 = EffectSummonCreature(sRandom);
            eSummon4 = EffectSummonCreature(sRandom);
        }
        eSummon = EffectLinkEffects(eVis,eSummon);
        SendMessageToPC(oPC,"Quest'evocazione assorbe totalmente tua energia magica");
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetLocation(oPC));
        DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration)));
        DelayCommand(0.5,MultisummonPreSummonSpe(oPC));
        DelayCommand(0.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon2, GetSpellTargetLocation(), RoundsToSeconds(nDuration)));
        DelayCommand(1.0,MultisummonPreSummonSpe(oPC));
        DelayCommand(1.0,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon3, GetSpellTargetLocation(), RoundsToSeconds(nDuration)));
        DelayCommand(1.5,MultisummonPreSummonSpe(oPC));
        DelayCommand(1.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon4, GetSpellTargetLocation(), RoundsToSeconds(nDuration)));
        DelayCommand(IntToFloat(nDuration), SetLocalInt(OBJECT_SELF,"a_10",0));
    }
    else
        SendMessageToPC(OBJECT_SELF,"Questa magia e' lanciabile solo una volta ogni "+IntToString(nDuration)+" secondi");
}
