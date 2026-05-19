#include "x2_inc_switches"

void SafeDestroyObject(object oObject)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

void main()
{
    object oTrapper;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    object oPC = OBJECT_SELF;
    int nCasterLevel = GetCasterLevel(oPC);
    int nSpellCraft = GetSkillRank(SKILL_SPELLCRAFT,oPC);
    int nDice = d20(1);
    int nRollTest = nDice+(nSpellCraft/2)+nCasterLevel;
    location lTarget = GetSpellTargetLocation();
    object oAOE = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget,FALSE,OBJECT_TYPE_AREA_OF_EFFECT);
    while(oAOE != OBJECT_INVALID){
        oTrapper = GetAreaOfEffectCreator(oAOE);
        location loPC2 = GetLocation(oPC);
        int nTrapDCDisable,nTrapDCSearch;
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
                if(nRollTest >= nTrapDCSearch){
                    if(nRollTest >= nTrapDCDisable){
                        DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),GetLocation(oAOE)));
                        DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCSearch)));
                        DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Riuscita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCDisable)));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Detection"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Usi"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Activation"));
                        DelayCommand(0.0,DeleteLocalString(oTrapper,sTrap+"Type"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Search"));
                        DelayCommand(0.0,DeleteLocalInt(oTrapper,sTrap+"Disable"));
                    }
                    else{
                        DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCSearch)));
                        DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Fallita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCDisable)));
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
                        if(nRollTest >= nTrapDCSearch){
                            if(nRollTest >= nTrapDCDisable){
                                DelayCommand(0.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_KNOCK),GetLocation(oAOE)));
                                DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCSearch)));
                                DelayCommand(0.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Riuscita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCDisable)));
                                GiveXPToCreature(oPC,400);
                                SetLocalInt(oAOE,"script_rodon_dis",1);
                            }
                            else{
                                DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Cercare Trappole Riuscita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCSearch)));
                                DelayCommand(6.0,SendMessageToPC(oPC,"Prova di Disattivare Trappole Fallita: "+IntToString(nRollTest)+" contro CD: "+IntToString(nTrapDCDisable)));
                            }
                        }
                    }
                }
            }
        }
        oAOE = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lTarget,FALSE,OBJECT_TYPE_AREA_OF_EFFECT);
    }
}
