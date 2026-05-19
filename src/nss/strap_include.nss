const string TILESET_RESREF_SEWERS_169 = "tsw01";
const string TILESET_RESREF_CASTLE_INTERIOR_169 = "tni02";
const string TILESET_RESREF_CITY_INTERIOR_169 = "tni01";
const string TILESET_RESREF_FORT_INTERIOR_169 = "twc03";
const string TILESET_RESREF_CASTLE_EXTERIOR_169 = "tno01";
const string TILESET_RESREF_BARROWS_169 = "tbw01";
const string TILESET_RESREF_TROPICAL_169 = "ttz01";
const string TILESET_RESREF_WATER_CAVERNS_169 = "tdt01";

#include "x3_inc_string"

void CreateObjectTrap(object oPC,int nObjectType, string sTemplate, location lLocation, string sNewTag, string sTrapScript,int nType);
void CreaTrappola(object oPC,location loPC,string sForm,string sTypeTrap, string sTrapScript,int nType);
string sCarattereTileset(string sTileSet);
void ProvaAbilitaTrappole(object oPC,int nTrapRank1,int nTrapRank2,int nCDCraftTrap,int nCDSetTrap,location loPC,string sForm,string sTypeTrap, string sTrapScript,int nSearch,int nDisable,int nType);
void SafeDestroyObject(object oObject);
void SetInt(object oPC,int nType,location lLocation);

void SetInt(object oPC,int nType,location lLocation){
    object oTrap = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lLocation,FALSE,OBJECT_TYPE_AREA_OF_EFFECT);
    while(oTrap!=OBJECT_INVALID){
        SetLocalInt(oTrap,"Trap_Type",nType);
        oTrap = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lLocation,FALSE,OBJECT_TYPE_AREA_OF_EFFECT);
    }
}

void CreateObjectTrap(object oPC,int nObjectType, string sTemplate, location lLocation, string sNewTag, string sTrapScript,int nType){
    object oObject = CreateObject(nObjectType, sTemplate, lLocation, FALSE, sNewTag);
    AssignCommand(oPC,ApplyEffectAtLocation(DURATION_TYPE_PERMANENT,EffectAreaOfEffect(AOE_PER_CUSTOM_AOE,sTrapScript,"",""),lLocation));
    DelayCommand(1.0,SetInt(oPC,nType,lLocation));
}

void SafeDestroyObject(object oObject)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

string sCarattereTileset(string sTileSet){
    string sForm;
    if(sTileSet == TILESET_RESREF_SEWERS_169 || sTileSet == TILESET_RESREF_SEWERS)
        sForm = "1";
    else if(sTileSet == TILESET_RESREF_DESERT)
        sForm = "2";
    else if(sTileSet == TILESET_RESREF_CITY_INTERIOR || sTileSet == TILESET_RESREF_CASTLE_INTERIOR ||
            sTileSet == TILESET_RESREF_CITY_INTERIOR_169 || sTileSet == TILESET_RESREF_CASTLE_INTERIOR_169 ||
            sTileSet == TILESET_RESREF_FORT_INTERIOR_169)
        sForm = "3";
    else if(sTileSet == TILESET_RESREF_RURAL || sTileSet == TILESET_RESREF_CASTLE_EXTERIOR_169 ||
            sTileSet == TILESET_RESREF_MICROSET)
        sForm = "4";
    else if(sTileSet == TILESET_RESREF_CITY_EXTERIOR)
        sForm = "5";
    else if(sTileSet == TILESET_RESREF_UNDERDARK || sTileSet == TILESET_RESREF_BARROWS_169 ||
            sTileSet == TILESET_RESREF_BEHOLDER_CAVES || sTileSet == TILESET_RESREF_MINES_AND_CAVERNS)
        sForm = "6";
    else if(sTileSet == TILESET_RESREF_DROW_INTERIOR)
        sForm = "7";
    else if(sTileSet == TILESET_RESREF_ILLITHID_INTERIOR)
        sForm = "8";
    else if(sTileSet == TILESET_RESREF_RURAL_WINTER || sTileSet == TILESET_RESREF_FROZEN_WASTES)
        sForm = "9";
    else if(sTileSet == TILESET_RESREF_DUNGEON)
        sForm = "a";
    else if(sTileSet == TILESET_RESREF_RUINS)
        sForm = "b";
    else if(sTileSet == TILESET_RESREF_FOREST)
        sForm = "c";
    else if(sTileSet == TILESET_RESREF_CRYPT)
        sForm = "d";
    else if(sTileSet == TILESET_RESREF_TROPICAL_169 || sTileSet == TILESET_RESREF_WATER_CAVERNS_169)
        sForm = "e";
    return sForm;
}

void ProvaAbilitaTrappole(object oPC,int nTrapRank1,int nTrapRank2,int nCDCraftTrap,int nCDSetTrap,location loPC,string sForm,string sTypeTrap, string sTrapScript,int nSearch,int nDisable,int nType){
    if(nTrapRank1 >= nCDCraftTrap){
        if(nTrapRank2 >= nCDSetTrap){
            DelayCommand(0.0,SetLocalInt(oPC,"Trap1_Activation",0));
            DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Creare Trappole Riuscita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nCDCraftTrap)));
            DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Piazzare Trappole Riuscita: "+IntToString(nTrapRank2)+" contro CD: "+IntToString(nCDSetTrap)));
            DelayCommand(6.0,SetLocalInt(oPC,"Trap1_Search",nSearch));
            DelayCommand(6.0,SetLocalInt(oPC,"Trap1_Disable",nDisable));
            DelayCommand(6.0,SetLocalInt(oPC,"Trap1_Usi",0));
            DelayCommand(6.0,SetLocalString(oPC,"Trap1_Type",sTypeTrap));
            DelayCommand(6.0,CreaTrappola(oPC,loPC,sForm,sTypeTrap,sTrapScript,nType));
        }
        else{
            DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Creare Trappole Riuscita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nCDCraftTrap)));
            DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Piazzare Trappole Fallita: "+IntToString(nTrapRank2)+" contro CD: "+IntToString(nCDSetTrap)));
        }
    }
    else
        DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Creare Trappole Fallita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nCDCraftTrap)));
}

void CreaTrappola(object oPC,location loPC,string sForm,string sTypeTrap, string sTrapScript,int nType){
    location loPC2 = GetLocation(oPC);
    if(loPC2 == loPC){
        string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
        sName = StringReplace(sName,".","Y");
        sName = StringReplace(sName,"-","Z");
        sName = StringReplace(sName,"_","K");
        object oOldTrap = GetObjectByTag(sTypeTrap+sName);
        SafeDestroyObject(oOldTrap);
        int nRandom = Random(3)+1;
        string sRandom = IntToString(nRandom);
        sForm = "trap_"+sForm+sRandom;
        DelayCommand(0.5,CreateObjectTrap(oPC,OBJECT_TYPE_PLACEABLE,sForm,loPC2,sTypeTrap+sName,sTrapScript,nType));
    }
    else
        SendMessageToPC(oPC,"Non devi muoverti durante il piazzamento di una trappola");
}
