/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 01-03-2011
*/

// Nebbia Mortale.

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void AuraDiKill(object oPC,int nTime,location lLocation,int nMetamagic,int nCasterLvl){
    int AuraDiKill_CURRENT = GetLocalInt(oPC,"AuraDiKill_CURRENT");
    if(AuraDiKill_CURRENT < nTime && AuraDiKill_CURRENT != 0){
        AuraDiKill_CURRENT = AuraDiKill_CURRENT +1;
        string AuraDiKill_IMMUNI = GetLocalString(oPC,"AuraDiKill_IMMUNI");
        int nDC = GetSpellSaveDC();
        int nControll = -1;
        string sMorteMOB;
        effect eDeath = EffectDeath();
        int nSave = SAVING_THROW_TYPE_NEGATIVE;
        int nType = DAMAGE_TYPE_NEGATIVE;
        int nSpec;
        int nElement = GetLocalInt(oPC,"SapienteElementale");
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
        int nDam = nNumberRandom(5,nCasterLvl*2);
        if (nMetamagic == METAMAGIC_MAXIMIZE)
            nDam = 8*(nCasterLvl);
        if (nMetamagic == METAMAGIC_EMPOWER)
            nDam = nDam + (nDam/2);
        if(GetHitDice(oPC)==40)
            nDC = nDC +5;
        else if(GetHitDice(oPC)>=31)
            nDC = nDC +3;
        else if(GetHitDice(oPC)>=21)
            nDC = nDC +2;
        else if(GetHitDice(oPC)>=11)
            nDC = nDC +1;
        float fDamage = (IntToFloat(nDam+nSpec)/100.0)*20.0;
        nDam = FloatToInt(fDamage);
        int nThrow;
        effect eDam = EffectDamage(nDam, nType);
        effect eNeg = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        effect eSpeed = EffectMovementSpeedDecrease(50);
        effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink = EffectLinkEffects(eSpeed, eVis2);
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(GetIsObjectValid(oTarget)){
            if(GetIsDead(oTarget)==FALSE){
                if(GetIsPC(oTarget) == TRUE){
                    if(MyResistSpell(oPC,oTarget)==0){
                    nControll = FindSubString(AuraDiKill_IMMUNI,GetName(oTarget)+GetPCPlayerName(oTarget));
                        if(nControll == -1){
                            nThrow = MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH);
                            if(nThrow == 0 ){
                                if(GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH)==FALSE){
                                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                                }
                                else
                                    SetLocalString(oPC,"AuraDiKill_IMMUNI",AuraDiKill_IMMUNI+GetName(oTarget)+GetPCPlayerName(oTarget)+" ");
                            }
                            else
                                SetLocalString(oPC,"AuraDiKill_IMMUNI",AuraDiKill_IMMUNI+GetName(oTarget)+GetPCPlayerName(oTarget)+" ");
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eNeg, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oTarget,6.0);
                        }
                        else{
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eNeg, oTarget);
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeed, oTarget,6.0);
                        }
                    }
                }
                else{
                    if(MyResistSpell(oPC,oTarget)==0){
                        sMorteMOB = GetLocalString(oTarget,"AuraDiKill_SALVO");
                        nControll = FindSubString(sMorteMOB,GetName(oPC)+GetPCPlayerName(oPC));
                        if(nControll == -1){
                            nThrow = MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH);
                            if(nThrow ==0){
                                if(GetIsImmune(oTarget,IMMUNITY_TYPE_DEATH)==FALSE){
                                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
                                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                                }
                                else
                                    ActionDoCommand(SetLocalString(oTarget,"AuraDiKill_SALVO",sMorteMOB+GetName(oPC)+GetPCPlayerName(oPC)+" "));
                            }
                            else
                                ActionDoCommand(SetLocalString(oTarget,"AuraDiKill_SALVO",sMorteMOB+GetName(oPC)+GetPCPlayerName(oPC)+" "));
                        }
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        SetLocalInt(oPC,"AuraDiKill_CURRENT",AuraDiKill_CURRENT);
        DelayCommand(6.0,AuraDiKill(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
    }
    else{
        DeleteLocalInt(oPC,"AuraDiKill_CURRENT");
        DeleteLocalString(oPC,"AuraDiKill_IMMUNI");
        object oTargetAoE = GetNearestObjectToLocation(OBJECT_TYPE_AREA_OF_EFFECT,lLocation);
        string sAoE = GetTag(oTargetAoE);
        if(sAoE == "VFX_PER_FOGKILL")
            DestroyObject(oTargetAoE);
    }
}

void main()
{
    object oPC = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    SignalEvent(oPC,EventSpellCastAt(oPC,SPELL_CLOUDKILL));
    int AuraDiKill_CURRENT = GetLocalInt(oPC,"AuraDiKill_CURRENT");
    int nTime = GetCasterLevel(oPC)+3;
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
        nTime = nTime *2;
    int nMetamagic = GetMetaMagicFeat();
    int nCasterLvl = GetCasterLevel(oPC);
    location lLocation = GetSpellTargetLocation();
    float fTime = RoundsToSeconds(nTime);
    if(AuraDiKill_CURRENT == 0){
        effect eAOE = EffectAreaOfEffect(AOE_PER_FOGKILL,"fakespell","fakespell","fakespell");
        SetLocalInt(oPC,"AuraDiKill_CURRENT",1);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
        AuraDiKill(oPC,nTime,lLocation,nMetamagic,nCasterLvl);
    }
    else{
        if(AuraDiKill_CURRENT != 999999){
            SetLocalInt(oPC,"AuraDiKill_CURRENT",999999);
            effect eAOE = EffectAreaOfEffect(AOE_PER_FOGKILL,"fakespell","fakespell","fakespell");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lLocation, fTime);
            DelayCommand(6.1,SetLocalInt(oPC,"AuraDiKill_CURRENT",1));
            DelayCommand(6.2,AuraDiKill(oPC,nTime,lLocation,nMetamagic,nCasterLvl));
        }
    }
}
