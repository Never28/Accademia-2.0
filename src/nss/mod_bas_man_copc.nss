void main()
    {
        object oPC=OBJECT_SELF;

        object Manichino=GetPCSpeaker();

        object MantelloM=GetItemInSlot(INVENTORY_SLOT_CLOAK,Manichino);

        object MantelloPC=GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
        if(MantelloM != OBJECT_INVALID){
        object oNewItemCloak1;
        object oNewItemCloak2;
        object oNewItemCloak3;
        object oNewItemCloak4;
        object oNewItemCloak5;
        object oNewItemCloak6;

        int ManClo1M=GetItemAppearance(MantelloM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1);
        int ManClo2M=GetItemAppearance(MantelloM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2);
        int ManLea1M=GetItemAppearance(MantelloM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1);
        int ManLea2M=GetItemAppearance(MantelloM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2);
        int ManMet1M=GetItemAppearance(MantelloM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1);
        int ManMet2M=GetItemAppearance(MantelloM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2);

        oNewItemCloak1 = CopyItemAndModify(MantelloPC,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1,ManClo1M);
        DestroyObject(MantelloPC);
        oNewItemCloak2 = CopyItemAndModify(oNewItemCloak1,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2,ManClo2M);
        DestroyObject(oNewItemCloak1);
        oNewItemCloak3 = CopyItemAndModify(oNewItemCloak2,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1,ManLea1M);
        DestroyObject(oNewItemCloak2);
        oNewItemCloak4 = CopyItemAndModify(oNewItemCloak3,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2,ManLea2M);
        DestroyObject(oNewItemCloak3);
        oNewItemCloak5 = CopyItemAndModify(oNewItemCloak4,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1,ManMet1M);
        DestroyObject(oNewItemCloak4);
        oNewItemCloak6 = CopyItemAndModify(oNewItemCloak5,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2,ManMet2M);
        DestroyObject(oNewItemCloak5);
        SetCommandable(TRUE, oPC);
        DelayCommand(1.0,AssignCommand(oPC, ActionEquipItem(oNewItemCloak6,INVENTORY_SLOT_CLOAK)));
        }
        else
            ActionSpeakString("Devi indossare un Mantello per effettuare l'azione");
    }
