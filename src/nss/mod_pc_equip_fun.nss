#include "mod_equip_fun_ab"

string ControlClassName(int i){
    switch(i){
        case CLASS_TYPE_DRUID:
            return "Druido";
            break;
        case CLASS_TYPE_CLERIC:
            return "Chierico";
            break;
        case CLASS_TYPE_MONK:
            return "Monaco";
            break;
        case CLASS_TYPE_PALADIN:
            return "Paladino";
            break;
        case CLASS_TYPE_RANGER:
            return "Ranger";
            break;
        case CLASS_TYPE_ROGUE:
            return "Ladro";
            break;
        case CLASS_TYPE_PALE_MASTER:
            return "Signore Pallido";
            break;
        case CLASS_TYPE_PURPLE_DRAGON_KNIGHT:
            return "Cavaliere dei Draghi Purpurei";
            break;
        case CLASS_TYPE_SHADOWDANCER:
            return "Ombra Danzante";
            break;
        case CLASS_TYPE_SHIFTER:
            return "Mutaforma";
            break;
        case CLASS_TYPE_WIZARD:
            return "Mago";
            break;
        case CLASS_TYPE_WEAPON_MASTER:
            return "Maestro d'Armi";
            break;
        case CLASS_TYPE_SORCERER:
            return "Stregone";
            break;
        case CLASS_TYPE_FIGHTER:
            return "Guerriero";
            break;
        case CLASS_TYPE_DWARVEN_DEFENDER:
            return "Difensore Nanesco";
            break;
        case CLASS_TYPE_DIVINE_CHAMPION:
            return "Campione di Torm";
            break;
        case CLASS_TYPE_DRAGON_DISCIPLE:
            return "Discepolo del Drago Rosso";
            break;
        case CLASS_TYPE_ARCANE_ARCHER:
            return "Arciere Arcano";
            break;
        case CLASS_TYPE_ASSASSIN:
            return "Assassino";
            break;
        case CLASS_TYPE_BARBARIAN:
            return "Barbari";
            break;
        case CLASS_TYPE_BLACKGUARD:
            return "Guardia Nera";
            break;
    }
    return "";
}
void ControlClassCAP(object oPC, int nLevel, int nClass, object oItem)
{
    int nPCLevel = GetLevelByClass(nClass,oPC);
    int nDifference = nPCLevel - nLevel;
    if(nDifference<0){
        SendMessageToPC(oPC,"Ti mancano "+IntToString(-nDifference)+" della classe "+ControlClassName(nClass)+" per impugnare l'oggetto");
        AssignCommand(oPC,ActionUnequipItem(oItem));
    }
}

void ControlDeityCAP(object oPC, string sDeity, object oItem)
{
    string sDeityPC = GetDeity(oPC);
    if(sDeity != sDeityPC){
        SendMessageToPC(oPC,"Non sei un fedele del dio "+sDeity+" e non puoi impugnare l'oggetto");
        AssignCommand(oPC,ActionUnequipItem(oItem));
    }
}

void ControlLevelCAP(object oPC, int nHitDice, object oItem)
{
    int nHitDicePC = GetHitDice(oPC);
    int nDifference = nHitDicePC - nHitDice;
    if(nDifference<0){
        SendMessageToPC(oPC,"Ti mancano "+IntToString(-nDifference)+" livelli per impugnare l'oggetto");
        AssignCommand(oPC,ActionUnequipItem(oItem));
    }
}

void ControllSet(object oPC,object oItem1){
    object oItem2,oItem3,oItem4;
    string sObj1,sObj2,sObj3,sObj4;
    sObj1 = GetResRef(oItem1);
    string sLeftObj1 = GetStringLeft(sObj1,6);
    string sRightObj1 = GetStringRight(sObj1,3);
    string sWarMage = GetStringRight(GetStringLeft(sObj1,8),1);
   if(sLeftObj1=="set_01"||sLeftObj1=="set_05"||sLeftObj1=="set_02"||sLeftObj1=="set_12"||
    sLeftObj1=="set_19"||sLeftObj1=="set_24"||sLeftObj1=="set_17"||sLeftObj1=="set_15"||
    sLeftObj1=="set_27"||sLeftObj1=="set_28"||sLeftObj1=="set_38"||sLeftObj1=="set_37"
    ||sLeftObj1=="set_41"||sLeftObj1=="set_42"||sLeftObj1=="set_46"||sLeftObj1=="set_49"||sLeftObj1=="set_73"){
        oItem4 = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
        oItem2 = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
        oItem3 = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
        sObj4 = GetResRef(oItem4);
        sObj2 = GetResRef(oItem2);
        sObj3 = GetResRef(oItem3);
    }
    else if(sLeftObj1=="set_06"||sLeftObj1=="set_03"||sLeftObj1=="set_09"||sLeftObj1=="set_11"||
    sLeftObj1=="set_22"||sLeftObj1=="set_23"||sLeftObj1=="set_16"||sLeftObj1=="set_25"||
    sLeftObj1=="set_26"||sLeftObj1=="set_32"||sLeftObj1=="set_35"||sLeftObj1=="set_39"
    ||sLeftObj1=="set_40"||sLeftObj1=="set_43"||sLeftObj1=="set_45"||sLeftObj1=="set_50"
    ||sLeftObj1=="set_61"){
        oItem4 = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
        oItem2 = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
        oItem3 = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
        sObj4 = GetResRef(oItem4);
        sObj2 = GetResRef(oItem2);
        sObj3 = GetResRef(oItem3);
    }
    else if(sLeftObj1=="set_08"||sLeftObj1=="set_07"||sLeftObj1=="set_04"||sLeftObj1=="set_10"||
    sLeftObj1=="set_20"||sLeftObj1=="set_18"||sLeftObj1=="set_13"||sLeftObj1=="set_14"||
    sLeftObj1=="set_29"||sLeftObj1=="set_30"||sLeftObj1=="set_31"||sLeftObj1=="set_33"||
    sLeftObj1=="set_34"||sLeftObj1=="set_36"||sLeftObj1=="set_44"||sLeftObj1=="set_76"
    ||sLeftObj1=="set_51"){
        oItem4 = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
        oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
        oItem3 = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
        sObj4 = GetResRef(oItem4);
        sObj2 = GetResRef(oItem2);
        sObj3 = GetResRef(oItem3);
    }
    if(GetStringLeft(sObj4,6)==GetStringLeft(sObj3,6)&&GetStringLeft(sObj4,6)==GetStringLeft(sObj2,6)
    &&GetStringLeft(sObj2,6)==GetStringLeft(sObj3,6)){
        AbilityArmor(oPC,oItem4,oItem2,oItem3,sLeftObj1);
    }
}

