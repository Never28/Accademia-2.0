//::///////////////////////////////////////////////
//:: Delayed Blast Fireball: On Enter
//:: NW_S0_DelFireA.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The caster creates a trapped area which detects
    the entrance of enemy creatures into 3 m area
    around the spell location.  When tripped it
    causes a fiery explosion that does 1d6 per
    caster level up to a max of 20d6 damage.
*/
//:://////////////////////////////////////////////
//:: Georg: Removed Spellhook, fixed damage cap
//:: Created By: Preston Watamaniuk
//:: Created On: July 27, 2001
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    int nLevel = GetCasterLevel(GetAreaOfEffectCreator());
    int nDC = GetSpellSaveDC();
    if(GetHitDice(GetAreaOfEffectCreator())==40)
        nDC = nDC +5;
    else if(GetHitDice(GetAreaOfEffectCreator())>=31)
        nDC = nDC +3;
    else if(GetHitDice(GetAreaOfEffectCreator())>=21)
        nDC = nDC +2;
    else if(GetHitDice(GetAreaOfEffectCreator())>=11)
        nDC = nDC +1;
    //Declare major variables
    object oTarget = GetEnteringObject();
    object oCaster = GetAreaOfEffectCreator();
    location lTarget = GetLocation(OBJECT_SELF);
    int nDamage;
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oCaster);
    int nFire = GetLocalInt(OBJECT_SELF, "NW_SPELL_DELAY_BLAST_FIREBALL");

    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_FIRE;
    int nBonus;
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
            nBonus = 80;
            break;
    }

    effect eDam;
    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    //Check the faction of the entering object to make sure the entering object is not in the casters faction
    if(nFire == 0)
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            SetLocalInt(OBJECT_SELF, "NW_SPELL_DELAY_BLAST_FIREBALL",TRUE);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
            //Cycle through the targets in the explosion area
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            while(GetIsObjectValid(oTarget))
            {
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
                {
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(oCaster, SPELL_DELAYED_BLAST_FIREBALL));
                    //Make SR check
                    if (!MyResistSpell(oCaster, oTarget))
                    {
                        nDamage = d6(nCasterLevel*2);
                        nDamage = nDamage+d2(nCasterLevel);
                        //Enter Metamagic conditions
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        {
                            nDamage = 14 * nCasterLevel;//Damage is at max
                        }
                        else if (nMetaMagic == METAMAGIC_EMPOWER)
                        {
                            nDamage = nDamage + (nDamage/2);//Damage/Healing is +50%
                        }
                        nDamage = nDamage + nBonus;
                float fDamage = (IntToFloat(nDamage)/100.0)*75.0;
                nDamage = FloatToInt(fDamage);
                        //Change damage according to Reflex, Evasion and Improved Evasion
                        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE, GetAreaOfEffectCreator());
                        //Set up the damage effect
                        eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                        if(nDamage > 0)
                        {
                            //Apply VFX impact and damage effect
                            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                            DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        }
                    }
                }
                //Get next target in the sequence
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            }
            DestroyObject(OBJECT_SELF, 1.0);
        }
    }
}
