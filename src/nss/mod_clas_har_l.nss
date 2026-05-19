#include "x2_inc_switches"
#include "x3_inc_string"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void SafeDestroyObject(object oObject){
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

void main()
{
    object oPC = OBJECT_SELF;
    string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
    sName = StringReplace(sName,".","Y");
    sName = StringReplace(sName,"-","Z");
    sName = StringReplace(sName,"_","K");
    object oArmaSpec = GetObjectByTag("F"+sName);
    object oTarget = GetLocalObject(oPC,"TargetColonna");
    int nDamage,nDC,nBonus;
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BARD,oPC)+GetLevelByClass(CLASS_TYPE_HARPER,oPC);
    int nSkill = GetSkillRank(SKILL_CRAFT_WEAPON,oPC,TRUE);
    if(nCasterLevel>=40 && nSkill>=43 && GetItemPossessedBy(oPC,"mod_clas_al") != OBJECT_INVALID){
        nDamage = d8(nCasterLevel);
        nDC = 50;
        nBonus = 20;
    }
    else if(nCasterLevel>=31 && nSkill>=34){
        nDamage = d6(nCasterLevel);
        nDC = 40;
        nBonus = 15;
    }
    else if(nCasterLevel>=21 && nSkill>=24){
        nDamage = d4(nCasterLevel);
        nDC = 30;
        nBonus = 10;
    }
    else if(nCasterLevel>=15 && nSkill>=14){
        nDamage = d2(nCasterLevel);
        nDC = 20;
        nBonus = 5;
    }
    else{
        nDamage = nCasterLevel;
        nDC = 15;
        nBonus = 1;
    }
    float fDamage = (IntToFloat(nDamage)/100.0)*40.0;
    nDamage = FloatToInt(fDamage);
    effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL);
    effect eMissile = EffectBeam(VFX_BEAM_CHAIN,oArmaSpec,BODY_NODE_CHEST);
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    int nAC = GetAC(oTarget);
    int nAttack = GetBaseAttackBonus(oPC);
    int nForza = GetAbilityModifier(ABILITY_STRENGTH,oPC);
    int nDex = GetAbilityModifier(ABILITY_DEXTERITY,oPC);
    if(nForza > nDex)
        nAttack = nAttack + nForza;
    else
        nAttack = nAttack + nDex;
    nAttack = nAttack + nBonus;
    nAttack = d20(1) + nAttack;
    if(nAttack>=nAC){
        if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC,SAVING_THROW_TYPE_ALL,oPC)){
            effect eVenom = EffectEntangle();
            eVis = EffectLinkEffects(eVenom,eVis);
            AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget,6.0);
            AssignCommand(oArmaSpec,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMissile, oTarget,6.0));
        }
        else{
            float fDist = GetDistanceBetween(oArmaSpec, oTarget);
            effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL);
            float fDelay = fDist/(3.0 * log(fDist) + 2.0);
            effect eMissile = EffectBeam(VFX_BEAM_CHAIN,oArmaSpec,BODY_NODE_CHEST);
            AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            AssignCommand(oArmaSpec,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMissile, oTarget,1.0));
        }
    }
    else{
        float fDist = GetDistanceBetween(oArmaSpec, oTarget);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);
        effect eMissile = EffectVisualEffect(VFX_BEAM_CHAIN);
        AssignCommand(oArmaSpec,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMissile, oTarget,1.0));
    }
    if(d20(1)==1){
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM),oArmaSpec);
        SendMessageToPC(oPC,"La Colonna si e' rotta");
        AssignCommand(oArmaSpec,SpeakString("La Colonna si e' rotta"));
        DelayCommand(0.5,SafeDestroyObject(oArmaSpec));
        return;
    }
}

