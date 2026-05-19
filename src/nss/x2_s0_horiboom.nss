//::///////////////////////////////////////////////
//:: Horizikaul's Boom
//:: X2_S0_HoriBoom
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// You blast the target with loud and high-pitched
// sounds. The target takes 1d4 points of sonic
// damage per two caster levels (maximum 5d4) and
// must make a Will save or be deafened for 1d4
// rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 22, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs, 02/06/2003

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


    //Declare major variables  ( fDist / (3.0f * log( fDist ) + 2.0f) )
    object oTarget = GetSpellTargetObject();

    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    if(nCasterLvl<1)
        nCasterLvl = 1;
    int nRounds = d4(1);
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eDeaf = EffectDeaf();


    int nSave = SAVING_THROW_TYPE_FIRE;
    int nType = DAMAGE_TYPE_SONIC;
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
            nBonus = 20;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }

    //Minimum caster level of 1, maximum of 15.
    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
    {
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
            //Roll damage
               int nDam;
                nDam = nNumberRandom(3,nCasterLvl);
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                     nDam = 3 * nCasterLvl;//Damage is at max
                }
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nDam = nDam + (nDam/2); //Damage/Healing is +50%
                }
                nDam = nDam + nBonus;
                float fDamage = (IntToFloat(nDam)/100.0)*30.0;
                nDam = FloatToInt(fDamage);

            effect eDam = EffectDamage(nDam, nType);
            //Apply the MIRV and damage effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeaf, oTarget, RoundsToSeconds(nRounds));
            }
        }
    }
}
