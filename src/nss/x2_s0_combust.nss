//::///////////////////////////////////////////////
//:: Combust
//:: X2_S0_Combust
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
   The initial eruption of flame causes  2d6 fire damage +1
   point per caster level(maximum +10)
   with no saving throw.

   Further, the creature must make
   a Reflex save or catch fire taking a further 1d6 points
   of damage. This will continue until the Reflex save is
   made.

   There is an undocumented artificial limit of
   10 + casterlevel rounds on this spell to prevent
   it from running indefinitly when used against
   fire resistant creatures with bad saving throws

*/
//:://////////////////////////////////////////////
// Created: 2003/09/05 Georg Zoeller
//:://////////////////////////////////////////////

#include "x2_I0_SPELLS"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"

void RunCombustImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic,int nType, int nSave,int nBonus);

void main()
{

    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_FIRE;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
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
            nBonus = 30;
            break;
    }
    if (!X2PreSpellCastCode())
        return;
    int nLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nDamage = d2(nLevel*2);
    if (nDamage < 1)
        nDamage = 1;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage += 4*(nLevel);
    else{
        if (nMetaMagic == METAMAGIC_EMPOWER)
            nDamage = nDamage + (nDamage/2);
    }
    nDamage = nDamage + nBonus;
    float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
    nDamage = FloatToInt(fDamage);
    int nDuration = 10 + GetCasterLevel(OBJECT_SELF);
    if (nDuration < 1)
        nDuration = 10;
    effect eDam = EffectDamage(nDamage, nType);
    effect eDur = EffectVisualEffect(498);
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        if(!MyResistSpell(OBJECT_SELF, oTarget)){
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            TLVFXPillar(VFX_IMP_FLAME_M, GetLocation(oTarget), 5, 0.1f,0.0f, 2.0f);
            if (GetHasSpellEffect(GetSpellId(),oTarget) || GetHasSpellEffect(SPELL_INFERNO,oTarget)){
                FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
                return;
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, RoundsToSeconds(nDuration));
            SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_COMBUST), nDC);
            DelayCommand(6.0, RunCombustImpact(oTarget,oCaster,nLevel, nMetaMagic,nType,nSave,nBonus));
        }
    }
}

void RunCombustImpact(object oTarget, object oCaster, int nLevel, int nMetaMagic,int nType,int nSave,int nBonus)
{
    if (GZGetDelayedSpellEffectsExpired(SPELL_COMBUST,oTarget,oCaster))
        return;
    if (GetIsDead(oTarget) == FALSE){
        int nDC = GetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_COMBUST));
        if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, nSave)){
            int nDamage = d8(nLevel);
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
                nDamage += 8*(nLevel);
            else{
                if (nMetaMagic == METAMAGIC_EMPOWER)
                    nDamage = nDamage + (nDamage/2);
            }
            nDamage = nDamage + nBonus;
            nDamage = nDamage + nLevel;
                float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
                nDamage = FloatToInt(fDamage);
            effect eDmg = EffectDamage(nDamage,nType);
            effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
            DelayCommand(6.0f,RunCombustImpact(oTarget,oCaster, nLevel,nMetaMagic,nType,nSave,nBonus));
        }
        else{
            DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_COMBUST));
            GZRemoveSpellEffects(SPELL_COMBUST, oTarget);
        }
   }
}





