/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Nebbia Acida.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiAcidFog(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiAcidFog_CURRENT = GetLocalInt(oPC,"AuraDiAcidFog_CURRENT");
    if(AuraDiAcidFog_CURRENT < nTime && AuraDiAcidFog_CURRENT != 0){
        AuraDiAcidFog_CURRENT = AuraDiAcidFog_CURRENT + 1;
        int nSave = SAVING_THROW_TYPE_ACID;
        int nType = DAMAGE_TYPE_ACID;
        int nSpec=0;
        int nElement = GetLocalInt(GetAreaOfEffectCreator(),"SapienteElementale");
        switch(nElement){
            case 1:
                nType = DAMAGE_TYPE_BLUDGEONING;
                break;
            case 2:
                nType = DAMAGE_TYPE_COLD;
                break;
            case 3:
                nType = DAMAGE_TYPE_ELECTRICAL;
                break;
            case 4:
                nType = DAMAGE_TYPE_FIRE;
                break;
        }
        int nDC = GetSpellSaveDC();
        int nDam = d6(nCasterLvl*2);
        effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eSlow = EffectSlow();
        eSlow = EffectLinkEffects(eSlow,eVis2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 12*(nCasterLvl);
        if (nMetamagic == METAMAGIC_EMPOWER)
            nDam = nDam + (nDam/2);

        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
        float fDamage = (IntToFloat(nDam+nSpec)/100.0)*20.0;
        nDam = FloatToInt(fDamage);
        effect eDam = EffectDamage(nDam, nType);
        effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(MyResistSpell(oPC,oTarget)==0){
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC,nSave))
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget,6.0);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiAcidFog_CURRENT",AuraDiAcidFog_CURRENT);
        DelayCommand(6.0,AuraDiAcidFog(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiAcidFog_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_FOGACID")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_ACID_FOG));
    int AuraDiAcidFog_CURRENT = GetLocalInt(oPC,"AuraDiAcidFog_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiAcidFog_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiAcidFog_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiAcidFog(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiAcidFog_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiAcidFog_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiAcidFog_CURRENT",1));
            DelayCommand(6.2,AuraDiAcidFog(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
        }
    }
}

