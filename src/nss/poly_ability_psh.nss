/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 29-06-2009
*/

// Scudo Prismatico.

#include "NW_I0_SPELLS"

void main()
{
    //Declare major variables
    object oPC = OBJECT_SELF;
    int nAge = GetLevelByClass(CLASS_TYPE_DRAGON,oPC);
    int nSag = GetAbilityModifier(ABILITY_WISDOM,oPC);
    int fDelay=20;
    object oTarget;
    int oShield = GetLocalInt(oPC,"poly_ability_psh");
    if(oShield == 0){
        effect eVis = EffectVisualEffect(VFX_DUR_AURA_PULSE_MAGENTA_BLACK);
        effect ColdShield = EffectDamageShield(0,DAMAGE_BONUS_10,DAMAGE_TYPE_COLD);
        ColdShield = EffectLinkEffects(eVis,ColdShield);
        effect AcidShield = EffectDamageShield(0,DAMAGE_BONUS_10,DAMAGE_TYPE_ACID);
        effect FireShield = EffectDamageShield(0,DAMAGE_BONUS_10,DAMAGE_TYPE_FIRE);
        effect SonicShield = EffectDamageShield(0,DAMAGE_BONUS_10,DAMAGE_TYPE_SONIC);
        effect ElettricShield = EffectDamageShield(0,DAMAGE_BONUS_10,DAMAGE_TYPE_ELECTRICAL);
        DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ColdShield, oPC,RoundsToSeconds(fDelay)));
        DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, AcidShield, oPC,RoundsToSeconds(fDelay)));
        DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, FireShield, oPC,RoundsToSeconds(fDelay)));
        DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SonicShield, oPC,RoundsToSeconds(fDelay)));
        DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ElettricShield, oPC,RoundsToSeconds(fDelay)));
        DelayCommand(RoundsToSeconds(fDelay),SetLocalInt(oPC,"poly_ability_psh",0));
    }
    SetLocalInt(oPC,"poly_ability_psh",1);
    PlayDragonBattleCry();
}


