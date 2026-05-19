//::///////////////////////////////////////////////
//:: Mestil's Acid Breath
//:: X2_S0_AcidBrth
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// You breathe forth a cone of acidic droplets. The
// cone inflicts 1d6 points of acid damage per caster
// level (maximum 10d6).
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov, 22 2002
//:://////////////////////////////////////////////

//float SpellDelay (object oTarget, int nShape);

#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int Aspect = GetAppearanceType(OBJECT_SELF);
    int nSave = SAVING_THROW_TYPE_ACID;
    int nType = DAMAGE_TYPE_ACID;
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
            break;
    }
    if(Aspect == APPEARANCE_TYPE_BEETLE_STAG){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,GetAreaOfEffectCreator());
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,GetAreaOfEffectCreator());

        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        if (nMutaLv >= 1){
            nDC = 10 + nSag + nMutaLv;
        }
        nCasterLevel=nDruidLv;
    }
    else{
        nDC = GetSpellSaveDC();
        if(nCasterLevel>20)
            nDC = nDC +5;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
    //Limit Caster level for the purposes of damage.

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Get the distance between the target and caster to delay the application of effects
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20.0;
            //Make SR check, and appropriate saving throw(s).
            if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay) && (oTarget != OBJECT_SELF))
            {
                    nDamage = nNumberRandom(3,nCasterLevel*2);
                    //Resolve metamagic
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 6 * nCasterLevel;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage / 2;
                    }
                    nDamage = nDamage + nBonus;
                    float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                    nDamage = FloatToInt(fDamage);
                //Adjust damage according to Reflex Save, Evasion or Improved Evasion
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSave);

                // Apply effects to the currently selected target.
                effect eAcid = EffectDamage(nDamage, nType);
                effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);
                if(nDamage > 0)
                {
                    //Apply delayed effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

