//::///////////////////////////////////////////////
//:: Weird
//:: NW_S0_Weird
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All enemies in LOS of the spell must make 2 saves or die.
    Even IF the fortitude save is succesful, they will still take
    3d6 damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: DEc 14 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 10, 2001
//:: VFX Pass By: Preston W, On: June 27, 2001

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


    //Declare major variables
    object oTarget;
    effect eDam;
    object oCaster = OBJECT_SELF;
    int nCasterLevel = GetCasterLevel(oCaster);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        if (nMutaLv >= 1){
            nDC = 10 + nSag + nMutaLv;
        }
        nCasterLevel= nDruidLv;
    }
    else{
        nDC = GetSpellSaveDC();
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
        else if(GetHitDice(OBJECT_SELF)>=31)
            nDC = nDC +3;
        else if(GetHitDice(OBJECT_SELF)>=21)
            nDC = nDC +2;
        else if(GetHitDice(OBJECT_SELF)>=11)
            nDC = nDC +1;
    }
    int nSave = SAVING_THROW_TYPE_ELECTRICITY;
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
    //Declare major variables
    int nDamage;
    nDamage = nNumberRandom(9,nCasterLevel*2);
    float fDamage = (IntToFloat(nDamage)/100.0)*20.0;
    nDamage = FloatToInt(fDamage);
    effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
    effect eVis2 = EffectVisualEffect(VFX_IMP_DEATH);
    effect eWeird = EffectVisualEffect(VFX_FNF_WEIRD);
    effect eAbyss = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;

    //Apply the FNF VFX impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWeird, GetSpellTargetLocation());
    //Get the first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation(), TRUE);
    while (GetIsObjectValid(oTarget))
    {
        //Make a faction check
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF))
        {
               fDelay = GetRandomDelay(3.0, 4.0);
               //Fire cast spell at event for the specified target
               SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WEIRD));
               //Make an SR Check
               if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
               {
                    if ( !GetIsImmune(oTarget, IMMUNITY_TYPE_MIND_SPELLS,OBJECT_SELF) &&
                         !GetIsImmune(oTarget, IMMUNITY_TYPE_FEAR,OBJECT_SELF))
                    {
                        if(GetHitDice(oTarget) >= 4)
                        {
                            //Make a Will save against mind-affecting
                            if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS, OBJECT_SELF, fDelay))
                            {
                                //Make a fortitude save against death
                                if(MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_DEATH, OBJECT_SELF, fDelay))
                                {
                                    // * I made my saving throw but I still have to take the 3d6 damage

                                    //Roll damage
                                    //Make metamagic check
                                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                                    {
                                        nDamage = 18;
                                    }
                                    if (nMetaMagic == METAMAGIC_EMPOWER)
                                    {
                                        nDamage = FloatToInt( IntToFloat(nDamage) * 1.5 );
                                    }
                                    //Set damage effect
                                    eDam = EffectDamage(nDamage, nType);
                                    //Apply VFX Impact and damage effect
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                                }
                                else
                                {
                                    // * I failed BOTH saving throws. Now I die.


                                    //Apply VFX impact and death effect
                                    //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                                    effect eDeath = EffectDeath();
                                    // Need to make this supernatural, so that it ignores death immunity.
                                    eDeath = SupernaturalEffect( eDeath );
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                                }
                            } // Will save
                        }
                        else
                        {
                            // * I have less than 4HD, I die.

                            //Apply VFX impact and death effect
                            //DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                            effect eDeath = EffectDeath();
                            // Need to make this supernatural, so that it ignores death immunity.
                            eDeath = SupernaturalEffect( eDeath );
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                        }
                    }
               }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation(), TRUE);
    }
}
