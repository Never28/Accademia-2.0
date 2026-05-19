#include "mod_bad_dice"

void main()
{
    object oPC = GetEnteringObject();
    string oName= GetPCPlayerName(oPC);
    object oArea = OBJECT_SELF;
    string sTag = GetTag(oArea);
    int nControllPorta = GetLocalInt(GetModule(),"Quest_Strega_Porta");
    if(GetIsDM(oPC) == FALSE){
        if(sTag == "ext_iso_sah_cen"){
        if(nControllPorta == 0){
                object oItem1 = CreateObject(OBJECT_TYPE_PLACEABLE,"col_str_1",GetLocation(GetWaypointByTag("col_str_t1")));
                object oItem2 = CreateObject(OBJECT_TYPE_PLACEABLE,"col_str_2",GetLocation(GetWaypointByTag("col_str_t2")));
                effect eMissile = EffectBeam(VFX_BEAM_LIGHTNING,oItem1,BODY_NODE_CHEST);
                AssignCommand(oItem1,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMissile, oItem2));

            SetLocalInt(GetModule(),"Quest_Strega_Porta",1);
        }
         }
        if(sTag=="mod_sogno"){
            DelayCommand(1.0,AssignCommand(oPC,SetCameraFacing(90.0, 25.0, 48.0,CAMERA_TRANSITION_TYPE_MEDIUM)));
        }
        string sTagArea = GetStringLeft(sTag,3);
        if(sTagArea == "cit"||sTagArea == "tut")
            ExploreAreaForPlayer(OBJECT_SELF,oPC,TRUE);
        int nPG = GetLocalInt(oArea,"AREAPG");
        if((sTag == "ext_for_tro"||sTag == "dun_for_tro_cav"||sTag == "ext_for_tro_ove"||
        sTag == "ext_for_tro_ses"||sTag == "ext_for_tro_sov"||sTag == "dun_ten_tfa_bos")&&(nPG==0)){
            SetLocalInt(oArea,"AREAPG",1);
            ExecuteScript("mod_bas_troll_a",oArea);
        }
        else if((sTag == "dun_ghi" || sTag == "dun_ghi_ing" || sTag == "dun_ghi_san" || sTag == "dun_ghi_ver")&&(nPG==0)){
            SetLocalInt(oArea,"AREAPG",1);
            ExecuteScript("mod_bas_giant_a",oArea);
        }
        else if((sTag == "dun_che_sup" || sTag == "dun_che_ing")&&(nPG==0)){

            SetLocalInt(oArea,"AREAPG",1);
            ExecuteScript("mod_bas_acq_a",oArea);
        }
        else if(sTag == "dun_che_mag"){
            effect eSlow = SupernaturalEffect(EffectSlow());
            effect eRall = EffectMovementSpeedDecrease(50);
            effect eSpellFailure = SupernaturalEffect(EffectSpellFailure(100,SPELL_SCHOOL_GENERAL));
            eSlow = EffectLinkEffects(eSlow,eSpellFailure);
            eSlow = EffectLinkEffects(eRall,eSlow);
            int nForm = GetAppearanceType(oPC);
            if(nForm!= APPEARANCE_TYPE_DRAGON_BLUE &&nForm!= APPEARANCE_TYPE_WYRMLING_BLUE &&
               nForm!= APPEARANCE_TYPE_ELEMENTAL_AIR && nForm!= APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER &&
               nForm!= APPEARANCE_TYPE_ELEMENTAL_EARTH && nForm!= APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER &&
               nForm!= APPEARANCE_TYPE_ELEMENTAL_WATER && nForm!= APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER){
                if ((GetRacialType(oPC) == RACIAL_TYPE_UNDEAD || GetRacialType(oPC) == RACIAL_TYPE_CONSTRUCT)||
                    nForm == APPEARANCE_TYPE_SKELETON_CHIEFTAIN || nForm == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 ||
                    nForm == APPEARANCE_TYPE_MOHRG || nForm == APPEARANCE_TYPE_MUMMY_GREATER ||
                    nForm == APPEARANCE_TYPE_VAMPIRE_MALE || nForm == APPEARANCE_TYPE_VAMPIRE_FEMALE ||
                    nForm == APPEARANCE_TYPE_LICH || nForm == APPEARANCE_TYPE_MINDFLAYER_ALHOON ||
                    nForm == APPEARANCE_TYPE_DEMI_LICH || nForm == APPEARANCE_TYPE_GOLEM_BONE ||
                    nForm == APPEARANCE_TYPE_DRACOLICH || nForm == APPEARANCE_TYPE_GOLEM_ADAMANTIUM ||
                    nForm == APPEARANCE_TYPE_GOLEM_DEMONFLESH || nForm == APPEARANCE_TYPE_GOLEM_IRON ||
                    nForm == APPEARANCE_TYPE_GOLEM_MITHRAL || nForm == APPEARANCE_TYPE_SHIELD_GUARDIAN){
                    effect eLoop = GetFirstEffect(oPC);
                    while (GetIsEffectValid(eLoop)){
                        RemoveEffect(oPC,eLoop);
                        eLoop = GetNextEffect(oPC);
                    }
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSpellFailure,oPC);
                }
                else{
                    effect eLoop = GetFirstEffect(oPC);
                    while (GetIsEffectValid(eLoop)){
                        RemoveEffect(oPC,eLoop);
                        eLoop = GetNextEffect(oPC);
                    }
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSlow,oPC);
                }
            }
            if(nPG==0){
                SetLocalInt(oArea,"AREAPG",1);
                ExecuteScript("mod_bas_acq_c",oArea);
            }
        }
        else if(sTag == "dun_che_bib"){
            int nCaduta = GetLocalInt(oArea,"CADUTA");
            if(nCaduta == 1){
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DEATH),oPC);
            }
            else if(nCaduta == 2){
                int nDamage = nNumberRandom(9,36*2);
                float fDamage = (IntToFloat(nDamage)/100.0)*65.0;
                nDamage = FloatToInt(fDamage);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage,DAMAGE_TYPE_BLUDGEONING),oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM),oPC);
            }
            DeleteLocalInt(oArea,"CADUTA");
        }
        else if(sTag == "mod_gil_are_tvt")
            ExploreAreaForPlayer(OBJECT_SELF,oPC,TRUE);
    }
}
