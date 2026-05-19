/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 24-06-2009
*/

// Totem delle Trasformazioni OnConversation.

void SafePolymorph(object oPC, int nRanged, int nMelee, int nShield, int nSpellFailure, string sPolyType, int nPolyType,int nNumbers)
{
    int eEffectType;
    ExecuteScript("mod_bas_car",oPC);
    ExecuteScript("mod_bas_cla_spe",oPC);
    SetLocalInt(oPC,"poly_ability",nNumbers);
    object oSkinOld = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    SetLocalInt(oPC,"poly_weaponr",nRanged);
    SetLocalInt(oPC,"poly_weaponm",nMelee);
    SetLocalInt(oPC,"poly_shield",nShield);
    DestroyObject(oSkinOld,0.0);
    SetCreatureAppearanceType(oPC,nPolyType);
    object oSkin = CreateItemOnObject(sPolyType,oPC);
    SetLocalInt(oPC,"poly_ability_psh",0);
    AssignCommand(oPC,ClearAllActions());
    if(nRanged==1&&nMelee==0){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int nRangedType = GetBaseItemType(oWeapon);
        if(nRangedType==BASE_ITEM_DART||nRangedType==BASE_ITEM_THROWINGAXE||nRangedType==BASE_ITEM_SHURIKEN||
        nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LIGHTCROSSBOW||nRangedType==BASE_ITEM_LONGBOW||
        nRangedType==BASE_ITEM_HEAVYCROSSBOW||nRangedType==BASE_ITEM_SLING)
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nRanged==1&&nMelee==1){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nRanged==0&&nMelee==1){
        object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
        int nRangedType = GetBaseItemType(oWeapon);
        if(nRangedType==BASE_ITEM_DART||nRangedType==BASE_ITEM_THROWINGAXE||nRangedType==BASE_ITEM_SHURIKEN||
        nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LIGHTCROSSBOW||nRangedType==BASE_ITEM_LONGBOW||
        nRangedType==BASE_ITEM_HEAVYCROSSBOW||nRangedType==BASE_ITEM_SLING){}
        AssignCommand(oPC,ActionUnequipItem(oWeapon));
    }
    if(nShield==1){
        object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
        AssignCommand(oPC,ActionUnequipItem(oShield));
    }
    if(nSpellFailure==1)
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellFailure(100,SPELL_SCHOOL_GENERAL),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_POLYMORPH),oPC,0.0);
    AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR));
}

