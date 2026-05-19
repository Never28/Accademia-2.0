#include "X0_I0_SPELLS"
#include "x3_inc_string"
const int SKILL_CD_SEARCH = 65;
const int ROLL_DAMAGE = 31;
const int DAMAGE_TYPE = DAMAGE_TYPE_COLD;
const int DAMAGE_SAVING = SAVING_THROW_TYPE_COLD;
const int VFX_1 = VFX_IMP_FROST_L;
const int VFX_2 = VFX_BEAM_COLD;
const int VFX_3 = VFX_DUR_AURA_BLUE;
const int VFX_4 = VFX_DUR_AURA_COLD;
const string TYPE_TRAP = "1_";

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

void SafeDestroyObject(object oObject)
{
    SetIsDestroyable(TRUE);
    if(GetPlotFlag(oObject)) { DelayCommand(0.0,SetPlotFlag(oObject, FALSE)); }
    if(GetImmortal(oObject)) { DelayCommand(0.0,SetImmortal(oObject, FALSE)); }
    if(!GetDroppableFlag(oObject)) { DelayCommand(0.0,SetDroppableFlag(oObject, TRUE)); }
    DestroyObject(oObject);
}

void CreateObjectTrap(int nObjectType, string sTemplate, location lLocation, string sNewTag){
    object oObject = CreateObject(nObjectType, sTemplate, lLocation, FALSE, sNewTag);
}

void TrappolaHeartbeat(object oPC,location lLocation,object oAOE,string sTrap){
    object oTrap = GetObjectByTag(sTrap);
    if(GetIsObjectValid(oPC)==FALSE){
        DeleteLocalInt(oPC,"Trap1_Usi");
        DeleteLocalInt(oPC,"Trap1_Detection");
        DeleteLocalInt(oPC,"Trap1_Activation");
        DeleteLocalString(oPC,"Trap1_Type");
        SafeDestroyObject(oTrap);
        DeleteLocalInt(oAOE,"Trap1_Type");
        SafeDestroyObject(oAOE);
    }
    if(GetArea(oPC)!=GetArea(oTrap)){
        DeleteLocalInt(oPC,"Trap1_Usi");
        DeleteLocalInt(oPC,"Trap1_Detection");
        DeleteLocalInt(oPC,"Trap1_Activation");
        DeleteLocalString(oPC,"Trap1_Type");
        SafeDestroyObject(oTrap);
        DeleteLocalInt(oAOE,"Trap1_Type");
        SafeDestroyObject(oAOE);
    }
    int nActivate = GetLocalInt(oPC,"Trap1_Activation");
    string sTypeTrap = GetLocalString(oPC,"Trap1_Type");
    int nThief = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
    int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
    int nRang = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
    nAss = nThief+nAss+nRang;
    if(nActivate == 0){
        DeleteLocalInt(oPC,"Trap1_Usi");
        DeleteLocalInt(oPC,"Trap1_Detection");
        DeleteLocalInt(oPC,"Trap1_Activation");
        DeleteLocalString(oPC,"Trap1_Type");
        SafeDestroyObject(oTrap);
        DeleteLocalInt(oAOE,"Trap1_Type");
        SafeDestroyObject(oAOE);
    }
    else{
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,15.0,lLocation);
        while(oTarget != OBJECT_INVALID){
            int nThief2 = GetLevelByClass(CLASS_TYPE_ROGUE,oTarget);
            if (GetIsFriend(oTarget,oPC)==FALSE&&GetIsDead(oTarget)==FALSE&&GetIsDM(oTarget)==FALSE){
                int nSearch = GetSkillRank(SKILL_SEARCH,oTarget);
                if(nThief2 == 40)
                    nSearch = 20 + nSearch;
                else
                    nSearch = d20(1) + nSearch;
                if(nSearch >= SKILL_CD_SEARCH){
                    int nDetection = GetLocalInt(oPC,"Trap1_Detection");
                    if(nDetection == 0){
                        SetLocalInt(oPC,"Trap1_Detection",1);
                        string sResRef = GetResRef(oTrap);
                        string sResRef2 = "traf_"+GetStringRight(sResRef,2);
                        SafeDestroyObject(oTrap);
                        object oNewTrap = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef2, GetLocation(OBJECT_SELF), FALSE, sTrap);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_3),oNewTrap,29.5);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_4),oNewTrap,29.5);
                        DelayCommand(29.5,DeleteLocalInt(oPC,"Trap1_Detection"));
                        DelayCommand(29.5,SafeDestroyObject(oNewTrap));
                        DelayCommand(30.0,CreateObjectTrap(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(OBJECT_SELF),sTrap));
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,15.0,lLocation);
        }
        int nUsi = GetLocalInt(oPC,"Trap1_Usi");
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        while(oTarget != OBJECT_INVALID){
            int nThief2 = GetLevelByClass(CLASS_TYPE_ROGUE,oTarget);
            if(nUsi<10){
                if (GetIsFriend(oTarget,oPC)==FALSE&&GetIsDead(oTarget)==FALSE&&GetIsDM(oTarget)==FALSE){
                    nUsi = nUsi + 1;
                    int nDam = GetDamageRoll(ROLL_DAMAGE,nAss);
                    float fDamage = (IntToFloat(nDam)/100.0)*65.0;
                    nDam = FloatToInt(fDamage);
                    nDam = GetReflexAdjustedDamage(nDam, oTarget, 10+nAss, DAMAGE_SAVING, oPC);
                    effect eDam = EffectDamage(nDam, DAMAGE_TYPE);
                    effect eVis = EffectVisualEffect(VFX_1);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE),oTarget);
                    AssignCommand(oTrap,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_2), oTarget,3.0));
                    if(nUsi<=9){
                        int nSearch = GetSkillRank(SKILL_SEARCH,oTarget);
                        if(nThief2 == 40)
                            nSearch = 20 + nSearch;
                        else
                            nSearch = d20(1) + nSearch;
                        if(nSearch >= SKILL_CD_SEARCH){
                            int nDetection = GetLocalInt(oPC,"Trap1_Detection");
                            if(nDetection == 0){
                                SetLocalInt(oPC,"Trap1_Detection",1);
                                string sResRef = GetResRef(oTrap);
                                string sResRef2 = "traf_"+GetStringRight(sResRef,2);
                                SafeDestroyObject(oTrap);
                                object oNewTrap = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef2, GetLocation(OBJECT_SELF), FALSE, sTrap);
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_3),oNewTrap,29.5);
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_4),oNewTrap,29.5);
                                DelayCommand(29.5,DeleteLocalInt(oPC,"Trap1_Detection"));
                                DelayCommand(29.5,SafeDestroyObject(oNewTrap));
                                DelayCommand(30.0,CreateObjectTrap(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(OBJECT_SELF),sTrap));
                            }
                        }
                    }
                    if(nUsi>=10){
                        DeleteLocalInt(oPC,"Trap1_Detection");
                        DeleteLocalInt(oPC,"Trap1_Usi");
                        DeleteLocalInt(oPC,"Trap1_Activation");
                        DeleteLocalString(oPC,"Trap1_Type");
                        SafeDestroyObject(oTrap);
                        DeleteLocalInt(oAOE,"Trap1_Type");
                        SafeDestroyObject(oAOE);
                        return;
                    }
                    SetLocalInt(oPC,"Trap1_Usi",nUsi);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE,5.0,lLocation);
        }
        DelayCommand(6.0,TrappolaHeartbeat(oPC,lLocation,oAOE,sTrap));
    }
}

