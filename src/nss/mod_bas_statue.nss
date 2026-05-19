void ControllStatue(string sStatua,int nLevel,object oPC,int nDado){
    if(GetItemPossessedBy(oPC,sStatua) == OBJECT_INVALID){
        if(nDado >= nLevel)
            CreateItemOnObject(sStatua,oPC);
        else
            SendMessageToPC(oPC,"Non puoi avere il simbolo di questa regione, necessiti di essere di livello "+IntToString(nLevel));
    }
    else
        SendMessageToPC(oPC,"Hai gia' il simbolo di questa regione");
}

void main()
{
    string sItem = GetTag(OBJECT_SELF);
    object oPC = GetLastUsedBy();
    int nDado = GetHitDice(oPC);
    if(sItem == "mod_statua_bere"){
        ControllStatue("mod_simb_bere",10,oPC,nDado);
    }
    else if(sItem == "mod_statua_nask"){
        ControllStatue("mod_simb_nask",10,oPC,nDado);
    }
    else if(sItem == "mod_statua_loc"){
        ControllStatue("mod_simb_loc",15,oPC,nDado);
    }
    else if(sItem == "mod_statua_bald"){
        ControllStatue("mod_simb_bald",25,oPC,nDado);
    }
    else if(sItem == "mod_statua_dagge"){
        ControllStatue("mod_simb_dagge",35,oPC,nDado);
    }
    else if(sItem == "mod_statua_atha"){
        ControllStatue("mod_simb_atha",40,oPC,nDado);
    }
}
