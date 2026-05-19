/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-07-2009
*/

// La funzione per la Resurrezione

#include "x2_inc_spellhook"

int ControlloLivello(object oPC)
{
    int iResult;
        int nLevel;
        string sTag = GetTag(oPC);
        if(sTag == "png_xzar")
            nLevel = 1;
        else if(sTag == "png_imoen")
            nLevel = 1;
        else if(sTag == "png_montaron")
            nLevel = 1;
        else if(sTag == "png_xan")
            nLevel = 11;
        else if(sTag == "png_minsc")
            nLevel = 11;
        else if(sTag == "png_branwen")
            nLevel = 11;
        else if(sTag == "png_kagain")
            nLevel = 16;
        else if(sTag == "png_sharteel")
            nLevel = 16;
        else if(sTag == "png_garrick")
            nLevel = 16;
        else if(sTag == "png_jaheira")
            nLevel = 21;
        else if(sTag == "png_khalid")
            nLevel = 21;
        else if(sTag == "png_kivan")
            nLevel = 21;
        else if(sTag == "png_alora")
            nLevel = 26;
        else if(sTag == "png_quayle")
            nLevel = 26;
        else if(sTag == "png_ayantis")
            nLevel = 26;
    if(GetHenchman(oPC)==OBJECT_INVALID && GetHitDice(oPC)>=nLevel)
        return TRUE;
    return FALSE;
}

