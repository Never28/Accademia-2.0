//::///////////////////////////////////////////////
//:: Associate: Heartbeat
//:: NW_CH_AC1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move towards master or wait for him
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:: Updated On: Jul 25, 2003 - Georg Zoeller
//:://////////////////////////////////////////////

#include "X0_INC_HENAI"
#include "X2_INC_SUMMSCALE"
#include "X2_INC_SPELLHOOK"

void main()
{   //SpawnScriptDebugger();
    // GZ: Fallback for timing issue sometimes preventing epic summoned creatures from leveling up to their master's level.
    // There is a timing issue with the GetMaster() function not returning the fof a creature
    // immediately after spawn. Some code which might appear to make no sense has been added
    // to the nw_ch_ac1 and x2_inc_summon files to work around this
    // This code is only run at the first hearbeat
    object oMaster = GetMaster();
    if(GetIsDead(OBJECT_SELF)==FALSE){
        SetPlotFlag(OBJECT_SELF, FALSE);
        SetIsDestroyable(TRUE, TRUE, TRUE);
    }
    if(GetIsObjectValid(oMaster)){
        object oPC =  GetFirstFactionMember(oMaster,TRUE);
        while(oPC!=OBJECT_INVALID){
            if(oPC != oMaster){
                if(GetArea(oPC) == GetArea(oMaster)&&GetStringLeft(GetResRef(GetArea(oMaster)),3)!="cit"){
                    AssignCommand(OBJECT_SELF,SpeakString("Vedo che sei stato raggiunto da altri avventurieri, se avrai ancora bisogno di me mi trovi in locanda"));
                    RemoveHenchman(oMaster,OBJECT_SELF);
                    AssignCommand(OBJECT_SELF,ClearAllActions());
                    string sTag = GetTag(OBJECT_SELF);
                    if(sTag == "png_xzar")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t1"))));
                    else if(sTag == "png_imoen")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t2"))));
                    else if(sTag == "png_montaron")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t3"))));
                    else if(sTag == "png_xan")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t1"))));
                    else if(sTag == "png_minsc")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t2"))));
                    else if(sTag == "png_branwen")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t3"))));
                    else if(sTag == "png_kagain")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t1"))));
                    else if(sTag == "png_sharteel")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t2"))));
                    else if(sTag == "png_garrick")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t3"))));
                    else if(sTag == "png_jaheira")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t1"))));
                    else if(sTag == "png_khalid")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t2"))));
                    else if(sTag == "png_kivan")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t3"))));
                    else if(sTag == "png_alora")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t1"))));
                    else if(sTag == "png_quayle")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t2"))));
                    else if(sTag == "png_ajantis")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t3"))));
                    else if(sTag == "png_eldoth")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t1"))));
                    else if(sTag == "png_tiax")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t2"))));
                    else if(sTag == "png_yeslick")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t3"))));
                }
            }
            oPC = GetNextFactionMember(oMaster,TRUE);
        }
    }
    else{
            AssignCommand(OBJECT_SELF,ClearAllActions());
                    string sTag = GetTag(OBJECT_SELF);
                    if(GetIsDead(OBJECT_SELF)==FALSE){
                    if(sTag == "png_xzar")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t1"))));
                    else if(sTag == "png_imoen")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t2"))));
                    else if(sTag == "png_montaron")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("can_tav_t3"))));
                    else if(sTag == "png_xan")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t1"))));
                    else if(sTag == "png_minsc")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t2"))));
                    else if(sTag == "png_branwen")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("nas_tav_t3"))));
                    else if(sTag == "png_kagain")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t1"))));
                    else if(sTag == "png_sharteel")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t2"))));
                    else if(sTag == "png_garrick")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("ber_tav_t3"))));
                    else if(sTag == "png_jaheira")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t1"))));
                    else if(sTag == "png_khalid")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t2"))));
                    else if(sTag == "png_kivan")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("loc_tav_t3"))));
                    else if(sTag == "png_alora")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t1"))));
                    else if(sTag == "png_quayle")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t2"))));
                    else if(sTag == "png_ajantis")
                        DelayCommand(0.5,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("bal_tav_t3"))));
                    else if(sTag == "png_eldoth")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t1"))));
                    else if(sTag == "png_tiax")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t2"))));
                    else if(sTag == "png_yeslick")
                        DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionJumpToObject(GetWaypointByTag("dag_tav_t3"))));
    }}
    int nLevel =SSMGetSummonFailedLevelUp(OBJECT_SELF);
    if (nLevel != 0)
    {
        int nRet;
        if (nLevel == -1) // special shadowlord treatment
        {
          SSMScaleEpicShadowLord(OBJECT_SELF);
        }
        else if  (nLevel == -2)
        {
          SSMScaleEpicFiendishServant(OBJECT_SELF);
        }
        else
        {
            nRet = SSMLevelUpCreature(OBJECT_SELF, nLevel, CLASS_TYPE_INVALID);
            if (nRet == FALSE)
            {
                WriteTimestampedLogEntry("WARNING - nw_ch_ac1:: could not level up " + GetTag(OBJECT_SELF) + "!");
            }
        }

        // regardless if the actual levelup worked, we give up here, because we do not
        // want to run through this script more than once.
        SSMSetSummonLevelUpOK(OBJECT_SELF);
    }

    // Check if concentration is required to maintain this creature
    X2DoBreakConcentrationCheck();


    if(!GetAssociateState(NW_ASC_IS_BUSY))
    {

        //Seek out and disable undisabled traps
        object oTrap = GetNearestTrapToObject();
        if (bkAttemptToDisarmTrap(oTrap) == TRUE) return ; // succesful trap found and disarmed

        if(GetIsObjectValid(oMaster) &&
            GetCurrentAction(OBJECT_SELF) != ACTION_FOLLOW &&
            GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP &&
            GetCurrentAction(OBJECT_SELF) != ACTION_OPENLOCK &&
            GetCurrentAction(OBJECT_SELF) != ACTION_REST &&
            GetCurrentAction(OBJECT_SELF) != ACTION_ATTACKOBJECT)
        {
            if(
               !GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))
              )
            {
                if (GetIsObjectValid(oMaster) == TRUE)
                {
                    if(GetDistanceToObject(oMaster) > 6.0)
                    {
                        if(GetAssociateState(NW_ASC_HAVE_MASTER))
                        {
                            if(!GetIsFighting(OBJECT_SELF))
                            {
                                if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                                {
                                    if(GetDistanceToObject(GetMaster()) > GetFollowDistance())
                                    {
                                        ClearActions(CLEAR_NW_CH_AC1_49);
                                        if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                        {
                                             if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                             {
                                                //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                                //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                             }
                                             if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                             {
                                                ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                             }
                                             //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                             ActionForceFollowObject(oMaster, GetFollowDistance());
                                        }
                                        else
                                        {
                                             //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                             ActionForceFollowObject(oMaster, GetFollowDistance());
                                             //ActionForceMoveToObject(GetMaster(), TRUE, GetFollowDistance(), 5.0);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                else if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(GetIsObjectValid(oMaster))
                    {
                        if(GetCurrentAction(oMaster) != ACTION_REST)
                        {
                            ClearActions(CLEAR_NW_CH_AC1_81);
                            if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                            {
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                 {
                                    //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                    //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                 }
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                 {
                                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                 }
                                 //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                            else
                            {
                                 //MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                        }
                    }
                }
            }
            else if(!GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                //DetermineCombatRound();
            }

        }
        // * if I am dominated, ask for some help
        if (GetHasEffect(EFFECT_TYPE_DOMINATED, OBJECT_SELF) == TRUE && GetIsEncounterCreature(OBJECT_SELF) == FALSE)
        {
            SendForHelp();
        }

        if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
        }
    }
}




