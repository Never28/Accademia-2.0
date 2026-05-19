/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 02-03-2011
*/

// Nube Maleodorante.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiOdore(object oPC,int nTime,location lLocation,int nMetamagic,int nCasterLvl){
    int AuraDiOdore_CURRENT = GetLocalInt(oPC,"AuraDiOdore_CURRENT");
    if(AuraDiOdore_CURRENT < nTime && AuraDiOdore_CURRENT != 0){
        AuraDiOdore_CURRENT = AuraDiOdore_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nClass = GetLastSpellCastClass();
        if(nClass == CLASS_TYPE_BARD){
            int nBard = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
            if(nBard >=21)
                nDC = nDC +5;
            else if(nBard >=15)
                nDC = nDC +3;
            else if(nBard >=10)
                nDC = nDC +2;
            else if(nBard >=5)
                nDC = nDC +1;
        }
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
        effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        effect eStun = EffectDazed();
        effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eVis3 = EffectVisualEffect(VFX_IMP_DAZED_S);
        eStun = EffectLinkEffects(eVis2,eStun);
        eStun = EffectLinkEffects(eStun,eVis);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,6.7,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC) && MyResistSpell(oPC,oTarget)==0 && GetIsImmune(oTarget,IMMUNITY_TYPE_DAZED)==FALSE){
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, 6.0);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis3, oTarget);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,6.7,lLocation);
        }
        SetLocalInt(oPC,"AuraDiOdore_CURRENT",AuraDiOdore_CURRENT);
        DelayCommand(6.0,AuraDiOdore(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiOdore_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_FOGSTINK")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_STINKING_CLOUD));
    int AuraDiOdore_CURRENT = GetLocalInt(oPC,"AuraDiOdore_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nMetamagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(oPC);
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiOdore_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_FOGSTINK,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiOdore_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiOdore(oPC,nTime,lLocation,nMetamagic,nCasterLvl);
    }
    else{
        if(AuraDiOdore_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiOdore_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_FOGSTINK,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiOdore_CURRENT",1));
            DelayCommand(6.2,AuraDiOdore(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
        }
    }
}
