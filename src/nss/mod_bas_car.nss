/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-07-2009
*/

// La funzione per le Pietre di Caratteristica!

void main()
{
    object oPC = OBJECT_SELF;
    if (GetItemPossessedBy(oPC,"car_str")!=OBJECT_INVALID){
        SetLocalInt(oPC,"car_ability",1);
        ExecuteScript("mod_bas_car_for",oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_RED)),oPC);
    }
    else if (GetItemPossessedBy(oPC,"car_dex")!=OBJECT_INVALID){
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectConcealment(10,MISS_CHANCE_TYPE_NORMAL)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE)),oPC);
    }
    else if (GetItemPossessedBy(oPC,"car_con")!=OBJECT_INVALID){
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectRegenerate(8,6.0)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,15)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,15)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,15)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_RED)),oPC);
    }
    else if (GetItemPossessedBy(oPC,"car_int")!=OBJECT_INVALID){
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE)),oPC);
    }
    else if (GetItemPossessedBy(oPC,"car_wis")!=OBJECT_INVALID){
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectSpellResistanceIncrease(40)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN)),oPC);
    }
    else if (GetItemPossessedBy(oPC,"car_cha")!=OBJECT_INVALID){
        SetLocalInt(oPC,"car_ability",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectDamageShield(10,DAMAGE_BONUS_10,DAMAGE_TYPE_POSITIVE)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect (EffectVisualEffect(VFX_DUR_IOUNSTONE_GREEN)),oPC);
    }
}
