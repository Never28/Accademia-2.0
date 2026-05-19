/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione per dare la prima volta le classi.

void main()
{
    object oPC = OBJECT_SELF;

    // ITEM guardia NERA PER FURIA DIVINA
    if (GetItemPossessedBy(oPC,"mod_clas_bg")==OBJECT_INVALID && GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)>=5)
        CreateItemOnObject("mod_clas_bg",oPC);

    // ITEM Signore PALLIDO
    else if (GetItemPossessedBy(oPC,"mod_clas_sp")==OBJECT_INVALID&&GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC)>=10){
        CreateItemOnObject("mod_clas_sp",oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,100)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE,100)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE,100)),oPC);
        SetLocalInt(oPC,"class_special",1);
    }
    // ITEM ESPLORATORE ARPISTA
    else if(GetItemPossessedBy(oPC,"mod_clas_har_2")==OBJECT_INVALID&&GetItemPossessedBy(oPC,"mod_clas_har_1")==OBJECT_INVALID&&GetLevelByClass(CLASS_TYPE_HARPER,oPC)>=5){
        CreateItemOnObject("mod_clas_har_1",oPC);
        CreateItemOnObject("mod_clas_har_2",oPC);
    }
/*
    // TEMPESTA -> RANGER 40
    else if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=40){
        CreateItemOnObject("mod_clas_tm",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_tm",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // ARCIMAGO -> MAGO 40
    else if(GetLevelByClass(CLASS_TYPE_WIZARD,oPC)>=40){
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_TRANSMUTATION,oPC)==TRUE)
            CreateItemOnObject("mod_clas_ma",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ABJURATION,oPC)==TRUE && GetSkillRank(SKILL_SPELLCRAFT,oPC,TRUE)==43)
            CreateItemOnObject("mod_clas_ma1",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_CONJURATION,oPC)==TRUE)
            CreateItemOnObject("mod_clas_ma2",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY,oPC)==TRUE)
            CreateItemOnObject("mod_clas_ma3",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT,oPC)==TRUE && GetSkillRank(SKILL_LORE,oPC,TRUE)==43)
            CreateItemOnObject("mod_clas_ma5",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ILLUSION,oPC)==TRUE)
            CreateItemOnObject("mod_clas_ma4",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_EVOCATION,oPC)==TRUE)
            CreateItemOnObject("mod_clas_ma6",oPC);
        if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_DIVINATION,oPC)==TRUE && GetSkillRank(SKILL_SPELLCRAFT,oPC,TRUE)==43)
            CreateItemOnObject("mod_clas_ma7",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_ma",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // GEROFANTE -> CHIERICO 40
    else if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)>=40){
        CreateItemOnObject("mod_clas_gf",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_gf",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Signore Verd -> Druido 40
    else if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)>=40){
        CreateItemOnObject("mod_clas_sa",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_sa",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Maestro dello Stile dell'Ubriaco -> Monaco 40
    else if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>=40){
        CreateItemOnObject("mod_clas_mu",oPC);
        CreateItemOnObject("mod_clas_mu1",oPC);
        CreateItemOnObject("mod_clas_mu2",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_mu",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Sapiente Elementale -> Stregone 40
    else if(GetLevelByClass(CLASS_TYPE_SORCERER,oPC)>=40){
        CreateItemOnObject("mod_clas_se",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_se",oPC);
        SetLocalLocation(oPC,"mod_return",GetLocation(oPC));
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
        ExecuteScript("mod_pc_levelup_s",oPC);
    }

    // Colosso Leggendario -> Barbaro 40
    else if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)>=40){
        CreateItemOnObject("mod_clas_cl",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_cl",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Infiltratore Epico -> Ladro 40
    else if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>=40){
        CreateItemOnObject("mod_clas_ie",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_ie",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Artista -> Bardo 40
    else if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>=40){
        CreateItemOnObject("mod_clas_ar",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_ar",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Spia -> Assassino 30
    else if(GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC)>=30){
        CreateItemOnObject("mod_clas_si",oPC);
        CreateItemOnObject("mod_clas_si1",oPC);
        CreateItemOnObject("mod_clas_si2",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_si",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Spettro Perfetto -> Ombra 30
    else if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC)>=30){
        CreateItemOnObject("mod_clas_so",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_so",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Cacciatore di Non Morti -> Paladino 40
    else if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=40){
        CreateItemOnObject("mod_clas_cn",oPC);
        CreateItemOnObject("mod_clas_cn2",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_cn",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Araldo Divino (MALE) -> Guardia Nera 30
    else if(GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)>=30){
        CreateItemOnObject("mod_clas_a1",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_a1",oPC);
        SetCreatureWingType(CREATURE_WING_TYPE_DEMON,oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Araldo Divino (BENE) -> Campione di Torm 30
    else if(GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC)>=30){
        CreateItemOnObject("mod_clas_a2",oPC);
        SetCreatureWingType(CREATURE_WING_TYPE_ANGEL,oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_a2",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Maestro Esangue -> Signore Pallido 30
    else if(GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC)>=30){
        CreateItemOnObject("mod_clas_me",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_me",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Difensore Devoto -> Difensore Nanesco 30
    else if(GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER,oPC)>=30){
        CreateItemOnObject("mod_clas_do",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_do",oPC);
        CreateItemOnObject("mod_clas_do1",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Erede Draconico -> Discepolo del Drago 30
    else if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>=30){
        CreateItemOnObject("mod_clas_ed",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_ed",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Trasformista -> Mutaforma 30
    else if(GetLevelByClass(CLASS_TYPE_SHIFTER,oPC)>=30){
        CreateItemOnObject("mod_clas_tt",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_tt",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Protettore Tribale -> Guerriero 40
    else if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)>=40){
        CreateItemOnObject("mod_clas_gl",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_gl",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Lanciere -> Cavaliere dei Draghi Purpurei 30
    else if(GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC)==5&&GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)==35&&GetSkillRank(SKILL_RIDE,oPC,FALSE)==43){
        CreateItemOnObject("mod_clas_cv",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_cv",oPC);
        CreateItemOnObject("mod_clas_cv2",oPC);
        CreateItemOnObject("mod_clas_cv3",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }

    // Alchimista -> Esploratore Arpista 30
    else if(GetLevelByClass(CLASS_TYPE_HARPER,oPC)==30){
        CreateItemOnObject("mod_clas_al",oPC);
        object oSpec = CreateItemOnObject("mod_spec_clas_al",oPC);
        AssignCommand(oPC,ActionEquipItem(oSpec,INVENTORY_SLOT_CWEAPON_R));
        SetLocalInt(oPC,"class_special",1);
    }
  */
    //Disattivare del LADRO
    if((GetLevelByClass(CLASS_TYPE_RANGER,oPC)>0||GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>0||GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC)>0) && GetItemPossessedBy(oPC,"trap_disable")==OBJECT_INVALID)
        CreateItemOnObject("trap_disable",oPC);

    //CANZONI DEL BARDO
    if (GetItemPossessedBy(oPC,"mod_clas_songsle")==OBJECT_INVALID && GetLevelByClass(CLASS_TYPE_BARD,oPC)>=1)
        CreateItemOnObject("mod_clas_songsle",oPC);
    if (GetItemPossessedBy(oPC,"mod_clas_songcon")==OBJECT_INVALID && GetLevelByClass(CLASS_TYPE_BARD,oPC)>=10)
        CreateItemOnObject("mod_clas_songcon",oPC);
    if (GetItemPossessedBy(oPC,"mod_clas_songcha")==OBJECT_INVALID && GetLevelByClass(CLASS_TYPE_BARD,oPC)>=20)
        CreateItemOnObject("mod_clas_songcha",oPC);
    if (GetItemPossessedBy(oPC,"mod_clas_songfea")==OBJECT_INVALID && GetLevelByClass(CLASS_TYPE_BARD,oPC)==40)
        CreateItemOnObject("mod_clas_songfea",oPC);
}
