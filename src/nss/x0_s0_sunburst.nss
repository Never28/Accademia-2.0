//::///////////////////////////////////////////////
//:: Sunburst
//:: X0_S0_Sunburst
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
// Brilliant globe of heat
// All creatures in the globe are blinded and
// take 6d6 damage
// Undead creatures take 1d6 damage (max 25d6)
// The blindness is permanent unless cast to remove it
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 23 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 14, 2003
//:: Notes: Changed damage to non-undead to 6d6
//:: 2003-10-09: GZ Added Subrace check for vampire special case, bugfix

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

float nSize =  RADIUS_SIZE_COLOSSAL;



void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = 0;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    effect eHitVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_FIRE);
    effect eLOS = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    int nCasterLevel= GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eLOS, GetSpellTargetLocation());
    int bDoNotDoDamage = FALSE;

    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_MAGICAL;
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
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SUNBURST));
            //This visual effect is applied to the target object not the location as above.  This visual effect
            //represents the flame that erupts on the target not on the ground.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHitVis, oTarget);

            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                int nAspect = GetAppearanceType(oTarget);
                if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH){
                    nDamage = d8(nCasterLvl*2);
                    nDamage = nDamage + d2(nCasterLvl);
                }
                else{
                    nDamage = d6(nCasterLvl*2);
                    nDamage = nDamage + d2(nCasterLvl);
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                    nDamage = nDamage + (nDamage/2);
                   float fDamage = (IntToFloat(nDamage)/100.0)*50.0;
                nDamage = FloatToInt(fDamage);
                // * if a vampire then destroy it
                if (GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_MALE || GetAppearanceType(oTarget) == APPEARANCE_TYPE_VAMPIRE_FEMALE || GetStringLowerCase(GetSubRace(oTarget)) == "vampire" )
                {
                    // SpeakString("I vampire");
                    // * if reflex saving throw fails no blindness
                    if (!ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_SPELL))
                    {
                        effect eDead = EffectDamage(GetCurrentHitPoints(oTarget));
                        //ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), oTarget);

                        //Apply epicenter explosion on caster
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eExplode, oTarget);

                        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDead, oTarget));
                        bDoNotDoDamage = TRUE;
                    }
                }
                if (bDoNotDoDamage == FALSE)
                    //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_SPELL);

                // * Do damage
                if ((nDamage > 0) && (bDoNotDoDamage == FALSE))
                {
                    //Set the damage effect
                    eDam = EffectDamage(nDamage, nType);

                    // Apply effects to the currently selected target.
                    DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

                     // * if reflex saving throw fails apply blindness
                    if (!ReflexSave(oTarget, nDC, SAVING_THROW_TYPE_SPELL))
                    {
                        effect eBlindness = EffectBlindness();
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBlindness, oTarget);
                    }
                } // nDamage > 0
             }

             //-----------------------------------------------------------------
             // GZ: Bugfix, reenable damage for next object
             //-----------------------------------------------------------------
             bDoNotDoDamage = FALSE;
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, nSize, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}