void ChatTrasformation(object oPC,int iPattern)
{
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    int nMuta = GetLevelByClass(CLASS_TYPE_SHIFTER,oPC);
    int nRace = GetRacialType(oPC);
    int nSpecial = 0;
    int eEffectType;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)){
        eEffectType = GetEffectType(eLoop);
        if (eEffectType == EFFECT_TYPE_CONFUSED ||
            eEffectType == EFFECT_TYPE_DAZED ||
            eEffectType == EFFECT_TYPE_FRIGHTENED ||
            eEffectType == EFFECT_TYPE_SLEEP ||
            eEffectType == EFFECT_TYPE_ENTANGLE ||
            eEffectType == EFFECT_TYPE_DOMINATED ||
            eEffectType == EFFECT_TYPE_TURNED ||
            eEffectType == EFFECT_TYPE_PETRIFY ||
            eEffectType == EFFECT_TYPE_STUNNED ||
            eEffectType == EFFECT_TYPE_CUTSCENEIMMOBILIZE ||
            eEffectType == EFFECT_TYPE_CUTSCENE_PARALYZE ||
            eEffectType == EFFECT_TYPE_PARALYZE)
                nSpecial = 1;
        eLoop = GetNextEffect(oPC);
    }
    if(nSpecial == 0 && GetIsDead(oPC)==FALSE){
        if(GetAppearanceType(oPC)==APPEARANCE_TYPE_ELF||GetAppearanceType(oPC)==APPEARANCE_TYPE_HUMAN||
        GetAppearanceType(oPC)==APPEARANCE_TYPE_HALF_ELF||GetAppearanceType(oPC)==APPEARANCE_TYPE_HALF_ORC||
        GetAppearanceType(oPC)==APPEARANCE_TYPE_HALFLING||GetAppearanceType(oPC)==APPEARANCE_TYPE_GNOME||
        GetAppearanceType(oPC)==APPEARANCE_TYPE_DWARF){
                switch(iPattern){

                    //////////////////////////
                    //TRASFORMAZIONI ANIMALI//
                    //////////////////////////

                    //LUPO
                    case 1:
                        if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_lupo", APPEARANCE_TYPE_DOG_WOLF,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //TASSO
                    case 2:
                        if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_tasso", APPEARANCE_TYPE_BADGER,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //CINGHIALE
                    case 3:
                        if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_boar", APPEARANCE_TYPE_BOAR,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //ORSO
                    case 4:
                        if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_orso", APPEARANCE_TYPE_BEAR_BROWN,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //PANTERA
                    case 5:
                        if(GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_pante", APPEARANCE_TYPE_CAT_PANTHER,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //ORSO CRUDELE
                    case 6:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_orsoc", APPEARANCE_TYPE_BEAR_DIRE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //TASSO CRUDELE
                    case 7:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_tassoc", APPEARANCE_TYPE_BADGER_DIRE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //LUPO CRUDELE
                    case 8:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_lupoc", APPEARANCE_TYPE_DOG_DIRE_WOLF,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //PANTERA CRUDELE
                    case 9:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_pantec", APPEARANCE_TYPE_CAT_MPANTHER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //CINGHIALE CRUDELE
                    case 10:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_boarc", APPEARANCE_TYPE_BOAR_DIRE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //TIGRE LEGGENDARIA
                    case 11:
                        if(nDruidLv>=30&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_ltiger", APPEARANCE_TYPE_CAT_CAT_DIRE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //SCARABEO
                    case 12:
                        if(GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_scara", APPEARANCE_TYPE_BEETLE_STINK,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //RAGNO
                    case 13:
                        if(GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_ragno", APPEARANCE_TYPE_SPIDER_GIANT,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //SCARABEO CRUDELE
                    case 14:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_scarac", APPEARANCE_TYPE_BEETLE_STAG,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //RAGNO CRUDELE
                    case 15:
                        if(nDruidLv>=10&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_ragnoc", APPEARANCE_TYPE_SPIDER_DIRE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //RAGNO LEGGENDARIO
                    case 16:
                        if(nDruidLv>=30&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_lragno", APPEARANCE_TYPE_SPIDER_DEMON,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;

                    /////////////////////////////
                    //TRASFORMAZIONI ELEMENTALE//
                    /////////////////////////////

                    //ELEMENTALE FUOCO
                    case 17:
                        if(nDruidLv>=16)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemfuo", APPEARANCE_TYPE_ELEMENTAL_FIRE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE ACQUA
                    case 18:
                        if(nDruidLv>=16)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemacq", APPEARANCE_TYPE_ELEMENTAL_WATER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE ARIA
                    case 19:
                        if(nDruidLv>=16)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemari", APPEARANCE_TYPE_ELEMENTAL_AIR,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE TERRA
                    case 20:
                        if(nDruidLv>=16)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemter", APPEARANCE_TYPE_ELEMENTAL_EARTH,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE FUOCO ANZIANO
                    case 21:
                        if(nDruidLv>=30)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemfuo", APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE ACQUA ANZIANO
                    case 22:
                        if(nDruidLv>=30)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemacq", APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE ARIA ANZIANO
                    case 23:
                        if(nDruidLv>=30)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemari", APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                    //ELEMENTALE TERRA ANZIANO
                    case 24:
                        if(nDruidLv>=30)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_elemter", APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;

                    ////////////////////////////
                    //TRASFORMAZIONI DRAGHETTO//
                    ////////////////////////////

                    //DRAGHETTO ROSSO
                    case 25:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakered", APPEARANCE_TYPE_WYRMLING_RED,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO BLU
                    case 26:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakeblu", APPEARANCE_TYPE_WYRMLING_BLUE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO NERO
                    case 27:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakebla", APPEARANCE_TYPE_WYRMLING_BLACK,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO VERDE
                    case 28:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakegre", APPEARANCE_TYPE_WYRMLING_GREEN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO BIANCO
                    case 29:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakewhi", APPEARANCE_TYPE_WYRMLING_WHITE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO ORO
                    case 30:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakegol", APPEARANCE_TYPE_WYRMLING_GOLD,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO BRONZO
                    case 31:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakebro", APPEARANCE_TYPE_WYRMLING_BRONZE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO ARGENTO
                    case 32:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakesil", APPEARANCE_TYPE_WYRMLING_SILVER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO OTTONE
                    case 33:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakebra", APPEARANCE_TYPE_WYRMLING_BRASS,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;
                    //DRAGHETTO RAME
                    case 34:
                        if(nMuta>=1&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakecop", APPEARANCE_TYPE_WYRMLING_COPPER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Divinita Venerata Errata");
                        break;

                    /////////////////////////////////////
                    //TRASFORMAZIONI MUTAFORMA UMANOIDI//
                    /////////////////////////////////////

                    //COBOLDO
                    case 35:
                        if(nMuta>=3)
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_cob", APPEARANCE_TYPE_KOBOLD_CHIEF_A,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //SCORPIONIDE
                    case 36:
                        if(nMuta>=3)
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_scorp", APPEARANCE_TYPE_STINGER_CHIEFTAIN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //MINOTAURO
                    case 37:
                        if(nMuta>=3)
                            SafePolymorph(oPC, 1, 0, 1, 0, "poly_mino", APPEARANCE_TYPE_MINOTAUR_CHIEFTAIN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;

                    ////////////////////////////////////
                    //TRASFORMAZIONI MUTAFORMA GIGANTI//
                    ////////////////////////////////////

                    //GIGANTE DEL FUOCO
                    case 38:
                        if(nMuta>=5)
                            if(GetGender(oPC)==GENDER_MALE)
                                SafePolymorph(oPC, 0, 1, 1, 0, "poly_gigafu", APPEARANCE_TYPE_GIANT_FIRE,iPattern);
                            else
                                SafePolymorph(oPC, 0, 1, 1, 0, "poly_gigafu", APPEARANCE_TYPE_GIANT_FIRE_FEMALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //GIGANTE DEL FREDDO
                    case 39:
                        if(nMuta>=5)
                            if(GetGender(oPC)==GENDER_MALE)
                                SafePolymorph(oPC, 0, 1, 1, 0, "poly_gigafr", APPEARANCE_TYPE_GIANT_FROST,iPattern);
                            else
                                SafePolymorph(oPC, 0, 1, 1, 0, "poly_gigafr", APPEARANCE_TYPE_GIANT_FROST_FEMALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //TROLL
                    case 40:
                        if(nMuta>=5)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_troll", APPEARANCE_TYPE_TROLL_CHIEFTAIN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;

                    ///////////////////////////////////////////
                    //TRASFORMAZIONI MUTAFORMA BESTIE MAGICHE//
                    ///////////////////////////////////////////

                    //BASILISCO
                    case 41:
                        if(nMuta>=7)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_basi", APPEARANCE_TYPE_BASILISK,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //KRENSHAR
                    case 42:
                        if(nMuta>=7)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_kren", APPEARANCE_TYPE_CAT_KRENSHAR,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //MANTICORA
                    case 43:
                        if(nMuta>=7)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_mant", APPEARANCE_TYPE_MANTICORE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;

                    //////////////////////////////
                    //TRASFORMAZIONI ABERAZZIONI//
                    //////////////////////////////

                    //BEHOLDER
                    case 44:
                        if(nMuta>=10)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_beho", APPEARANCE_TYPE_BEHOLDER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //MIND FLAYER
                    case 45:
                        if(nMuta>=10)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_mind", APPEARANCE_TYPE_MINDFLAYER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;
                    //DRIDER
                    case 46:
                        if(nMuta>=10)
                            SafePolymorph(oPC, 0, 0, 1, 0, "poly_drider", APPEARANCE_TYPE_DRIDER_CHIEF,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta");
                        break;

                    ////////////////////////////
                    //TRASFORMAZIONI NON MORTI//
                    ////////////////////////////

                    //SCHELETRO
                    case 47:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_sche", APPEARANCE_TYPE_SKELETON_CHIEFTAIN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //ZOMBIE
                    case 48:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_zombie", APPEARANCE_TYPE_ZOMBIE_WARRIOR_2,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //MOHRG
                    case 49:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_mohrg", APPEARANCE_TYPE_MOHRG,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //MUMMIA
                    case 50:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_mummia", APPEARANCE_TYPE_MUMMY_GREATER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //VAMPIRO
                    case 51:
                        if(nMuta>=25&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            if(GetGender(oPC)==GENDER_MALE)
                                SafePolymorph(oPC, 0, 0, 0, 0, "poly_vamp", APPEARANCE_TYPE_VAMPIRE_MALE,iPattern);
                            else
                                SafePolymorph(oPC, 0, 0, 0, 0, "poly_vampo", APPEARANCE_TYPE_VAMPIRE_FEMALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //LICH
                    case 52:
                        if(nMuta>=25&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_lich", 464,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //ALHOON
                    case 53:
                        if(nMuta==30&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC)&&GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_alho", APPEARANCE_TYPE_MINDFLAYER_ALHOON,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;
                    //DEMILICH
                    case 54:
                        if(nMuta==30&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC)&&GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_demilich", APPEARANCE_TYPE_DEMI_LICH,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Non Morta*");
                        break;

                    //////////////////////////
                    //TRASFORMAZIONI ESTERNO//
                    //////////////////////////

                    //AZER
                    case 55:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            if(GetGender(oPC)==GENDER_MALE)
                                SafePolymorph(oPC, 0, 0, 0, 0, "poly_azer", APPEARANCE_TYPE_AZER_MALE,iPattern);
                            else
                                SafePolymorph(oPC, 0, 0, 0, 0, "poly_azer", APPEARANCE_TYPE_AZER_FEMALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //ARCONTE SEGUGIO
                    case 56:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_aseg", APPEARANCE_TYPE_RAKSHASA_WOLF_MALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //VENDICATORE CELESTIALE
                    case 57:
                        if(nMuta>=25&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 0, 0, 0, 0, "vendc", APPEARANCE_TYPE_RAKSHASA_BEAR_MALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //AVATAR DI DRYCHA
                    case 58:
                        if(nMuta==30&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 0, 0, 0, 0, "poly_asekki", APPEARANCE_TYPE_ARIBETH,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //RAKSHASA
                    case 59:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            if(GetGender(oPC)==GENDER_MALE)
                                SafePolymorph(oPC, 0, 0, 0, 0, "poly_rak", APPEARANCE_TYPE_RAKSHASA_TIGER_MALE,iPattern);
                            else
                                SafePolymorph(oPC, 0, 0, 0, 0, "poly_rak", APPEARANCE_TYPE_RAKSHASA_TIGER_FEMALE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //DIAVOLO DELLA FOSSA
                    case 60:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 0, 1, 1, 0, "poly_dfossa", APPEARANCE_TYPE_DEVIL,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //BALOR
                    case 61:
                        if(nMuta>=25&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 0, 1, 0, "poly_balor", APPEARANCE_TYPE_BALOR,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //AVATAR DI LELITH
                    case 62:
                        if(nMuta==30&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_amephi", APPEARANCE_TYPE_NWN_ARIBETH_EVIL,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno* o Divinita Venerata Errata");
                        break;
                    //SLAAD ROSSO
                    case 63:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaadred", APPEARANCE_TYPE_SLAAD_RED,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //SLAAD VERDE
                    case 64:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaadgre", APPEARANCE_TYPE_SLAAD_GREEN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //SLAAD BLU
                    case 65:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaadblu", APPEARANCE_TYPE_SLAAD_BLUE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //SLAAD BIANCO
                    case 66:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaadwhi", APPEARANCE_TYPE_SLAAD_WHITE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //SLAAD GRIGIO
                    case 67:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaadgra", APPEARANCE_TYPE_SLAAD_GRAY,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //SLAAD NERO
                    case 68:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaadbla", APPEARANCE_TYPE_SLAAD_BLACK,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //SLAAD DELLA MORTE
                    case 69:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_slaaddea", APPEARANCE_TYPE_SLAAD_DEATH,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Esterno*");
                        break;

                    ////////////////////////////
                    //TRASFORMAZIONI COSTRUTTO//
                    ////////////////////////////

                    //GUARDIANO PROTETTORE
                    case 70:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_golg", APPEARANCE_TYPE_SHIELD_GUARDIAN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Costrutto*");
                        break;
                    //GOLEM DI FERRO
                    case 71:
                        if(nMuta>=10&&GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 0, 1, 1, "poly_golf", APPEARANCE_TYPE_GOLEM_IRON,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Costrutto*");
                        break;
                    //GOLEM DI OSSA
                    case 72:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oPC)&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_golo", APPEARANCE_TYPE_GOLEM_BONE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Costrutto* o Non sei Dotato del Talento *Forma Non Morto*");
                        break;
                    //GOLEM DI CARNE DEMONIACA
                    case 73:
                        if(nMuta>=20&&GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oPC)&&GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 0, 1, 1, "poly_gold", APPEARANCE_TYPE_GOLEM_DEMONFLESH,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Costrutto* o Non sei Dotato del Talento *Forma Esterno*");
                        break;
                    //GOLEM DI MITHRAL
                    case 74:
                        if(nMuta>=25&&GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_golm", APPEARANCE_TYPE_GOLEM_MITHRAL,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Costrutto*");
                        break;
                    //GOLEM DI ADAMANTIO
                    case 75:
                        if(nMuta==30&&GetHasFeat(FEAT_EPIC_CONSTRUCT_SHAPE,oPC)&&GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_gola", APPEARANCE_TYPE_GOLEM_ADAMANTIUM,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Costrutto*");
                        break;

                    ////////////////////////
                    //TRASFORMAZIONI DRAGO//
                    ////////////////////////

                    //DRAGO ROSSO
                    case 76:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakered", APPEARANCE_TYPE_DRAGON_RED,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO NERO
                    case 77:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakebla", APPEARANCE_TYPE_DRAGON_BLACK,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO BLU
                    case 78:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakeblu", APPEARANCE_TYPE_DRAGON_BLUE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO BIANCO
                    case 79:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakewhi", APPEARANCE_TYPE_DRAGON_WHITE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO VERDE
                    case 80:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakegre", APPEARANCE_TYPE_DRAGON_GREEN,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO OMBRA
                    case 81:
                        if((GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID||GetItemPossessedBy(oPC,"mod_clas_sa")!=OBJECT_INVALID)&&GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakesha", APPEARANCE_TYPE_DRAGON_SHADOW,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO ORO
                    case 82:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakegol", APPEARANCE_TYPE_DRAGON_GOLD,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO ARGENTO
                    case 83:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakesil", APPEARANCE_TYPE_DRAGON_SILVER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO OTTONE
                    case 84:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakebra", APPEARANCE_TYPE_DRAGON_BRASS,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO RAME
                    case 85:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakecop", APPEARANCE_TYPE_DRAGON_COPPER,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO BRONZO
                    case 86:
                        if((nMuta>=11||nDruidLv>=21)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakebro", APPEARANCE_TYPE_DRAGON_BRONZE,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRAGO PRISMATICO
                    case 87:
                        if((GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID||GetItemPossessedBy(oPC,"mod_clas_sa")!=OBJECT_INVALID)&&GetItemPossessedBy(oPC,"mod_deity_sekki")!=OBJECT_INVALID&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_drakepri", APPEARANCE_TYPE_DRAGON_PRIS,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma o Druido Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Divinita Venerata Errata");
                        break;
                    //DRACOLICH
                    case 88:
                        if((GetItemPossessedBy(oPC,"mod_clas_tt")!=OBJECT_INVALID)&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC)&&GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_dracolich", APPEARANCE_TYPE_DRACOLICH,iPattern);
                        else
                            SendMessageToPC(oPC,"Livello da Mutaforma Insufficiente per la Trasformazione Richiesta o Non sei Dotato del Talento *Forma Drago* o Non sei Dotato del Talento *Forma Non Morto*");
                        break;
                    //SERPENTE
                    case 90:
                        if(GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                            SafePolymorph(oPC, 1, 1, 1, 1, "poly_snake", 183,iPattern);
                        else
                            SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //SERPENTE CRUDELE
                    case 91:
                        if(nDruidLv>=10)
                            if(GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                                SafePolymorph(oPC, 1, 1, 1, 1, "poly_snake001", 178,iPattern);
                            else
                                SendMessageToPC(oPC,"Divinita Venerata Errata");
                        break;
                    //GATTO MANNARO
                    case 92:
                        if(GetItemPossessedBy(oPC,"mod_clas_sa")!=OBJECT_INVALID){
                            SafePolymorph(oPC, 1, 1, 1, 0, "poly_were", APPEARANCE_TYPE_ALLIP,iPattern);
                            if(GetItemPossessedBy(oPC,"mod_deity_mephi")!=OBJECT_INVALID)
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_AURA_GREEN_DARK),oPC);
                            else
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_AURA_GREEN),oPC);
                        }
                        else
                            SendMessageToPC(oPC,"Livello da Druido Insufficiente per la Trasformazione Richiesta");
                        break;
                }
        }
        else{
                switch(iPattern){
                    //RITORNO NORMALE
                    case 89:
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_POLYMORPH),oPC,0.0);
                        ExecuteScript("mod_clas_poly_ds",oPC);
                        break;
                }
        }
    }
    else{
        SendMessageToPC(oPC,"Sei incapacitato a trasformarti, sei sotto un effetto che non ti permette la trasformazione");
    }
}
