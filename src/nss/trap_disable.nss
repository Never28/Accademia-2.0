#include "x2_inc_switches"

void SafeDestroyObject(object oObject)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

void DisarmTrap(object oPC,object oTrapper,object oAOE,location loPC,int nTrapRank1,int nTrapRank2){
    location loPC2 = GetLocation(oPC);
    int nTrapDCDisable,nTrapDCSearch;
    if(loPC2 == loPC){
        int nType = GetLocalInt(oAOE,"Trap_Type");
        string sTrap = "Trap"+IntToString(nType)+"_";
        if(oTrapper == oPC){
            nTrapDCDisable = GetLocalInt(oTrapper,sTrap+"Disable");
            nTrapDCSearch = GetLocalInt(oTrapper,sTrap+"Search");
            if(nTrapDCDisable > 0 && nTrapDCSearch > 0){
                DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),GetLocation(oAOE)));
                DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Detection"));
                DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Usi"));
                DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Activation"));
                DelayCommand(0.0,DeleteLocalString(oTrapper,sTrap+"Type"));
                DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Search"));
                DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Disable"));
            }
        }
        else{
            nTrapDCDisable = GetLocalInt(oTrapper,sTrap+"Disable");
            nTrapDCSearch = GetLocalInt(oTrapper,sTrap+"Search");
            if(nTrapDCDisable > 0 && nTrapDCSearch > 0){
                if(nTrapRank2 >= nTrapDCSearch){
                    if(nTrapRank1 >= nTrapDCDisable){
                        DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),GetLocation(oAOE)));
                        DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nTrapRank2)+" contro CD: "+IntToString(nTrapDCSearch)));
                        DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Riuscita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nTrapDCDisable)));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Detection"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Usi"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Activation"));
                        DelayCommand(0.0,DeleteLocalString(oTrapper,sTrap+"Type"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Search"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Disable"));
                    }
                    else{
                        DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nTrapRank2)+" contro CD: "+IntToString(nTrapDCSearch)));
                        DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Fallita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nTrapDCDisable)));
                    }
                }
            }
            else{
                object oArea = GetArea(oPC);
                string sArea = GetTag(oArea);
                if(sArea == "dun_cov_ban"||sArea == "dun_cov_ban_sup"||sArea == "dun_cov_ban_nas"){
                    int nDisable = GetLocalInt(oAOE,"script_rodon_dis");
                    if(nDisable==0){
                        nTrapDCSearch = 65;
                        nTrapDCDisable = 65;
                        if(nTrapRank2 >= nTrapDCSearch){
                            if(nTrapRank1 >= nTrapDCDisable){
                                DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),GetLocation(oAOE)));
                                DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nTrapRank2)+" contro CD: "+IntToString(nTrapDCSearch)));
                                DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Riuscita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nTrapDCDisable)));
                                GiveXPToCreature(oPC,400);
                                SetLocalInt(oAOE,"script_rodon_dis",1);
                            }
                            else{
                                DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nTrapRank2)+" contro CD: "+IntToString(nTrapDCSearch)));
                                DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Fallita: "+IntToString(nTrapRank1)+" contro CD: "+IntToString(nTrapDCDisable)));
                            }
                        }
                    }
                }
            }
        }
    }
    else
        SendMessageToPC(oPC,"Non devi muoverti durante la disattivazione di una trappola");
}

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC,oTrapper;
    object oItem;
    int nTrapRank1,nTrapRank2,nThief;
    object oTarget;
    object oSpellOrigin;
    location lTarget;
    object oSpellTarget;
    int iSpell;
    int nResult = X2_EXECUTE_SCRIPT_END;
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
            nThief = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
            lTarget = GetItemActivatedTargetLocation();
            nTrapRank1 = GetSkillRank(SKILL_DISABLE_TRAP,oPC);
            nTrapRank2 = GetSkillRank(SKILL_SEARCH,oPC);
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
            if(GetIsInCombat(oPC)==TRUE){
                if(GetHasFeat(FEAT_SKILL_MASTERY,oPC)==TRUE){
                    nTrapRank1 = 20+nTrapRank1;
                    if(nThief==40)
                        nTrapRank2 = 20+nTrapRank2;
                    else
                        nTrapRank2 = d20(1)+nTrapRank2;
                }
                else{
                    nTrapRank1 = d20(1)+nTrapRank1;
                    nTrapRank2 = d20(1)+nTrapRank2;
                }
            }
            else{
                nTrapRank1 = 20+nTrapRank1;
                if(nThief==40)
                    nTrapRank2 = 20+nTrapRank2;
                else
                    nTrapRank2 = d20(1)+nTrapRank2;
            }

            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget,FALSE,OBJECT_TYPE_ALL);
            while(oTarget != OBJECT_INVALID){
                if(GetObjectType(oTarget)==OBJECT_TYPE_AREA_OF_EFFECT){
                    oTrapper = GetAreaOfEffectCreator(oTarget);
                    DelayCommand(6.0,DisarmTrap(oPC,oTrapper,oTarget,GetLocation(oPC),nTrapRank1,nTrapRank2));
                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lTarget,FALSE,OBJECT_TYPE_ALL);
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

