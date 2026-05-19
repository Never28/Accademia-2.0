#include "x3_inc_string"

void AbilityArmor(object oPC,object oItem1,object oItem2,object oItem3,string sSet)
{
    //SET CARNE E MORTE
    if(sSet=="set_01"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET CARNE E MORTE INDOSSATO",STRING_COLOR_GREY));
    }
    else if(sSet=="set_02"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_LIGHTNING_M),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET LUCERTOLE MUTANTI INDOSSATO",STRING_COLOR_GREEN));
    }
    else if(sSet=="set_03"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_LIGHTNING_M),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET POLIMORFISMO INDOSSATO",STRING_COLOR_GREEN));
    }
    else if(sSet=="set_04"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_LIGHTNING_M),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET AXIN INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET FURIA PELLEVERDE
    else if(sSet=="set_05"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_ACID_L),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET FURIA PELLEVERDE INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET DI SKARSNIK
    else if(sSet=="set_06"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_ACID_L),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET SKARSNIK INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET DI URUK
    else if(sSet=="set_07"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_ACID_L),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET URUK INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET OSSA MALEDETTE
    else if(sSet=="set_08"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET OSSA MALEDETTE INDOSSATO",STRING_COLOR_GREY));
    }
    //SET FORZA SCIAMANICA
    else if(sSet=="set_09"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_DOOM),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET FORZA SCIAMANICA INDOSSATO",STRING_COLOR_RED));
    }
    //SET GROM
    else if(sSet=="set_10"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_DOOM),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET GROM INDOSSATO",STRING_COLOR_RED));
    }
    //SET KIKI-JIKI
    else if(sSet=="set_11"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET KIKI-JIKI INDOSSATO",STRING_COLOR_PURPLE));
    }
    //SET SEK'KUAR
    else if(sSet=="set_12"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET SEK'KUAR INDOSSATO",STRING_COLOR_PURPLE));
    }
    //SET NOTE DI GUERRA
    else if(sSet=="set_13"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET NOTE DI GUERRA INDOSSATO",STRING_COLOR_RED));
    }
    //SET PASSO DEI BOSCHI
    else if(sSet=="set_14"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET PASSO DEI BOSCHI INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET PARATA SELVAGGIA
    else if(sSet=="set_15"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET PARATA SELVAGGIA INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET ROCCIA FULMINEA
    else if(sSet=="set_16"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET ROCCIA FULMINEA INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
    //SET PREGHIERA TRIBALE
    else if(sSet=="set_17"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET PREGHIERA TRIBALE INDOSSATO",STRING_COLOR_RED));
    }
    //SET FEDE GIGANTE
    else if(sSet=="set_18"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET FEDE GIGANTE INDOSSATO",STRING_COLOR_PURPLE));
    }
    //SET ULULATO PIETRIFICANTE
    else if(sSet=="set_19"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_BLIND_DEAF_M),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET ULULATO PIETRIFICANTE INDOSSATO",STRING_COLOR_GREY));
    }
    //SET MUTANIM
    else if(sSet=="set_20"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_BLIND_DEAF_M),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET MUTANIM INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
     //SET VELENO INSIDIOSO
    else if(sSet=="set_22"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_POISON_L),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET VELENO INSIDIOSO INDOSSATO",STRING_COLOR_BROWN));
    }
    //FURIA DEL TORO
    else if(sSet=="set_23"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_PDK_WRATH),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET FURIA DEL TORO INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET CAVERNE DI NASKEL
    else if(sSet=="set_24"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_POISON_L),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET CAVERNE DI NASKEL INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET RISATA DI INGOT
    else if(sSet=="set_25"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET RISATA DI INGOT INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET OGRE ARCANO
    else if(sSet=="set_26"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET OGRE ARCANO INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
    //SET KARMA POSSENTE
    else if(sSet=="set_27"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET KARMA POSSENTE INDOSSATO",STRING_COLOR_BLUE));
    }
    //SET FREDDO SACRO
    else if(sSet=="set_28"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET FREDDO SACRO INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
    //SET PUGNO DI KERSHALT
    else if(sSet=="set_29"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET PUGNO DI KERSHALT INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET INVERNO VISCIDO
    else if(sSet=="set_30"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET INVERNO VISCIDO INDOSSATO",STRING_COLOR_GREY));
    }
    //SET SIBILO DELLA NOTTE
    else if(sSet=="set_31"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET SIBILO DELLA NOTTE INDOSSATO",STRING_COLOR_RED));
    }
    //SET TENTAZIONE OSCURA
    else if(sSet=="set_32"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET TENTAZIONE OSCURA INDOSSATO",STRING_COLOR_PURPLE));
    }
    //SET PREGHIERA TERRENA
    else if(sSet=="set_33"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET PREGHIERA TERRENA INDOSSATO",STRING_COLOR_BLUE));
    }
    //SET REGINA DELL'ARCANO
    else if(sSet=="set_34"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET REGINA DELL'ARCANO INDOSSATO",STRING_COLOR_GREY));
    }
    //SET PUNGIGLIONE MORTALE
    else if(sSet=="set_35"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET PUNGIGLIONE MORTALE INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET FRENESIA PRIMITIVA
    else if(sSet=="set_36"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET FRENESIA PRIMITIVA INDOSSATO",STRING_COLOR_RED));
    }
    //SET ODORE DI GUERRA
    else if(sSet=="set_37"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET ODORE DI GUERRA INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET CANTO DRACONICO
    else if(sSet=="set_38"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET CANTO DRACONICO INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET SCAGLIE DI MANA
    else if(sSet=="set_39"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET SCAGLIE DI MANA INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET MILLE VOLTI
    else if(sSet=="set_40"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET MILLE VOLTI INDOSSATO",STRING_COLOR_PINK));
    }
    //SET POTERE CORROSIVO
    else if(sSet=="set_41"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET POTERE CORROSIVO INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET TUTTO E NIENTE
    else if(sSet=="set_42"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET TUTTO E NIENTE INDOSSATO",STRING_COLOR_BLACK));
    }
    //SET VENDETTA STRISCIANTE
    else if(sSet=="set_43"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET VENDETTA STRISCIANTE INDOSSATO",STRING_COLOR_YELLOW));
    }
    //SET SANGUE NERO
    else if(sSet=="set_44"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET SANGUE NERO INDOSSATO",STRING_COLOR_BLACK));
    }
    //SET IBRIDO DIVINO
    else if(sSet=="set_45"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_GLOBE_USE),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET IBRIDO DIVINO INDOSSATO",STRING_COLOR_YELLOW));
    }
    //SET ACQUA SANTA
    else if(sSet=="set_46"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_HOLY_AID),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET ACQUA SANTA INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
    //SET SANGUE DEL SOTTOSUOLO
    else if(sSet=="set_49"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET SANGUE DEL SOTTOSUOLO INDOSSATO",STRING_COLOR_BLACK));
    }
    //SET ACIDITA' BRUTALE
    else if(sSet=="set_50"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_ACID_L),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET ACIDITA' BRUTALE INDOSSATO",STRING_COLOR_GREEN));
    }
    //SET OSCURA PESTILENZA
    else if(sSet=="set_51"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET OSCURA PESTILENZA INDOSSATO",STRING_COLOR_BROWN));
    }
    //SET TRAPPOLA D'OMBRA
    else if(sSet=="set_61"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_DEATH_WARD),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET TRAPPOLA D'OMBRA INDOSSATO",STRING_COLOR_GREY));
    }
    //SET ANNEGAMENTO ELEMENTALE
    else if(sSet=="set_73"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_PULSE_WATER),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET ANNEGAMENTO ELEMENTALE INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
    //SET LUCE GHIACCIATA
    else if(sSet=="set_76"){
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_IMP_FROST_S),oPC);
        SendMessageToPC(oPC,StringToRGBString("SET LUCE GHIACCIATA INDOSSATO",STRING_COLOR_LIGHTBLUE));
    }
}

void RemoveAbility(object oItem1){
    itemproperty iProp;
    iProp = GetFirstItemProperty(oItem1);
    while(GetIsItemPropertyValid(iProp)){
        if(GetItemPropertyType(iProp) == ITEM_PROPERTY_SAVING_THROW_BONUS || GetItemPropertyType(iProp) == ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP)
            RemoveItemProperty(oItem1,iProp);
        iProp = GetNextItemProperty(oItem1);
    }
}