void UnControllSet(object oPC,object oItem1){
    object oItem2,oItem3,oItem4;
    string sObj1,sObj2,sObj3,sObj4;
    sObj1 = GetResRef(oItem1);
    string sLeftObj1 = GetStringLeft(sObj1,6);
    string sRightObj1 = GetStringRight(sObj1,3);
    string sWarMage = GetStringRight(GetStringLeft(sObj1,8),1);
   if(sLeftObj1=="set_01"||sLeftObj1=="set_05"||sLeftObj1=="set_02"||sLeftObj1=="set_12"||
    sLeftObj1=="set_19"||sLeftObj1=="set_24"||sLeftObj1=="set_17"||sLeftObj1=="set_15"||
    sLeftObj1=="set_27"||sLeftObj1=="set_28"||sLeftObj1=="set_38"||sLeftObj1=="set_37"
    ||sLeftObj1=="set_41"||sLeftObj1=="set_42"||sLeftObj1=="set_46"||sLeftObj1=="set_49"||sLeftObj1=="set_73"){
        oItem4 = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oPC);
        oItem2 = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oPC);
        oItem3 = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
        sObj4 = GetResRef(oItem4);
        sObj2 = GetResRef(oItem2);
        sObj3 = GetResRef(oItem3);
    }
    else if(sLeftObj1=="set_06"||sLeftObj1=="set_03"||sLeftObj1=="set_09"||sLeftObj1=="set_11"||
    sLeftObj1=="set_22"||sLeftObj1=="set_23"||sLeftObj1=="set_16"||sLeftObj1=="set_25"||
    sLeftObj1=="set_26"||sLeftObj1=="set_32"||sLeftObj1=="set_35"||sLeftObj1=="set_39"
    ||sLeftObj1=="set_40"||sLeftObj1=="set_43"||sLeftObj1=="set_45"||sLeftObj1=="set_50"
    ||sLeftObj1=="set_61"){
        oItem4 = GetItemInSlot(INVENTORY_SLOT_BOOTS,oPC);
        oItem2 = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
        oItem3 = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
        sObj4 = GetResRef(oItem4);
        sObj2 = GetResRef(oItem2);
        sObj3 = GetResRef(oItem3);
    }
    else if(sLeftObj1=="set_08"||sLeftObj1=="set_07"||sLeftObj1=="set_04"||sLeftObj1=="set_10"||
    sLeftObj1=="set_20"||sLeftObj1=="set_18"||sLeftObj1=="set_13"||sLeftObj1=="set_14"||
    sLeftObj1=="set_29"||sLeftObj1=="set_30"||sLeftObj1=="set_31"||sLeftObj1=="set_33"||
    sLeftObj1=="set_34"||sLeftObj1=="set_36"||sLeftObj1=="set_44"||sLeftObj1=="set_76"
    ||sLeftObj1=="set_51"){
        oItem4 = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
        oItem2 = GetItemInSlot(INVENTORY_SLOT_BELT,oPC);
        oItem3 = GetItemInSlot(INVENTORY_SLOT_NECK,oPC);
        sObj4 = GetResRef(oItem4);
        sObj2 = GetResRef(oItem2);
        sObj3 = GetResRef(oItem3);
    }
    if(GetStringLeft(sObj4,6)==GetStringLeft(sObj3,6)&&GetStringLeft(sObj4,6)==GetStringLeft(sObj2,6)
    &&GetStringLeft(sObj2,6)==GetStringLeft(sObj3,6)){
        RemoveAbility(oItem2);
        RemoveAbility(oItem3);
        RemoveAbility(oItem4);
    }
}