void main()
{
    object oTarget = GetEnteringObject();
    object oPC = GetAreaOfEffectCreator(OBJECT_SELF);
    int nUsi = GetLocalInt(oPC,"Trap1_Usi");
    string sTypeTrap = GetLocalString(oPC,"Trap1_Type");
    int nThief2 = GetLevelByClass(CLASS_TYPE_ROGUE,oTarget);
    int nThief = GetLevelByClass(CLASS_TYPE_ROGUE,oPC);
    int nAss = GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
    int nRang = GetLevelByClass(CLASS_TYPE_RANGER,oPC);
    nAss = nThief+nAss+nRang;
    string sName = StringReplace(GetPCPlayerName(oPC)," ","X");
    sName = StringReplace(sName,".","Y");
    sName = StringReplace(sName,"-","Z");
    sName = StringReplace(sName,"_","K");
    string sTrap = sTypeTrap+sName;
    object oTrap = GetObjectByTag(sTrap);
    int nActivate = GetLocalInt(oPC,"Trap1_Activation");
    if(nActivate == 0){
        SetLocalInt(oPC,"Trap1_Activation",1);
        DelayCommand(6.0,TrappolaHeartbeat(oPC,GetLocation(OBJECT_SELF),OBJECT_SELF,sTrap));
    }
    if(nUsi<10){
        if (GetIsFriend(oTarget,oPC)==FALSE&&GetIsDead(oTarget)==FALSE&&GetIsDM(oTarget)==FALSE){
            nUsi = nUsi + 1;
            int nDam = GetDamageRoll(ROLL_DAMAGE,nAss);
            float fDamage = (IntToFloat(nDam)/100.0)*65.0;
            nDam = FloatToInt(fDamage);
            nDam = GetReflexAdjustedDamage(nDam, oTarget, 10+nAss, DAMAGE_SAVING, oPC);
            effect eDam = EffectDamage(nDam, DAMAGE_TYPE);
            effect eVis = EffectVisualEffect(VFX_1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE),oTarget);
            AssignCommand(oTrap,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_2), oTarget,3.0));
            if(nUsi<=9){
                int nSearch = GetSkillRank(SKILL_SEARCH,oTarget);
                if(nThief2 == 40)
                    nSearch = 20 + nSearch;
                else
                    nSearch = d20(1) + nSearch;
                if(nSearch >= SKILL_CD_SEARCH){
                    int nDetection = GetLocalInt(oPC,"Trap1_Detection");
                    if(nDetection == 0){
                        SetLocalInt(oPC,"Trap1_Detection",1);
                        string sResRef = GetResRef(oTrap);
                        string sResRef2 = "traf_"+GetStringRight(sResRef,2);
                        SafeDestroyObject(oTrap);
                        object oNewTrap = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef2, GetLocation(OBJECT_SELF), FALSE, sTrap);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_3),oNewTrap,29.5);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_4),oNewTrap,29.5);
                        DelayCommand(29.5,SafeDestroyObject(oNewTrap));
                        DelayCommand(29.5,DeleteLocalInt(oPC,"Trap1_Detection"));
                        DelayCommand(30.0,CreateObjectTrap(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(OBJECT_SELF),sTypeTrap+sName));
                    }
                }
            }
            if(nUsi>=10){
                DeleteLocalInt(oPC,"Trap1_Detection");
                DeleteLocalInt(oPC,"Trap1_Usi");
                DeleteLocalInt(oPC,"Trap1_Activation");
                DeleteLocalString(oPC,"Trap1_Type");
                DeleteLocalInt(OBJECT_SELF,"Trap1_Type");
                SafeDestroyObject(oTrap);
                SafeDestroyObject(OBJECT_SELF);
            }
            SetLocalInt(oPC,"Trap1_Usi",nUsi);
        }
    }
}

