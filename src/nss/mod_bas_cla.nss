/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 15-07-2009
*/

// La funzione per le Pietre le Nuove Classi di prestigio!

void main()
{
    object oPC = OBJECT_SELF;
    // TEMPESTA -> RANGER 40
    if (GetItemPossessedBy(oPC,"mod_clas_tm")!=OBJECT_INVALID){
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectModifyAttacks(4),oPC);
        SetLocalInt(oPC,"class_special",1);
    }
    // ARCIMAGO -> MAGO 40
    else if (GetItemPossessedBy(oPC,"mod_clas_ma")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // GEROFANTE -> CHIERICO 40
    else if (GetItemPossessedBy(oPC,"mod_clas_gf")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Druido Licantropo -> Druido 40
    else if (GetItemPossessedBy(oPC,"mod_clas_sa")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Maestro dello Stile dell'Ubriaco -> Monaco 40
    else if (GetItemPossessedBy(oPC,"mod_clas_mu")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Sapiente Elementale -> Stregone 40
    else if (GetItemPossessedBy(oPC,"mod_clas_se")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Colosso Leggendario -> Barbaro 40
    else if (GetItemPossessedBy(oPC,"mod_clas_cl")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Infiltratore Epico -> Ladro 40
    else if (GetItemPossessedBy(oPC,"mod_clas_ie")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Artista -> Bardo 40
    else if (GetItemPossessedBy(oPC,"mod_clas_ar")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Spia -> Assassino 30
    else if (GetItemPossessedBy(oPC,"mod_clas_si")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Spettro Perfetto -> Ombra 30
    else if (GetItemPossessedBy(oPC,"mod_clas_so")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Cacciatore di Non Morti -> Paladino 40
    else if (GetItemPossessedBy(oPC,"mod_clas_cn")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Araldo Divino (MALE) -> Guardia Nera 30
    else if (GetItemPossessedBy(oPC,"mod_clas_a1")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Araldo Divino (BENE) -> Campione di Torm 30
    else if (GetItemPossessedBy(oPC,"mod_clas_a2")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Maestro Esangue -> Signore Pallido 30
    else if (GetItemPossessedBy(oPC,"mod_clas_me")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Difensore Devoto -> Difensore Nanesco 30
    else if (GetItemPossessedBy(oPC,"mod_clas_do")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Erede Draconico -> Discepolo del Drago 30
    else if (GetItemPossessedBy(oPC,"mod_clas_ed")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Trasformista -> Mutaforma 30
    else if (GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Protettore Tribale -> Guerriero 40
    else if (GetItemPossessedBy(oPC,"mod_clas_gl")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Cavaliere -> Cavaliere dei Draghi Purpurei 30
    else if (GetItemPossessedBy(oPC,"mod_clas_cv")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
    // Alchimista -> Esploratore Arpista 30
    else if (GetItemPossessedBy(oPC,"mod_clas_al")!=OBJECT_INVALID){
        SetLocalInt(oPC,"class_special",1);
    }
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
