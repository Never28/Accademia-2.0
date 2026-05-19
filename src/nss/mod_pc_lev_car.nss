/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione per dare la prima volta le pietre.

void main()
{
    object oPC = OBJECT_SELF;
    if (GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE) > 31 && (GetItemPossessedBy(oPC,"car_str")==OBJECT_INVALID)){
        CreateItemOnObject("car_str",oPC);
        SetLocalInt(oPC,"car_ability",1);
        ExecuteScript("mod_bas_car_for",oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_RED)),oPC);
    }
    else if (GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE) > 31 && (GetItemPossessedBy(oPC,"car_con")==OBJECT_INVALID)){
        CreateItemOnObject("car_con",oPC);
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectRegenerate(8,6.0)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,15)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,15)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,15)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_RED)),oPC);
    }
    else if (GetAbilityScore(oPC,ABILITY_DEXTERITY,TRUE) > 31 && (GetItemPossessedBy(oPC,"car_dex")==OBJECT_INVALID)){
        CreateItemOnObject("car_dex",oPC);
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectConcealment(10,MISS_CHANCE_TYPE_NORMAL)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE)),oPC);
    }
    else if (GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE) > 31 && (GetItemPossessedBy(oPC,"car_int")==OBJECT_INVALID)){
        CreateItemOnObject("car_int",oPC);
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE)),oPC);
    }
    else if (GetAbilityScore(oPC,ABILITY_WISDOM,TRUE) > 31 && (GetItemPossessedBy(oPC,"car_wis")==OBJECT_INVALID)){
        CreateItemOnObject("car_wis",oPC);
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectSpellResistanceIncrease(50)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN)),oPC);
    }
    else if (GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE) > 31 && (GetItemPossessedBy(oPC,"car_cha")==OBJECT_INVALID)){
        CreateItemOnObject("car_cha",oPC);
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectDamageShield(10,DAMAGE_BONUS_10,DAMAGE_TYPE_POSITIVE)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN)),oPC);
    }
}
