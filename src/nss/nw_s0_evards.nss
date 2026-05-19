/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 02-03-2011
*/

// Tentacoli Neri di Evard.

#include "x0_i0_spells"
#include "x2_inc_spellhook"

void AuraDiEvard(object oPC,int nTime,location lLocation,int nCasterLvl,int nMetamagic){
    int AuraDiEvard_CURRENT = GetLocalInt(oPC,"AuraDiEvard_CURRENT");
    if(AuraDiEvard_CURRENT < nTime && AuraDiEvard_CURRENT != 0){
        AuraDiEvard_CURRENT = AuraDiEvard_CURRENT + 1;
        int nSave = SAVING_THROW_TYPE_SPELL;
        int nType = DAMAGE_TYPE_MAGICAL;
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
        int nDam = d4(nCasterLvl*2);
        effect eVis2 = EffectVisualEffect(VFX_DUR_PARALYZED);
        effect ePara = EffectParalyze();
        ePara = EffectLinkEffects(ePara,eVis2);
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
        effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC,nSave)&&GetIsImmune(oTarget,IMMUNITY_TYPE_PARALYSIS)==FALSE)
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, oTarget,6.0);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiEvard_CURRENT",AuraDiEvard_CURRENT);
        DelayCommand(6.0,AuraDiEvard(oPC,nTime,lLocation,nCasterLvl,nMetamagic));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiEvard_CURRENT");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_EVARDS_BLACK_TENTACLES")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_EVARDS_BLACK_TENTACLES));
    int AuraDiEvard_CURRENT = GetLocalInt(oPC,"AuraDiEvard_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nCasterLvl = GetCasterLevel(oPC);
    int nMetamagic = GetMetaMagicFeat();
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiEvard_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_EVARDS_BLACK_TENTACLES,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiEvard_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiEvard(oPC,nTime,lLocation,nCasterLvl,nMetamagic);
    }
    else{
        if(AuraDiEvard_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiEvard_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_EVARDS_BLACK_TENTACLES,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiEvard_CURRENT",1));
            DelayCommand(6.2,AuraDiEvard(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
        }
    }
}

