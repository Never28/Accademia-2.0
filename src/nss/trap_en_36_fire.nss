#include "X0_I0_SPELLS"
#include "x3_inc_string"

const int SKILL_CD_SEARCH = 65;
const int ROLL_DAMAGE = 31;
const int LEVEL = 36;
const int DAMAGE_TYPE = DAMAGE_TYPE_FIRE;
const int DAMAGE_SAVING = SAVING_THROW_TYPE_FIRE;
const int VFX_1 = VFX_IMP_FLAME_M;
const int VFX_2 = VFX_BEAM_FIRE;
const int VFX_3 = VFX_DUR_AURA_RED;
const int VFX_4 = VFX_DUR_AURA_FIRE;
const string TYPE_TRAP = "rodon_pf";
const string ACTIVATION = "script_rodon_act";
const string DETECTION = "script_rodon_det";
const string DISABLE = "script_rodon_dis";

void SafeDestroyObject(object oObject)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

int GetDamageRoll(int nRoll,int nLevel){
    int nDamage;
    if(nRoll == 1)
        nDamage = d4(nLevel)+1;
    else if(nRoll == 11)
        nDamage = d6(nLevel)+1;
    else if(nRoll == 21)
        nDamage = d4(nLevel*2)+1;
    else if(nRoll == 31)
        nDamage = d6(nLevel*2)+1;
    else if(nRoll == 40)
        nDamage = d8(nLevel*2)+1;
    return nDamage;
}

void CreateObjectTrap(int nObjectType, string sTemplate, location lLocation){
    object oObject = CreateObject(nObjectType, sTemplate, lLocation, FALSE);
}

void TrappolaHeartbeat(object oAOE){
    int nDisable = GetLocalInt(OBJECT_SELF,DISABLE);
    object oTrap = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_PLACEABLE);
    while(oTrap!=OBJECT_INVALID&&GetLocalInt(oTrap,"not_trap")==1){
        oTrap = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_PLACEABLE);
    }
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_CREATURE);
    while(oTarget!=OBJECT_INVALID){
        if(nDisable == 0){
            if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oTarget) < 11 && GetIsDead(oTarget)==FALSE){
                int nThief = GetLevelByClass(CLASS_TYPE_ROGUE,oTarget);
                int nDam = GetDamageRoll(ROLL_DAMAGE,LEVEL);
                float fDamage = (IntToFloat(nDam)/100.0)*65.0;
                nDam = FloatToInt(fDamage);
                nDam = GetReflexAdjustedDamage(nDam, oTarget, 10+LEVEL, DAMAGE_SAVING);
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE);
                effect eVis = EffectVisualEffect(VFX_1);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE),oTarget);
                AssignCommand(oTrap,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_2), oTarget,3.0));
                int nSearch = GetSkillRank(SKILL_SEARCH,oTarget);
                if(nThief == 40)
                    nSearch = 20 + nSearch;
                else
                    nSearch = d20(1) + nSearch;
                if(nSearch >= SKILL_CD_SEARCH){
                    int nDetection = GetLocalInt(OBJECT_SELF,DETECTION);
                    if(nDetection == 0){
                        SetLocalInt(OBJECT_SELF,DETECTION,1);
                        string sResRef = GetResRef(oTrap);
                        string sResRef2 = StringReplace(sResRef,"s","f");
                        SafeDestroyObject(oTrap);
                        object oNewTrap = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef2, GetLocation(oTrap));
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_3),oNewTrap,29.5);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_4),oNewTrap,29.5);
                        DelayCommand(29.5,SafeDestroyObject(oNewTrap));
                        DelayCommand(29.5,DeleteLocalInt(OBJECT_SELF,DETECTION));
                        DelayCommand(30.0,CreateObjectTrap(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(OBJECT_SELF)));
                    }
                }
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_CREATURE);
    }
    DelayCommand(6.0,TrappolaHeartbeat(oAOE));
}

void main()
{
    object oTarget = GetEnteringObject();
    int nActivated = GetLocalInt(OBJECT_SELF,ACTIVATION);
    if(nActivated == 0){
        SetLocalInt(OBJECT_SELF,ACTIVATION,1);
        DelayCommand(6.0,TrappolaHeartbeat(OBJECT_SELF));
    }
    object oTrap = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_PLACEABLE);
    while(oTrap!=OBJECT_INVALID&&GetLocalInt(oTrap,"not_trap")==1){
        oTrap = GetNextObjectInShape(SHAPE_SPHERE, 5.0, GetLocation(OBJECT_SELF),FALSE,OBJECT_TYPE_PLACEABLE);
    }
    int nDisable = GetLocalInt(OBJECT_SELF,DISABLE);
    if(nDisable == 0){
        if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,oTarget) < 11 && GetIsDead(oTarget)==FALSE){
            int nThief = GetLevelByClass(CLASS_TYPE_ROGUE,oTarget);
            int nDam = GetDamageRoll(ROLL_DAMAGE,LEVEL);
            float fDamage = (IntToFloat(nDam)/100.0)*65.0;
            nDam = FloatToInt(fDamage);
            nDam = GetReflexAdjustedDamage(nDam, oTarget, 10+LEVEL, DAMAGE_SAVING);
            effect eDam = EffectDamage(nDam, DAMAGE_TYPE);
            effect eVis = EffectVisualEffect(VFX_1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE),oTarget);
            AssignCommand(oTrap,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_2), oTarget,3.0));
            int nSearch = GetSkillRank(SKILL_SEARCH,oTarget);
            if(nThief == 40)
                nSearch = 20 + nSearch;
            else
                nSearch = d20(1) + nSearch;
            if(nSearch >= SKILL_CD_SEARCH){
                int nDetection = GetLocalInt(OBJECT_SELF,DETECTION);
                if(nDetection == 0){
                    SetLocalInt(OBJECT_SELF,DETECTION,1);
                    string sResRef = GetResRef(oTrap);
                    string sResRef2 = StringReplace(sResRef,"s","f");
                    SafeDestroyObject(oTrap);
                    object oNewTrap = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef2, GetLocation(oTrap));
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_3),oNewTrap,29.5);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_4),oNewTrap,29.5);
                    DelayCommand(29.5,SafeDestroyObject(oNewTrap));
                    DelayCommand(29.5,DeleteLocalInt(OBJECT_SELF,DETECTION));
                    DelayCommand(30.0,CreateObjectTrap(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(OBJECT_SELF)));
                }
            }
        }
    }
}

