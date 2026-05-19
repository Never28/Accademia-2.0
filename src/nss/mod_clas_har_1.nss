/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 14-06-2011
*/

#include "x2_inc_switches"
#include "x3_inc_string"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void CreaSpeciale(object oPC,int nObjectType, string sTemplate, location lLocation, string sNewTag);
void Balista(object oPC,string sName);
void Catapulta(object oPC,string sName);
void Colonna(object oPC,int nWeap,string sName);
void SafeDestroyObject(object oObject);
void PiazzamentoBalista(object oPC,string sName,location lLocation);
void PiazzamentoCatapulta(object oPC,string sName,location lLocation);
void PiazzamentoColonna(object oPC,int nWeap,string sName,location lLocation);
void CatapultaEffect(object oTarget,object oPC,effect eDamage2,effect eVis2,effect eMissile);

void PiazzamentoBalista(object oPC,string sName,location lLocation){
    if(GetLocation(oPC)==lLocation)
        DelayCommand(2.0,Balista(oPC,sName));
    else
        SendMessageToPC(oPC,"Non devi muoverti durante il piazzamento della Balista");
   return;
}

void PiazzamentoCatapulta(object oPC,string sName,location lLocation){
    if(GetLocation(oPC)==lLocation)
        DelayCommand(2.0,Catapulta(oPC,sName));
    else
        SendMessageToPC(oPC,"Non devi muoverti durante il piazzamento della Balista");
   return;
}
void PiazzamentoColonna(object oPC,int nWeap,string sName,location lLocation){
    if(GetLocation(oPC)==lLocation)
        DelayCommand(2.0,Colonna(oPC,nWeap,sName));
    else
        SendMessageToPC(oPC,"Non devi muoverti durante il piazzamento della Balista");
   return;
}

void SafeDestroyObject(object oObject){
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

void CreaSpeciale(object oPC,int nObjectType, string sTemplate, location lLocation, string sNewTag){
    object oObject = CreateObject(nObjectType, sTemplate, lLocation, FALSE, "F"+sNewTag);
    AssignCommand(oObject,SetLocalObject(oObject,"Tirante",oPC));
    return;
}

void Balista(object oPC,string sName){
    object oArmaSpec = GetObjectByTag("F"+sName);
    if(GetIsObjectValid(oPC)==TRUE){
        if(GetArea(oPC)==GetArea(oArmaSpec)){
            if(oArmaSpec == OBJECT_INVALID)
                return;
            else{
                ExecuteScript("mod_clas_har_s",oArmaSpec);
            }
            DelayCommand(6.0,Balista(oPC,sName));
        }
        else
            SafeDestroyObject(oArmaSpec);
    }
    else
        SafeDestroyObject(oArmaSpec);
    return;
}

void Catapulta(object oPC,string sName){
    object oArmaSpec = GetObjectByTag("F"+sName);
    if(GetIsObjectValid(oPC)==TRUE){
        if(GetArea(oPC)==GetArea(oArmaSpec)){
            if(oArmaSpec == OBJECT_INVALID)
                return;
            else{
                ExecuteScript("mod_clas_har_e",oArmaSpec);
            }
            DelayCommand(6.0,Catapulta(oPC,sName));
        }
        else
            SafeDestroyObject(oArmaSpec);
    }
    else
        SafeDestroyObject(oArmaSpec);
    return;
}

void Colonna(object oPC,int nWeap,string sName){
    object oArmaSpec = GetObjectByTag("F"+sName);
    if(GetIsObjectValid(oPC)==TRUE){
        if(GetArea(oPC)==GetArea(oArmaSpec)){
            if(oArmaSpec == OBJECT_INVALID)
                return;
            else{
                object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oArmaSpec),TRUE,OBJECT_TYPE_CREATURE);
                while(GetIsEnemy(oTarget,oPC)==FALSE&&oTarget!=OBJECT_INVALID){
                    oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oArmaSpec),TRUE,OBJECT_TYPE_CREATURE);
                }
                if(oTarget!=OBJECT_INVALID){
                    SetLocalObject(oPC,"TargetColonna",oTarget);
                    if(nWeap==3)
                        ExecuteScript("mod_clas_har_h",oPC);
                    else if(nWeap==4)
                        ExecuteScript("mod_clas_har_i",oPC);
                    else if(nWeap==5)
                        ExecuteScript("mod_clas_har_l",oPC);
                }
            }
            DelayCommand(6.0,Colonna(oPC,nWeap,sName));
        }
        else
            SafeDestroyObject(oArmaSpec);
    }
    else
        SafeDestroyObject(oArmaSpec);
    return;
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC,oArmaSpec;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oArea;
    location loPC;
    int nSkill;
    int nWeap;
    string sWeap;
    effect eSummon;
    string sName;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
    int nCasterLevel;
    switch (nEvent){

        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            sName = StringReplace(GetPCPlayerName(oPC)," ","X");
            sName = StringReplace(sName,".","Y");
            sName = StringReplace(sName,"-","Z");
            sName = StringReplace(sName,"_","K");
            oArmaSpec = GetObjectByTag("F"+sName);
            SafeDestroyObject(oArmaSpec);
            nWeap = GetLocalInt(oPC,"har_wea");
            loPC = GetLocation(oPC);
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
            if(nWeap == 0||nWeap == 1){
                sWeap = "har_t1";
                DelayCommand(6.0,CreaSpeciale(oPC,OBJECT_TYPE_PLACEABLE, sWeap, GetLocation(oPC), sName));
                DelayCommand(5.0,PiazzamentoBalista(oPC,sName,loPC));
            }
            else if(nWeap == 2){
                sWeap = "har_t2";
                DelayCommand(6.0,CreaSpeciale(oPC,OBJECT_TYPE_PLACEABLE, sWeap, GetLocation(oPC), sName));
                DelayCommand(5.0,PiazzamentoCatapulta(oPC,sName,loPC));
            }
            else{
                sWeap = "har_t3";
                DelayCommand(6.0,CreaSpeciale(oPC,OBJECT_TYPE_PLACEABLE, sWeap, GetLocation(oPC), sName));
                DelayCommand(5.0,PiazzamentoColonna(oPC,nWeap,sName,loPC));
            }
            break;

        case X2_ITEM_EVENT_EQUIP:

            oPC = GetPCItemLastEquippedBy();
            oItem = GetPCItemLastEquipped();
            break;

        case X2_ITEM_EVENT_UNEQUIP:
            oPC    = GetPCItemLastUnequippedBy();
            oItem  = GetPCItemLastUnequipped();
            break;

        case X2_ITEM_EVENT_ACQUIRE:
            oPC = GetModuleItemAcquiredBy();
            oItem  = GetModuleItemAcquired();
            break;

        case X2_ITEM_EVENT_UNACQUIRE:
            oPC = GetModuleItemLostBy();
            oItem  = GetModuleItemLost();
            break;

       case X2_ITEM_EVENT_SPELLCAST_AT:
            oPC = OBJECT_SELF;
            oItem  = GetSpellTargetObject();
            iSpell = GetSpellId();
            nResult = X2_EXECUTE_SCRIPT_CONTINUE;
            break;
    }
    SetExecutedScriptReturnValue(nResult);
}

