//::///////////////////////////////////////////////
//:: Horrid Wilting
//:: NW_S0_HorrWilt
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All living creatures (not undead or constructs)
    suffer 1d8 damage per caster level to a maximum
    of 25d8 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 12 , 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

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
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    nCasterLvl = nCasterLvl;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_HORRID_WILTING);
    effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
    effect eDam;

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

    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    //Apply the horrid wilting explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
        // GZ: Not much fun if the caster is always killing himself
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HORRID_WILTING));
            //Get the distance between the explosion and the target to calculate delay
            fDelay = GetRandomDelay(1.5, 2.5);
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                int nAspect = GetAppearanceType(oTarget);
                if(GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT && GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD && nAspect != APPEARANCE_TYPE_SKELETON_CHIEFTAIN &&
      nAspect != APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 && nAspect != APPEARANCE_TYPE_MOHRG && nAspect != APPEARANCE_TYPE_MUMMY_GREATER
      && nAspect != APPEARANCE_TYPE_VAMPIRE_MALE && nAspect != APPEARANCE_TYPE_VAMPIRE_FEMALE && nAspect != APPEARANCE_TYPE_LICH
      && nAspect != APPEARANCE_TYPE_MINDFLAYER_ALHOON && nAspect != APPEARANCE_TYPE_DEMI_LICH && nAspect!= APPEARANCE_TYPE_GOLEM_BONE
      && nAspect != APPEARANCE_TYPE_DRACOLICH)
                {
                    //Roll damage for each target
                    nDamage = d8 (nCasterLvl *2);
                    //Resolve metamagic
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nDamage = 16 * nCasterLvl;
                    }
                    else if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                       nDamage = nDamage + nDamage / 2;
                    }
                    float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                    nDamage = FloatToInt(fDamage);
                    if(/*Fort Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                    {
                        nDamage = nDamage/2;
                    }
                    //Set the damage effect
                    eDam = EffectDamage(nDamage, nType);
                    // Apply effects to the currently selected target.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
             }
        }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget);
    }
}