void main()
{
    if (!X2PreSpellCastCode())
        return;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    if(GetTag(oTarget) == "png_xzar"||GetTag(oTarget) == "png_imoen"
    ||GetTag(oTarget) == "png_montaron"||GetTag(oTarget) == "png_xan"||GetTag(oTarget) == "png_minsc"
    ||GetTag(oTarget) == "png_branwen"||GetTag(oTarget) == "png_kagain"||GetTag(oTarget) == "png_sharteel"
    ||GetTag(oTarget) == "png_garrick"||GetTag(oTarget) == "png_jaheira"||GetTag(oTarget) == "png_khalid"
    ||GetTag(oTarget) == "png_kivan"||GetTag(oTarget) == "png_alora"||GetTag(oTarget) == "png_quayle"
    ||GetTag(oTarget) == "png_ayantis"){
        int nControllo = ControlloLivello(OBJECT_SELF);
        if(nControllo == TRUE)
            AddHenchman(OBJECT_SELF,oTarget);
        SetPlotFlag(oTarget, FALSE);
        SetIsDestroyable(TRUE, TRUE, TRUE);
        AssignCommand(oTarget,ClearAllActions());
    }
        if (GetIsObjectValid(oTarget))
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
            if (GetIsDead(oTarget)){
                DestroyObject(GetItemPossessedBy(oTarget,"mod_bas_dead"));
                int nHealed = GetMaxHitPoints(oTarget);
                effect eRaise = EffectResurrection();
                effect eHeal = EffectHeal(nHealed + 10);
                effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
                //Apply the heal, raise dead and VFX impact effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
                int nAspect = GetAppearanceType(oTarget);
                object oArea = GetArea(oTarget);
                string sTag = GetTag(oArea);
                    if(sTag == "dun_che_mag"){
                    effect eSlow = SupernaturalEffect(EffectSlow());
                    effect eRall = EffectMovementSpeedDecrease(50);
                    effect eSpellFailure = SupernaturalEffect(EffectSpellFailure(100,SPELL_SCHOOL_GENERAL));
                    eSlow = EffectLinkEffects(eSlow,eSpellFailure);
                    eSlow = EffectLinkEffects(eRall,eSlow);
                    int nForm = GetAppearanceType(oTarget);
                    if(nForm!= APPEARANCE_TYPE_DRAGON_BLUE &&nForm!= APPEARANCE_TYPE_WYRMLING_BLUE &&
                       nForm!= APPEARANCE_TYPE_ELEMENTAL_AIR && nForm!= APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER &&
                       nForm!= APPEARANCE_TYPE_ELEMENTAL_EARTH && nForm!= APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER &&
                       nForm!= APPEARANCE_TYPE_ELEMENTAL_WATER && nForm!= APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER){
                        if ((GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)||
                            nForm == APPEARANCE_TYPE_SKELETON_CHIEFTAIN || nForm == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 ||
                            nForm == APPEARANCE_TYPE_MOHRG || nForm == APPEARANCE_TYPE_MUMMY_GREATER ||
                            nForm == APPEARANCE_TYPE_VAMPIRE_MALE || nForm == APPEARANCE_TYPE_VAMPIRE_FEMALE ||
                            nForm == APPEARANCE_TYPE_LICH || nForm == APPEARANCE_TYPE_MINDFLAYER_ALHOON ||
                            nForm == APPEARANCE_TYPE_DEMI_LICH || nForm == APPEARANCE_TYPE_GOLEM_BONE ||
                            nForm == APPEARANCE_TYPE_DRACOLICH || nForm == APPEARANCE_TYPE_GOLEM_ADAMANTIUM ||
                            nForm == APPEARANCE_TYPE_GOLEM_DEMONFLESH || nForm == APPEARANCE_TYPE_GOLEM_IRON ||
                            nForm == APPEARANCE_TYPE_GOLEM_MITHRAL || nForm == APPEARANCE_TYPE_SHIELD_GUARDIAN){
                        }
                        else{
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSlow,oTarget);
                        }
                    }
                }


                if(nAspect == APPEARANCE_TYPE_DOG_WOLF || nAspect == APPEARANCE_TYPE_BADGER || nAspect == APPEARANCE_TYPE_BOAR
                || nAspect == APPEARANCE_TYPE_BEAR_BROWN || nAspect == APPEARANCE_TYPE_CAT_PANTHER || nAspect == APPEARANCE_TYPE_BEAR_DIRE
                || nAspect == APPEARANCE_TYPE_BADGER_DIRE || nAspect == APPEARANCE_TYPE_DOG_DIRE_WOLF || nAspect == APPEARANCE_TYPE_CAT_MPANTHER
                || nAspect == APPEARANCE_TYPE_BOAR_DIRE || nAspect == APPEARANCE_TYPE_CAT_CAT_DIRE || nAspect == APPEARANCE_TYPE_BEETLE_STINK
                || nAspect == APPEARANCE_TYPE_SPIDER_GIANT || nAspect == APPEARANCE_TYPE_BEETLE_STAG || nAspect == APPEARANCE_TYPE_SPIDER_DIRE
                || nAspect == APPEARANCE_TYPE_SPIDER_DEMON || nAspect == APPEARANCE_TYPE_ELEMENTAL_FIRE || nAspect == APPEARANCE_TYPE_ELEMENTAL_WATER
                || nAspect == APPEARANCE_TYPE_ELEMENTAL_AIR || nAspect == APPEARANCE_TYPE_ELEMENTAL_EARTH || nAspect == APPEARANCE_TYPE_ELEMENTAL_FIRE_ELDER
                || nAspect == APPEARANCE_TYPE_ELEMENTAL_WATER_ELDER || nAspect == APPEARANCE_TYPE_ELEMENTAL_AIR_ELDER || nAspect ==APPEARANCE_TYPE_ELEMENTAL_EARTH_ELDER
                || nAspect == APPEARANCE_TYPE_BASILISK || nAspect == APPEARANCE_TYPE_CAT_KRENSHAR || nAspect == APPEARANCE_TYPE_MANTICORE
                || nAspect == APPEARANCE_TYPE_GOLEM_IRON || nAspect == APPEARANCE_TYPE_GOLEM_BONE || nAspect == APPEARANCE_TYPE_GOLEM_DEMONFLESH
                || nAspect == APPEARANCE_TYPE_GOLEM_MITHRAL || nAspect == APPEARANCE_TYPE_GOLEM_ADAMANTIUM
                || nAspect == 183 || nAspect == 178 || nAspect == APPEARANCE_TYPE_UMBERHULK)
                    DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellFailure(100,SPELL_SCHOOL_GENERAL),oTarget));
                int stampa1 = GetLocalInt(oTarget,"class_special");
                int stampa2 = GetLocalInt(oTarget,"car_ability");
                if(stampa2==0)
                    ExecuteScript("mod_bas_car",oTarget);
                if(stampa1==0)
                    ExecuteScript("mod_bas_cla_spe",oTarget);
            }
            else{
                if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE){
                    int nStrRef = GetLocalInt(oTarget,"X2_L_RESURRECT_SPELL_MSG_RESREF");
                    if (nStrRef == 0)
                        nStrRef = 83861;
                    if (nStrRef != -1)
                        FloatingTextStrRefOnCreature(nStrRef,OBJECT_SELF);
                }
            }
        }
}

