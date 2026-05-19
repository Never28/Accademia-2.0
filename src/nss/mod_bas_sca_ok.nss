/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 26-10-2010
*/

#include "x2_inc_switches"

void SafeDestroyObject(object oObject, float fDelay)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject, fDelay);
}

int nValuesSet(object oTarget){
    string sRef = GetStringLeft(GetResRef(oTarget),6);
    if(sRef=="set_01"||sRef=="set_02"||sRef=="set_03"||sRef=="set_04"||sRef=="set_05"||
        sRef=="set_06"||sRef=="set_07"||sRef=="set_08"||sRef=="set_09"||sRef=="set_10"||
        sRef=="set_11"||sRef=="set_12")
        return 1;
    else if(sRef=="set_13"||sRef=="set_14"||sRef=="set_15"||
        sRef=="set_16"||sRef=="set_17"||sRef=="set_18"||sRef=="set_20"||sRef=="set_21"||
        sRef=="set_22"||sRef=="set_23"||sRef=="set_24"||sRef=="set_25"||sRef=="set_26"||sRef=="set_27")
        return 2;
    else if(sRef=="set_28"||sRef=="set_29"||sRef=="set_30"||sRef=="set_31"||
        sRef=="set_32"||sRef=="set_33"||sRef=="set_34"||sRef=="set_35"||sRef=="set_36"||sRef=="set_37"
        ||sRef=="set_38"||sRef=="set_39"||sRef=="set_40"||sRef=="set_41"||sRef=="set_42"
        ||sRef=="set_43"||sRef=="set_44"||sRef=="set_45")
        return 3;
    else if(sRef=="set_46"||sRef=="set_47"||sRef=="set_48"||sRef=="set_49"||sRef=="set_50"||sRef=="set_51"||
        sRef=="set_61"||sRef=="set_73"||sRef=="set_76")
        return 4;
    sRef = GetStringLeft(GetResRef(oTarget),10);
    if(sRef=="set_19_bos")
        return 2;
    sRef = GetStringLeft(GetResRef(oTarget),12);
    if(sRef=="craft_19_bos")
        return 12;
    sRef = GetStringLeft(GetResRef(oTarget),8);
    if(sRef=="craft_1_"||sRef=="craft_2_"||sRef=="craft_3_"||sRef=="craft_4_"||sRef=="craft_5_"||
        sRef=="craft_6_"||sRef=="craft_7_"||sRef=="craft_8_"||sRef=="craft_9_"||sRef=="craft_10"||
        sRef=="craft_11"||sRef=="craft_12")
        return 11;
    else if(sRef=="craft_13"||sRef=="craft_14"||sRef=="craft_16"||sRef=="craft_17"||sRef=="craft_18"||sRef=="craft_19"||sRef=="craft_20"||sRef=="craft_21"||
        sRef=="craft_22"||sRef=="craft_23"||sRef=="craft_24"||sRef=="craft_25"||sRef=="craft_26")
        return 12;
    else if(sRef=="craft_28"||sRef=="craft_29"||sRef=="craft_31"||sRef=="craft_32"||sRef=="craft_34"||
        sRef=="craft_35"||sRef=="craft_37"||sRef=="craft_38"||sRef=="craft_40"||sRef=="craft_41"
        ||sRef=="craft_43"||sRef=="craft_44")
        return 13;
    else if(sRef=="craft_46"||sRef=="craft_47"||sRef=="craft_49"||sRef=="craft_50"||sRef=="craft_61"||sRef=="craft_73"||sRef=="craft_76")
        return 14;
    else return 0;
}

int nValuesCraft(object oTarget,object oTarget2){
    string sRef = GetStringRight(GetResRef(oTarget),4);
    string sRef2 = GetStringRight(GetResRef(oTarget2),4);
    int nStack,nStack2;
    nStack = GetItemStackSize(oTarget);
    nStack2 = GetItemStackSize(oTarget2);
    if((sRef=="mb21"||sRef=="mb11"||sRef=="bos1")&&(sRef2=="mb21"||sRef2=="mb11"||sRef2=="bos1")){
        if(nStack==nStack2)
            return 1;
    }
    else if((sRef=="mb22"||sRef=="mb12"||sRef=="bos2")&&(sRef2=="mb22"||sRef2=="mb12"||sRef2=="bos2")){
        if(nStack==nStack2)
            return 1;
    }
    else if((sRef=="mb23"||sRef=="mb13"||sRef=="bos3")&&(sRef2=="mb23"||sRef2=="mb13"||sRef2=="bos3")){
        if(nStack==nStack2)
            return 1;
    }
    else if((sRef=="mb21"||sRef=="mb11"||sRef=="bos1")&&(sRef2=="mb22"||sRef2=="mb12"||sRef2=="bos2")){
        if(nStack==1&&nStack2==4)
            return 1;
    }
    else if((sRef=="mb22"||sRef=="mb12"||sRef=="bos2")&&(sRef2=="mb21"||sRef2=="mb11"||sRef2=="bos1")){
        if(nStack==4&&nStack2==1)
            return 1;
    }
    else if((sRef=="mb21"||sRef=="mb11"||sRef=="bos1")&&(sRef2=="mb23"||sRef2=="mb13"||sRef2=="bos3")){
        if(nStack==1&&nStack2==6)
            return 1;
    }
    else if((sRef=="m23"||sRef=="mb13"||sRef=="bos3")&&(sRef2=="mb21"||sRef2=="mb11"||sRef2=="bos1")){
        if(nStack==6&&nStack2==1)
            return 1;
    }
    else if((sRef=="mb22"||sRef=="mb12"||sRef=="bos2")&&(sRef2=="mb23"||sRef2=="mb13"||sRef2=="bos3")){
        if(nStack==4&&nStack2==6)
            return 1;
    }
    else if((sRef=="mb23"||sRef=="mb13"||sRef=="bos3")&&(sRef2=="mb22"||sRef2=="mb12"||sRef2=="bos2")){
        if(nStack==6&&nStack2==4)
            return 1;
    }
    return 0;
}

