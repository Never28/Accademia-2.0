/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Nebbia Mentale.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiMind(object oPC,int nTime,location lLocation,int nMetamagic,int nCasterLvl){
    int AuraDiMind_CURRENT = GetLocalInt(oPC,"AuraDiMind_CURRENT");
    if(AuraDiMind_CURRENT < nTime && AuraDiMind_CURRENT != 0){
        AuraDiMind_CURRENT = AuraDiMind_CURRENT + 1;
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
        effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
        int nBonus = nCasterLvl/2;
        effect eLower = EffectSavingThrowDecrease(SAVING_THROW_WILL, nBonus);
        eLower = EffectLinkEffects(eLower,eVis);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,10.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC) && MyResistSpell(oPC,oTarget)==0 && GetIsImmune(oTarget,IMMUNITY_TYPE_MIND_SPELLS)==FALSE)
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLower, oTarget, 6.0);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,10.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiMind_CURRENT",AuraDiMind_CURRENT);
        DelayCommand(6.0,AuraDiMind(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiMind_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_FOGMIND")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_MIND_FOG));
    int AuraDiMind_CURRENT = GetLocalInt(oPC,"AuraDiMind_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nMetamagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(oPC);
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiMind_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_FOGMIND,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiMind_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiMind(oPC,nTime,lLocation,nMetamagic,nCasterLvl);
    }
    else{
        if(AuraDiMind_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiMind_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_FOGMIND,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiMind_CURRENT",1));
            DelayCommand(6.2,AuraDiMind(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
        }
    }
}
