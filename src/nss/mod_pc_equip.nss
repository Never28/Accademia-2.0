#include "x2_inc_switches"
#include "x2_inc_intweapon"
#include "x2_inc_itemprop"
#include "mod_pc_equip_fun"

void main()
{

    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();
    string sItem = GetTag(oItem);
    if(sItem == "loot_ch_16"){
        SendMessageToPC(oPC,IntToString(GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL ,ITEM_APPR_WEAPON_MODEL_TOP)));
        SendMessageToPC(oPC,IntToString(GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL ,ITEM_APPR_WEAPON_MODEL_MIDDLE)));
        SendMessageToPC(oPC,IntToString(GetItemAppearance(oItem,ITEM_APPR_TYPE_WEAPON_MODEL ,ITEM_APPR_WEAPON_MODEL_BOTTOM)));
    }
    string sRef = GetStringLeft(GetResRef(oItem),6);
    int nEntrace = GetLocalInt(oPC,"entratoeq");
    if(nEntrace==0){
        ////////////////
        // LIVELLO 01 //
        ////////////////

        // Druido
        if(sItem == "loot_dr_01")
            ControlClassCAP(oPC,1,CLASS_TYPE_DRUID,oItem);
        // Monaco
        if(sItem == "loot_mo_01")
            ControlClassCAP(oPC,1,CLASS_TYPE_MONK,oItem);
        // Chierico
        if(sItem == "loot_ch_01")
            ControlClassCAP(oPC,1,CLASS_TYPE_CLERIC,oItem);

        ////////////////
        // LIVELLO 06 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_06"||sItem == "loot_dr_06"||sItem == "loot_ch_06"||sItem == "loot_pa_06"||sItem == "loot_ra_06")
            ControlLevelCAP(oPC,6,oItem);
        // Druido
        if(sItem == "loot_dr_06"||sRef=="set_10")
            ControlClassCAP(oPC,3,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_06"||sRef=="set_03")
            ControlClassCAP(oPC,3,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_06"||sRef=="set_11")
            ControlClassCAP(oPC,4,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_06"||sRef=="set_12")
            ControlClassCAP(oPC,4,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLO 11 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_11"||sItem == "loot_dr_11"||sItem == "loot_ch_11"||sItem == "loot_pa_11"||sItem == "loot_ra_11")
            ControlLevelCAP(oPC,11,oItem);
        // Druido
        if(sItem == "loot_dr_11")
            ControlClassCAP(oPC,5,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_11")
            ControlClassCAP(oPC,5,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_11")
            ControlClassCAP(oPC,4,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_11")
            ControlClassCAP(oPC,4,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLO 16 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_16"||sItem == "loot_dr_16"||sItem == "loot_ch_16"||sItem == "loot_pa_16"||sItem == "loot_ra_16")
            ControlLevelCAP(oPC,16,oItem);
        // Druido
        if(sItem == "loot_dr_16"||sRef=="set_19")
            ControlClassCAP(oPC,7,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_16"||sRef=="set_17")
            ControlClassCAP(oPC,7,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_16"||sRef=="set_18")
            ControlClassCAP(oPC,8,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_16"||sRef=="set_24"||sRef=="set_14")
            ControlClassCAP(oPC,8,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLO 21 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_21"||sItem == "loot_dr_21"||sItem == "loot_ch_21"||sItem == "loot_pa_21"||sItem == "loot_ra_21")
            ControlLevelCAP(oPC,21,oItem);
        // Druido
        if(sItem == "loot_dr_21")
            ControlClassCAP(oPC,9,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_21")
            ControlClassCAP(oPC,9,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_21")
            ControlClassCAP(oPC,8,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_21")
            ControlClassCAP(oPC,8,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLO 26 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_26"||sItem == "loot_dr_26"||sItem == "loot_ch_26"||sItem == "loot_pa_26"||sItem == "loot_ra_26")
            ControlLevelCAP(oPC,26,oItem);
        // Druido
        if(sItem == "loot_dr_26"||sRef=="set_32"||sRef=="set_44")
            ControlClassCAP(oPC,11,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_26"||sRef=="set_33"||sRef=="set_40")
            ControlClassCAP(oPC,11,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_26"||sRef=="set_28"||sRef=="set_45")
            ControlClassCAP(oPC,11,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_26"||sRef=="set_35")
            ControlClassCAP(oPC,11,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLO 31 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_31"||sItem == "loot_dr_31"||sItem == "loot_ch_31"||sItem == "loot_pa_31"||sItem == "loot_ra_31")
            ControlLevelCAP(oPC,31,oItem);
        // Druido
        if(sItem == "loot_dr_31")
            ControlClassCAP(oPC,13,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_31")
            ControlClassCAP(oPC,13,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_31")
            ControlClassCAP(oPC,11,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_31")
            ControlClassCAP(oPC,11,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLO 36 //
        ////////////////

        // CONTROLLO LIVELLO
        if(sItem == "loot_lv_36"||sItem == "loot_dr_36"||sItem == "loot_ch_36"||sItem == "loot_pa_36"||sItem == "loot_ra_36")
            ControlLevelCAP(oPC,36,oItem);
        // Druido
        if(sItem == "loot_dr_36")
            ControlClassCAP(oPC,15,CLASS_TYPE_DRUID,oItem);
        // Chierico
        if(sItem == "loot_ch_36"||sRef=="set_46")
            ControlClassCAP(oPC,15,CLASS_TYPE_CLERIC,oItem);
        // Paladino
        if(sItem == "loot_pa_36"||sRef=="set_76")
            ControlClassCAP(oPC,14,CLASS_TYPE_PALADIN,oItem);
        // Ranger
        if(sItem == "loot_ra_36")
            ControlClassCAP(oPC,14,CLASS_TYPE_RANGER,oItem);

        ////////////////
        // LIVELLI 40 //
        ////////////////

        // Druido 40
        if(sItem == "loot_dr_40")
            ControlClassCAP(oPC,40,CLASS_TYPE_DRUID,oItem);
        // Paladino 40
        if(sItem == "loot_pa_40")
            ControlClassCAP(oPC,40,CLASS_TYPE_PALADIN,oItem);

        ControllSet(oPC,oItem);
        if (GetItemPossessedBy(oPC,"car_str")!=OBJECT_INVALID){
            ExecuteScript("mod_bas_car_for",oPC);
        }
        int nNumbers = GetLocalInt(oPC,"poly_ability");
        int nRanged = GetLocalInt(oPC,"poly_weaponr");
        int nMelee = GetLocalInt(oPC,"poly_weaponm");
        int nShield = GetLocalInt(oPC,"poly_shield");
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
            if(nRangedType!=BASE_ITEM_DART||nRangedType!=BASE_ITEM_THROWINGAXE||nRangedType!=BASE_ITEM_SHURIKEN||
            nRangedType!=BASE_ITEM_SHORTBOW||nRangedType!=BASE_ITEM_LIGHTCROSSBOW||nRangedType!=BASE_ITEM_LONGBOW||
            nRangedType!=BASE_ITEM_HEAVYCROSSBOW||nRangedType!=BASE_ITEM_SLING){}
            AssignCommand(oPC,ActionUnequipItem(oWeapon));
        }
        if(nRanged==0&&nMelee==0){
            string sDisItem = GetResRef(oItem);
            int nRangedType = GetBaseItemType(oItem);
            if(nRangedType==BASE_ITEM_HEAVYCROSSBOW){
                if(sDisItem=="weap_bas_lcro1"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_1",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros2"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_2",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros3"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_3",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros4"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_4",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d6));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros5"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_5",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros6"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_6",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d4));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros7"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_7",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
                else if(sDisItem=="weap_bas_lcros8"){
                    object oAmmo = CreateItemOnObject("weap_bas_mun_8",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BOLTS));
                }
            }
            else if(nRangedType==BASE_ITEM_SHORTBOW||nRangedType==BASE_ITEM_LONGBOW){
                if(sDisItem=="weap_bas_lbow1"||sDisItem=="weap_bas_sbow1"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_1",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow2"||sDisItem=="weap_bas_sbow2"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_2",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow3"||sDisItem=="weap_bas_sbow3"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_3",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow4"||sDisItem=="weap_bas_sbow4"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_4",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d6));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow5"||sDisItem=="weap_bas_sbow5"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_5",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow6"||sDisItem=="weap_bas_sbow6"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_6",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d4));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow7"||sDisItem=="weap_bas_sbow7"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_7",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
                else if(sDisItem=="weap_bas_lbow8"||sDisItem=="weap_bas_sbow8"){
                    object oAmmo = CreateItemOnObject("weap_bas_fre_8",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_ARROWS));
                }
            }
            else if(nRangedType==BASE_ITEM_SLING){
                if(sDisItem=="weap_bas_sli1"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_1",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli2"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_2",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli3"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_3",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli4"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_4",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_1d6));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d6));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli5"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_5",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli6"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_6",oPC,99);
                    itemproperty ip_Item = GetFirstItemProperty(oItem);
                    while(GetIsItemPropertyValid(ip_Item)){
                        int nType = GetItemPropertyType(ip_Item);
                        if(nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_POSITIVE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2d4));
                        else if(nType == ITEM_PROPERTY_ADDITIONAL)
                            IPSafeAddItemProperty(oAmmo, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d4));
                        ip_Item = GetNextItemProperty(oItem);
                    }
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli7"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_7",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
                else if(sDisItem=="weap_bas_sli8"){
                    object oAmmo = CreateItemOnObject("weap_bas_pro_8",oPC,99);
                    AssignCommand(oPC,ActionEquipItem(oAmmo,INVENTORY_SLOT_BULLETS));
                }
            }
        }
        if(nShield==1){
            object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
            AssignCommand(oPC,ActionUnequipItem(oShield));
        }
    }
    else
        DelayCommand(3.0,SetLocalInt(oPC,"entratoeq",1));
}
