/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 25-06-2009
*/

// Totem delle Trasformazioni torna normale.

void main()
{
    object oPC = OBJECT_SELF;
    int eEffectType;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)){
        eEffectType = GetEffectType(eLoop);
        if (eEffectType != EFFECT_TYPE_ABILITY_DECREASE &&
            eEffectType != EFFECT_TYPE_CONFUSED&&
            eEffectType != EFFECT_TYPE_DAZED &&
            eEffectType != EFFECT_TYPE_FRIGHTENED &&
            eEffectType != EFFECT_TYPE_SILENCE &&
            eEffectType != EFFECT_TYPE_SLOW &&
            eEffectType != EFFECT_TYPE_SLEEP &&
            eEffectType != EFFECT_TYPE_ENTANGLE &&
            eEffectType != EFFECT_TYPE_DOMINATED &&
            eEffectType != EFFECT_TYPE_DISEASE &&
            eEffectType != EFFECT_TYPE_ATTACK_DECREASE &&
            eEffectType != EFFECT_TYPE_DAMAGE_DECREASE &&
            eEffectType != EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE &&
            eEffectType != EFFECT_TYPE_SAVING_THROW_DECREASE &&
            eEffectType != EFFECT_TYPE_SPELL_RESISTANCE_DECREASE &&
            eEffectType != EFFECT_TYPE_SKILL_DECREASE &&
            eEffectType != EFFECT_TYPE_BLINDNESS &&
            eEffectType != EFFECT_TYPE_DEAF &&
            eEffectType != EFFECT_TYPE_TURNED &&
            eEffectType != EFFECT_TYPE_PETRIFY &&
            eEffectType != EFFECT_TYPE_STUNNED &&
            eEffectType != EFFECT_TYPE_POISON &&
            eEffectType != EFFECT_TYPE_PARALYZE &&
            eEffectType != EFFECT_TYPE_NEGATIVELEVEL &&
            eEffectType != EFFECT_TYPE_CURSE &&
            eEffectType != EFFECT_TYPE_DISEASE){
            RemoveEffect(oPC,eLoop);
        }
        eLoop=GetNextEffect(oPC);
    }
    if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID||
    GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID){
        object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
        DestroyObject(oSkinOld,0.0);
        SetLocalInt(oPC,"poly_ability",89);
        if(GetItemPossessedBy(oPC,"hlslang_1")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ELF);
        else if(GetItemPossessedBy(oPC,"hlslang_5")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ORC);
        else if(GetItemPossessedBy(oPC,"hlslang_2")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GNOME);
        else if(GetItemPossessedBy(oPC,"hlslang_3")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALFLING);
        else if(GetItemPossessedBy(oPC,"hlslang_4")!=OBJECT_INVALID)
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DWARF);
        else
            SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ELF);
        DeleteLocalInt(oPC,"AuraDiZombie_CURRENT");
        DeleteLocalInt(oPC,"AuraDiFear_CURRENT");
        DeleteLocalString(oPC,"AuraDiFear_IMMUNI");
        DeleteLocalInt(oPC,"AuraDiMutaM_CURRENT");
        DeleteLocalInt(oPC,"AuraDiMutaG_CURRENT");
        DeleteLocalInt(oPC,"AuraDiMutaE_CURRENT");
        DeleteLocalInt(oPC,"AuraDiTerra_CURRENT");
        DeleteLocalInt(oPC,"AuraDiElettro_CURRENT");
        DeleteLocalInt(oPC,"AuraDiFuoco_CURRENT");
        DeleteLocalInt(oPC,"AuraDiFreddo_CURRENT");
        DeleteLocalInt(oPC,"AuraDiDrago_CURRENT");
        DeleteLocalString(oPC,"AuraDiDrago_IMMUNI");
        DeleteLocalInt(oPC,"AuraDiMorte_CURRENT");
        DeleteLocalString(oPC,"AuraDiMorte_IMMUNI");
        DeleteLocalInt(oPC,"AuraDiAcceca_CURRENT");
        DeleteLocalString(oPC,"AuraDiAcceca_IMMUNI");
        SetLocalInt(oPC,"poly_weaponr",0);
        SetLocalInt(oPC,"poly_weaponm",0);
        SetLocalInt(oPC,"poly_shield",0);
        object oSkin = CreateItemOnObject("poly_base",oPC);
        AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR));
    }
}
