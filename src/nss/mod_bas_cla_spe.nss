/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 15-07-2009
*/

// La funzione per le Pietre le Nuove Classi di prestigio!

void main()
{
    object oPC = OBJECT_SELF;
    if (GetItemPossessedBy(oPC,"mod_clas_sp")!=OBJECT_INVALID){
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,100)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE,100)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE,100)),oPC);
        SetLocalInt(oPC,"class_special",1);
    }
    if (GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>=10){

        if(GetItemPossessedBy(oPC,"mod_clas_drbla")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drgre")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drblu")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drwhi")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drarg")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drbro")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drott")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drred")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_droro")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,100)),oPC);
        }
        else if(GetItemPossessedBy(oPC,"mod_clas_drram")!=OBJECT_INVALID){
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100)),oPC);
        }
        SetLocalInt(oPC,"class_special",1);
    }
}
