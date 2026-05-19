/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// Funzione Difesa finale del DN

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oSpellOrigin;
    object oSpellTarget;
    object oTarget;
    string sName1,sName2;
    location lTarget,lPC;
    float fDistance;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ONHITCAST:
            oItem  =  GetSpellCastItem();
            oPC = OBJECT_SELF;
            oSpellOrigin = OBJECT_SELF ;
            oSpellTarget = GetSpellTargetObject();
            break;

        case X2_ITEM_EVENT_ACTIVATE:
            oPC   = GetItemActivator();
            oItem = GetItemActivated();
            oTarget = GetItemActivatedTarget();
            lTarget = GetLocation(oTarget);
            lPC = GetLocation(oPC);
            fDistance = GetDistanceBetweenLocations(lTarget,lPC);
            if(GetIsFriend(oTarget,oPC)==TRUE&&GetIsPC(oTarget)==TRUE){
                if(fDistance >= 10.0){
                    SendMessageToPC(oPC,"Sei troppo lontano per poter utilizzare l'abilita'");
                }
                else{
                    AssignCommand(oPC,ActionJumpToLocation(lTarget));
                    if(GetIsPC(oTarget) == TRUE){
                        AssignCommand(oTarget,ClearAllActions(TRUE));
                        DelayCommand(1.0,AssignCommand(oTarget,ActionJumpToLocation(lPC)));
                        sName1 = GetName(oPC);
                        sName2 = GetName(oTarget);
                        AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
                        AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK));
                        SendMessageToPC(oPC,sName1+" Prende le difese di "+sName2);
                        SendMessageToPC(oTarget,sName1+" Prende le difese di "+sName2);
                    }
                    SendMessageToPC(oPC,"Puoi prendere le difese solo dei giocatori");
                }
            }
            else{
                SendMessageToPC(oPC,"Non puoi prendere le difese di qualcuno che ti e' Ostile");
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

