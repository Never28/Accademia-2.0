void main()
    {
        object oPC=OBJECT_SELF;

        object Manichino=GetPCSpeaker();

        object ArmaturaM=GetItemInSlot(INVENTORY_SLOT_CHEST,Manichino);

        object ArmaturaPC=GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
        if(ArmaturaM != OBJECT_INVALID){
        object oNewItemArm1;
        object oNewItemArm2;
        object oNewItemArm3;
        object oNewItemArm4;
        object oNewItemArm5;
        object oNewItemArm6;
        object oNewItemArm7;
        object oNewItemArm8;
        object oNewItemArm9;
        object oNewItemArm10;
        object oNewItemArm11;
        object oNewItemArm12;
        object oNewItemArm13;
        object oNewItemArm14;
        object oNewItemArm15;
        object oNewItemArm16;
        object oNewItemArm17;
        object oNewItemArm18;
        object oNewItemArm19;

        object oNewItemCArm1;
        object oNewItemCArm2;
        object oNewItemCArm3;
        object oNewItemCArm4;
        object oNewItemCArm5;
        object oNewItemCArm6;

        int BeltM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_BELT);
        int LBicM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LBICEP);
        int LFootM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOOT);
        int LForM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOREARM);
        int LHandM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LHAND);
        int LShinM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHIN);
        int LShoM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHOULDER);
        int LThiM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LTHIGH);
        int NeckM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_NECK);
        int PelvisM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_PELVIS);
        int RBicM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RBICEP);
        int RFootM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOOT);
        int RForM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOREARM);
        int RHandM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RHAND);
        int RobeM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_ROBE);
        int RShinM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHIN);
        int RShoM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHOULDER);
        int RThiM=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RTHIGH);

        int ArmClo1M=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1);
        int ArmClo2M=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2);
        int ArmLea1M=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1);
        int ArmLea2M=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2);
        int ArmMet1M=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1);
        int ArmMet2M=GetItemAppearance(ArmaturaM,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2);

        oNewItemArm1 = CopyItemAndModify(ArmaturaPC,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_BELT,BeltM);
        DestroyObject(ArmaturaPC);
        oNewItemArm2 = CopyItemAndModify(oNewItemArm1,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LBICEP,LBicM);
        DestroyObject(oNewItemArm1);
        oNewItemArm3 = CopyItemAndModify(oNewItemArm2,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOOT,LFootM);
        DestroyObject(oNewItemArm2);
        oNewItemArm4 = CopyItemAndModify(oNewItemArm3,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LFOREARM,LForM);
        DestroyObject(oNewItemArm3);
        oNewItemArm5 = CopyItemAndModify(oNewItemArm4,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LHAND,LHandM);
        DestroyObject(oNewItemArm4);
        oNewItemArm6 = CopyItemAndModify(oNewItemArm5,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHIN,LShinM);
        DestroyObject(oNewItemArm5);
        oNewItemArm7 = CopyItemAndModify(oNewItemArm6,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LSHOULDER,LShoM);
        DestroyObject(oNewItemArm6);
        oNewItemArm8 = CopyItemAndModify(oNewItemArm7,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_LTHIGH,LThiM);
        DestroyObject(oNewItemArm7);
        oNewItemArm9 = CopyItemAndModify(oNewItemArm8,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_NECK,NeckM);
        DestroyObject(oNewItemArm8);
        oNewItemArm10 = CopyItemAndModify(oNewItemArm9,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_PELVIS,PelvisM);
        DestroyObject(oNewItemArm9);
        oNewItemArm11 = CopyItemAndModify(oNewItemArm10,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RBICEP,RBicM);
        DestroyObject(oNewItemArm10);
        oNewItemArm12 = CopyItemAndModify(oNewItemArm11,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOOT,RFootM);
        DestroyObject(oNewItemArm11);
        oNewItemArm13 = CopyItemAndModify(oNewItemArm12,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RFOREARM,RForM);
        DestroyObject(oNewItemArm12);
        oNewItemArm14 = CopyItemAndModify(oNewItemArm13,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RHAND,RHandM);
        DestroyObject(oNewItemArm13);
        oNewItemArm15 = CopyItemAndModify(oNewItemArm14,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_ROBE,RobeM);
        DestroyObject(oNewItemArm14);
        oNewItemArm16 = CopyItemAndModify(oNewItemArm15,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHIN,RShinM);
        DestroyObject(oNewItemArm15);
        oNewItemArm17 = CopyItemAndModify(oNewItemArm16,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RSHOULDER,RShoM);
        DestroyObject(oNewItemArm16);
        oNewItemArm18 = CopyItemAndModify(oNewItemArm17,ITEM_APPR_TYPE_ARMOR_MODEL,ITEM_APPR_ARMOR_MODEL_RTHIGH,RThiM);
        DestroyObject(oNewItemArm17);

        oNewItemCArm1 = CopyItemAndModify(oNewItemArm18,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH1,ArmClo1M);
        DestroyObject(oNewItemArm18);
        oNewItemCArm2 = CopyItemAndModify(oNewItemCArm1,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_CLOTH2,ArmClo2M);
        DestroyObject(oNewItemCArm1);
        oNewItemCArm3 = CopyItemAndModify(oNewItemCArm2,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER1,ArmLea1M);
        DestroyObject(oNewItemCArm2);
        oNewItemCArm4 = CopyItemAndModify(oNewItemCArm3,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_LEATHER2,ArmLea2M);
        DestroyObject(oNewItemCArm3);
        oNewItemCArm5 = CopyItemAndModify(oNewItemCArm4,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL1,ArmMet1M);
        DestroyObject(oNewItemCArm4);
        oNewItemCArm6 = CopyItemAndModify(oNewItemCArm5,ITEM_APPR_TYPE_ARMOR_COLOR,ITEM_APPR_ARMOR_COLOR_METAL2,ArmMet2M);
        DestroyObject(oNewItemCArm5);
        SetCommandable(TRUE, oPC);
        DelayCommand(1.0,AssignCommand(oPC, ActionEquipItem(oNewItemCArm6,INVENTORY_SLOT_CHEST)));
        }
        else
            SpeakString("Devi indossare un'armatura per effettuare l'azione");
    }
