//::///////////////////////////////////////////////
//:: Meteor Swarm
//:: NW_S0_MetSwarm
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Everyone in a 50ft radius around the caster
    takes 20d6 fire damage.  Those within 6ft of the
    caster will take no damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 24 , 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

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

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();

    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    nCasterLevel = nCasterLevel;
    //Declare major variables
    int nMetaMagic;
    int nDamage;
    effect eFire;

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
            nBonus = 100;
            break;
    }
    effect eMeteor = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Apply the meteor swarm VFX area impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMeteor, GetLocation(OBJECT_SELF));
    //Get first object in the spell area
    float fDelay;
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            fDelay = GetRandomDelay();
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_METEOR_SWARM));
            //Make sure the target is outside the 2m safe zone
            if (GetDistanceBetween(oTarget, OBJECT_SELF) > 2.0)
            {
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget, 0.5))
                {
                      nDamage = nNumberRandom(9,nCasterLevel*2);
                      //Enter Metamagic conditions
                      if (nMetaMagic == METAMAGIC_MAXIMIZE)
                      {
                         nDamage = 8*nCasterLevel;//Damage is at max
                      }
                      if (nMetaMagic == METAMAGIC_EMPOWER)
                      {
                         nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
                      }
                      nDamage = nDamage + nBonus;
                      float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                      nDamage = FloatToInt(fDamage);
                      nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC,nSave);
                      //Set the damage effect
                      eFire = EffectDamage(nDamage, nType);
                      if(nDamage > 0)
                      {
                          //Apply damage effect and VFX impact.
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                          DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                      }
                 }
            }
        }
        //Get next target in the spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

