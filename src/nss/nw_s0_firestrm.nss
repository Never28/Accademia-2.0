//::///////////////////////////////////////////////
//:: Fire Storm
//:: NW_S0_FireStm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a zone of destruction around the caster
    within which all living creatures are pummeled
    with fire.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001
#include "mod_bad_dice"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDamage2;
    int Division;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eFireStorm = EffectVisualEffect(VFX_FNF_FIRESTORM);
    float fDelay;
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while(GetIsObjectValid(oTarget)){
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF){
                fDelay = GetRandomDelay(1.5, 2.5);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                    nDamage = nNumberRandom(7,nCasterLevel*2);
                    if (nMetaMagic == METAMAGIC_EMPOWER)
                        nDamage = nDamage + (nDamage/2);
                    float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
                    nDamage = FloatToInt(fDamage);
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
                    effect eDivine = EffectDamage(nDamage/2, DAMAGE_TYPE_DIVINE);
                    effect eFire = EffectDamage(nDamage/2, DAMAGE_TYPE_FIRE);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivine, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
