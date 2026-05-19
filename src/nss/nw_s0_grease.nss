/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Intralciare.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiGrease(object oPC,int nTime,location lLocation){
    int AuraDiGrease_CURRENT = GetLocalInt(oPC,"AuraDiGrease_CURRENT");
    if(AuraDiGrease_CURRENT < nTime && AuraDiGrease_CURRENT != 0){
        AuraDiGrease_CURRENT = AuraDiGrease_CURRENT + 1;
        int nDC = GetSpellSaveDC();
        int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_RANGER){
        int nRang = GetLevelByClass(CLASS_TYPE_RANGER,OBJECT_SELF);
        if(nRang >=21)
            nDC = nDC +7;
        else if(nRang >=17)
            nDC = nDC +5;
        else if(nRang >=14)
            nDC = nDC +4;
        else if(nRang >=11)
            nDC = nDC +3;
        else if(nRang >=8)
            nDC = nDC +2;
        else
            nDC = nDC +1;
    }
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
        effect eVis = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eSlow = EffectMovementSpeedDecrease(50);
        eSlow = EffectLinkEffects(eSlow,eVis);
        effect eFall = EffectKnockdown();
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,6.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE && !GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget)){
                    if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC) && MyResistSpell(oPC,oTarget)==0 && GetIsImmune(oTarget,IMMUNITY_TYPE_KNOCKDOWN)==FALSE){
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, 6.0);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFall, oTarget, 6.0);
                    }
                    else
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, 6.0);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,6.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiGrease_CURRENT",AuraDiGrease_CURRENT);
        DelayCommand(6.0,AuraDiGrease(oPC,nTime,lLocation));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiGrease_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_GREASE")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_ENTANGLE));
    int AuraDiGrease_CURRENT = GetLocalInt(oPC,"AuraDiGrease_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiGrease_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_GREASE,"fakespell","fakespell","fakespell");
        effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLocation);
        SetLocalInt(oPC,"AuraDiGrease_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiGrease(oPC,nTime,GetSpellTargetLocation());
    }
    else{
        if(AuraDiGrease_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiGrease_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_GREASE,"fakespell","fakespell","fakespell");
            effect eImpact = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLocation);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiGrease_CURRENT",1));
            DelayCommand(6.2,AuraDiGrease(oPC,nTime,lLocation));
        }
    }
}
