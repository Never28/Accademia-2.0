#include "x2_inc_switches"
#include "strap_include"

const int SKILL_CD_SEARCH_TRAP = 20;
const int SKILL_CD_DISABLE_TRAP = 20;
const int SKILL_CD_SET_TRAP = 30;
const int SKILL_CD_CRAFT_TRAP = 20;
const string TYPE_TRAP = "1_";
const int TYPE_T = 1;
const int DAMAGE_TYPE = DAMAGE_TYPE_FIRE;
const int DAMAGE_SAVING = SAVING_THROW_TYPE_FIRE;
const string TRAP_SCRIPT = "trap_lv_11_fire";

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    int Trap,nTrapRank1,nTrapRank2,nThief,nAss,nRang,nRandom;
    object oSpellOrigin;
    object oSpellTarget;
    string sTileSet,sForm,sRandom,sTrap;
    effect eVis2;
    int iSpell;
    int nFeat;
    object oTrap;
    location lTarget,loPC;
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
            oSpellTarget = GetSpellTargetObject();
            nThief = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
            nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
            nRang = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
            nAss = nThief+nAss+nRang;
            if(nAss>=1){
                sTileSet = GetTilesetResRef(GetArea(oPC));
                sForm = sCarattereTileset(sTileSet);
                nTrapRank1 = GetSkillRank(SKILL_CRAFT_TRAP,oPC);
                nTrapRank2 = GetSkillRank(SKILL_SET_TRAP,oPC);
                lTarget = GetSpellTargetLocation();
                loPC = GetLocation(oPC);
                AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0));
                if(GetIsInCombat(oPC)==TRUE){
                    if(GetHasFeat(FEAT_SKILL_MASTERY,oPC)==TRUE){
                        nTrapRank2 = 20 + nTrapRank2;
                        if(nThief==40)
                            nTrapRank1 = 20 + nTrapRank1;
                        else
                            nTrapRank1 = d20(1) + nTrapRank1;
                       ProvaAbilitaTrappole(oPC,nTrapRank1,nTrapRank2,SKILL_CD_CRAFT_TRAP,SKILL_CD_SET_TRAP,loPC,sForm,TYPE_TRAP,TRAP_SCRIPT,SKILL_CD_SEARCH_TRAP,SKILL_CD_DISABLE_TRAP,TYPE_T);
                    }
                    else{
                        nTrapRank1 = d20(1)+nTrapRank1;
                        nTrapRank2 = d20(1)+nTrapRank2;
                        ProvaAbilitaTrappole(oPC,nTrapRank1,nTrapRank2,SKILL_CD_CRAFT_TRAP,SKILL_CD_SET_TRAP,loPC,sForm,TYPE_TRAP,TRAP_SCRIPT,SKILL_CD_SEARCH_TRAP,SKILL_CD_DISABLE_TRAP,TYPE_T);
                    }
                }
                else{
                    nTrapRank2 = 20+nTrapRank2;
                    if(nThief==40)
                        nTrapRank1 = 20+nTrapRank1;
                    else
                        nTrapRank1 = d20(1)+nTrapRank1;
                    ProvaAbilitaTrappole(oPC,nTrapRank1,nTrapRank2,SKILL_CD_CRAFT_TRAP,SKILL_CD_SET_TRAP,loPC,sForm,TYPE_TRAP,TRAP_SCRIPT,SKILL_CD_SEARCH_TRAP,SKILL_CD_DISABLE_TRAP,TYPE_T);

                }
            }
            break;;
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

