void main()
{
    object oPC = OBJECT_SELF;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC, 1);
    if(GetItemPossessedBy(oPC,"mod_clas_drred")!=OBJECT_INVALID){
        SetCreatureWingType(68,oSummon);
        SetCreatureTailType(12,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drbla")!=OBJECT_INVALID){
        SetCreatureWingType(65,oSummon);
        SetCreatureTailType(9,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drgre")!=OBJECT_INVALID){
        SetCreatureWingType(66,oSummon);
        SetCreatureTailType(11,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drblu")!=OBJECT_INVALID){
        SetCreatureWingType(67,oSummon);
        SetCreatureTailType(10,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drwhi")!=OBJECT_INVALID){
        SetCreatureWingType(64,oSummon);
        SetCreatureTailType(13,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_droro")!=OBJECT_INVALID){
        SetCreatureWingType(63,oSummon);
        SetCreatureTailType(8,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drarg")!=OBJECT_INVALID){
        SetCreatureWingType(62,oSummon);
        SetCreatureTailType(7,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drbro")!=OBJECT_INVALID){
        SetCreatureWingType(60,oSummon);
        SetCreatureTailType(5,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drott")!=OBJECT_INVALID){
        SetCreatureWingType(59,oSummon);
        SetCreatureTailType(4,oSummon);
    }
    else if(GetItemPossessedBy(oPC,"mod_clas_drram")!=OBJECT_INVALID){
        SetCreatureWingType(61,oSummon);
        SetCreatureTailType(6,oSummon);
    }
}
