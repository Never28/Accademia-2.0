void main()
    {
        object oPC=OBJECT_SELF;

        object Manichino=GetPCSpeaker();

        object ElmoM=GetItemInSlot(INVENTORY_SLOT_HEAD,Manichino);

        object ElmoPC=GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
        if(ElmoM != OBJECT_INVALID){
        object oNewHelm;

        object oNewItemCHelm1;
        object oNewItemCHelm2;
        object oNewItemCHelm3;
        object oNewItemCHelm4;
        object oNewItemCHelm5;
        object oNewItemCHelm6;

        int AElmoM=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_MODEL,0);

        int ElmClo1M=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1);
        int ElmClo2M=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2);
        int ElmLea1M=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1);
        int ElmLea2M=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2);
        int ElmMet1M=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1);
        int ElmMet2M=GetItemAppearance(ElmoM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2);

        oNewHelm = CopyItemAndModify(ElmoPC,ITEM_APPR_TYPE_SIMPLE_MODEL,0,AElmoM);
        DestroyObject(ElmoPC);

        oNewItemCHelm1 = CopyItemAndModify(oNewHelm,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1,ElmClo1M);
        DestroyObject(oNewHelm);
        oNewItemCHelm2 = CopyItemAndModify(oNewItemCHelm1,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2,ElmClo2M);
        DestroyObject(oNewItemCHelm1);
        oNewItemCHelm3 = CopyItemAndModify(oNewItemCHelm2,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1,ElmLea1M);
        DestroyObject(oNewItemCHelm2);
        oNewItemCHelm4 = CopyItemAndModify(oNewItemCHelm3,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2,ElmLea2M);
        DestroyObject(oNewItemCHelm3);
        oNewItemCHelm5 = CopyItemAndModify(oNewItemCHelm4,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1,ElmMet1M);
        DestroyObject(oNewItemCHelm4);
        oNewItemCHelm6 = CopyItemAndModify(oNewItemCHelm5,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2,ElmMet2M);
        DestroyObject(oNewItemCHelm5);
        SetCommandable(TRUE, oPC);
        DelayCommand(1.0,AssignCommand(oPC, ActionEquipItem(oNewItemCHelm6,INVENTORY_SLOT_HEAD)));
        }
        else
            ActionSpeakString("Devi indossare un Elmo per effettuare l'azione");
    }