void main()
{
    object oTavolo = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    object oPC2 = GetLocalObject(oPC,"scambio_pg");
    object oItem = GetLocalObject(oPC,"scambio_item");
    int nValue1,nValue2,n1=0,n2=0,n3=0;
    object oItem2;
    object oPC3;
    string sResRef1,sResRef2,sResRef3;
    if(oPC2 != OBJECT_INVALID){
        oItem2 = GetLocalObject(oPC2,"scambio_item");
        oPC3 = GetLocalObject(oPC2,"scambio_pg");
        if(oPC3 == oPC && oItem2 != OBJECT_INVALID && oItem != OBJECT_INVALID){
            n1 = nValuesSet(oItem);
            n2 = nValuesSet(oItem2);
            if(n1 == n2){
                sResRef3 = GetStringLeft(GetResRef(oItem),5);
                if(sResRef3=="craft"){
                    n3 = nValuesCraft(oItem,oItem2);
                    if(n3==0)
                        AssignCommand(oPC,SpeakString("State cercando di scambiare quantita' errate di oggetti"));
                    else{
                        if(GetLocalInt(oPC,"scambio_1") == 1 && GetLocalInt(oPC2,"scambio_1") == 1){
                            sResRef1 = GetResRef(oItem);
                            sResRef2 = GetResRef(oItem2);
                            int nStack,nStack2;
                            nStack = GetItemStackSize(oItem);
                            nStack2 = GetItemStackSize(oItem2);
                            object oNew1 = CreateItemOnObject(sResRef1,oPC2,nStack);
                            object oNew2 = CreateItemOnObject(sResRef2,oPC,nStack2);
                            SafeDestroyObject(oItem,0.0);
                            SafeDestroyObject(oItem2,0.0);
                            SetLocalInt(oPC,"scambio_1",0);
                            SetLocalInt(oPC2,"scambio_1",0);
                            SetLocalObject(oPC,"scambio_item",OBJECT_INVALID);
                            SetLocalObject(oPC2,"scambio_item",OBJECT_INVALID);
                            SetLocalObject(oPC,"scambio_pg",OBJECT_INVALID);
                            SetLocalObject(oPC2,"scambio_pg",OBJECT_INVALID);
                            SafeDestroyObject(GetItemPossessedBy(oPC,"mod_bas_item"),0.0);
                            SafeDestroyObject(GetItemPossessedBy(oPC,"mod_bas_pg"),0.0);
                            SafeDestroyObject(GetItemPossessedBy(oPC2,"mod_bas_item"),0.0);
                            SafeDestroyObject(GetItemPossessedBy(oPC2,"mod_bas_pg"),0.0);
                        }
                        else{
                            AssignCommand(oPC,SpeakString("Non tutti e due i giocatori hanno dato ok allo scambio"));
                        }
                    }
                }
                else{
                    if(GetLocalInt(oPC,"scambio_1") == 1 && GetLocalInt(oPC2,"scambio_1") == 1){
                        sResRef1 = GetResRef(oItem);
                        sResRef2 = GetResRef(oItem2);
                        object oNew1 = CreateItemOnObject(sResRef1,oPC2);
                        object oNew2 = CreateItemOnObject(sResRef2,oPC);
                        SafeDestroyObject(oItem,0.0);
                        SafeDestroyObject(oItem2,0.0);
                        SetLocalInt(oPC,"scambio_1",0);
                        SetLocalInt(oPC2,"scambio_1",0);
                        SetLocalObject(oPC,"scambio_item",OBJECT_INVALID);
                        SetLocalObject(oPC2,"scambio_item",OBJECT_INVALID);
                        SetLocalObject(oPC,"scambio_pg",OBJECT_INVALID);
                        SetLocalObject(oPC2,"scambio_pg",OBJECT_INVALID);
                        SafeDestroyObject(GetItemPossessedBy(oPC,"mod_bas_item"),0.0);
                        SafeDestroyObject(GetItemPossessedBy(oPC,"mod_bas_pg"),0.0);
                        SafeDestroyObject(GetItemPossessedBy(oPC2,"mod_bas_item"),0.0);
                        SafeDestroyObject(GetItemPossessedBy(oPC2,"mod_bas_pg"),0.0);
                    }
                    else{
                        AssignCommand(oPC,SpeakString("Non tutti e due i giocatori hanno dato ok allo scambio"));
                    }
                }
            }
            else
                AssignCommand(oPC,SpeakString("Stiamo cercando di scambiare due oggetti di livello differente, non si puo'"));
        }
        else{
            AssignCommand(oPC,SpeakString("Lo scambio non puo' avvenire, tu o il tuo scambiatore non avete selezionato adeguatamente gli oggetti o non vi siete selezionati a vicenda con gli oggetti da Scambio", TALKVOLUME_TALK));
        }
    }
}
