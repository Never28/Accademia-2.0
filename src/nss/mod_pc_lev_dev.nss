int HitDiceByXP(object oPC2)
{
   int nHD=GetXP(oPC2);
   if (nHD < 1000) return 1;
   else if (nHD < 3000) return 2;
   else if (nHD < 6000) return 3;
   else if (nHD < 10000) return 4;
   else if (nHD < 15000) return 5;
   else if (nHD < 21000) return 6;
   else if (nHD < 28000) return 7;
   else if (nHD < 36000) return 8;
   else if (nHD < 45000) return 9;
   else if (nHD < 55000) return 10;
   else if (nHD < 66000) return 11;
   else if (nHD < 78000) return 12;
   else if (nHD < 91000) return 13;
   else if (nHD < 105000) return 14;
   else if (nHD < 120000) return 15;
   else if (nHD < 136000) return 16;
   else if (nHD < 153000) return 17;
   else if (nHD < 171000) return 18;
   else if (nHD < 190000) return 19;
   else if (nHD < 210000) return 20;
   else if (nHD < 231000) return 21;
   else if (nHD < 253000) return 22;
   else if (nHD < 276000) return 23;
   else if (nHD < 300000) return 24;
   else if (nHD < 325000) return 25;
   else if (nHD < 351000) return 26;
   else if (nHD < 378000) return 27;
   else if (nHD < 406000) return 28;
   else if (nHD < 435000) return 29;
   else if (nHD < 465000) return 30;
   else if (nHD < 496000) return 31;
   else if (nHD < 528000) return 32;
   else if (nHD < 561000) return 33;
   else if (nHD < 595000) return 34;
   else if (nHD < 630000) return 35;
   else if (nHD < 666000) return 36;
   else if (nHD < 703000) return 37;
   else if (nHD < 741000) return 38;
   else if (nHD < 780000) return 39;
   else return 40;
}

void RelevelXP(object oPC,int OldXP,int NewXP)
{
    DelayCommand(0.0,SetXP(oPC,NewXP));
    DelayCommand(0.5,GiveXPToCreature(oPC,OldXP));
}

void main()
{
    object oPC = OBJECT_SELF;
    int nLevel = HitDiceByXP(oPC);
    int nXP = GetXP(oPC);
    int NewXP;
    int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    if(nDruidLv>=5&&(GetItemPossessedBy(oPC,"poly_ability_1")==OBJECT_INVALID)){
        CreateItemOnObject("poly_ability_1",oPC);
        CreateItemOnObject("poly_ability_2",oPC);
        CreateItemOnObject("poly_ability_3",oPC);
        location oOldLocation = GetLocation(oPC);
        SetLocalLocation(oPC,"mod_return",oOldLocation);
        ExecuteScript("mod_pc_levelup_d",oPC);
    }
    int nDrakeLv = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oPC);
    if(nDrakeLv>=1&&(GetItemPossessedBy(oPC,"mod_clas_drred")==OBJECT_INVALID)
    &&(GetItemPossessedBy(oPC,"mod_clas_drbla")==OBJECT_INVALID)&&(GetItemPossessedBy(oPC,"mod_clas_drgre")==OBJECT_INVALID)
    &&(GetItemPossessedBy(oPC,"mod_clas_drblu")==OBJECT_INVALID)&&(GetItemPossessedBy(oPC,"mod_clas_drwhi")==OBJECT_INVALID)
    &&(GetItemPossessedBy(oPC,"mod_clas_droro")==OBJECT_INVALID)&&(GetItemPossessedBy(oPC,"mod_clas_drarg")==OBJECT_INVALID)
    &&(GetItemPossessedBy(oPC,"mod_clas_drbro")==OBJECT_INVALID)&&(GetItemPossessedBy(oPC,"mod_clas_drott")==OBJECT_INVALID)
    &&(GetItemPossessedBy(oPC,"mod_clas_drram")==OBJECT_INVALID)){
        location oOldLocation = GetLocation(oPC);
        SetLocalLocation(oPC,"mod_return",oOldLocation);
        ExecuteScript("mod_pc_levelup_k",oPC);
    }
    if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drred")!=OBJECT_INVALID){
        SetCreatureWingType(68,oPC);
        SetCreatureTailType(12,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drbla")!=OBJECT_INVALID){
        SetCreatureWingType(65,oPC);
        SetCreatureTailType(9,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drgre")!=OBJECT_INVALID){
        SetCreatureWingType(66,oPC);
        SetCreatureTailType(11,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drblu")!=OBJECT_INVALID){
        SetCreatureWingType(67,oPC);
        SetCreatureTailType(10,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drwhi")!=OBJECT_INVALID){
        SetCreatureWingType(64,oPC);
        SetCreatureTailType(13,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_droro")!=OBJECT_INVALID){
        SetCreatureWingType(63,oPC);
        SetCreatureTailType(8,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drarg")!=OBJECT_INVALID){
        SetCreatureWingType(62,oPC);
        SetCreatureTailType(7,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drbro")!=OBJECT_INVALID){
        SetCreatureWingType(60,oPC);
        SetCreatureTailType(5,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drott")!=OBJECT_INVALID){
        SetCreatureWingType(59,oPC);
        SetCreatureTailType(4,oPC);
    }
    else if(nDrakeLv==9&&GetItemPossessedBy(oPC,"mod_clas_drram")!=OBJECT_INVALID){
        SetCreatureWingType(61,oPC);
        SetCreatureTailType(6,oPC);
    }
    ExecuteScript("mod_clas_poly_de",oPC);
    int stampa1=GetLocalInt(oPC,"class_special");
    int stampa2=GetLocalInt(oPC,"car_ability");
    if(GetLocalInt(oPC,"car_ability")==0)
        DelayCommand(1.0,ExecuteScript("mod_pc_lev_car",oPC));
    DelayCommand(1.0,ExecuteScript("mod_pc_lev_cla",oPC));
}
