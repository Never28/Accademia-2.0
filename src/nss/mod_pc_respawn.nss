/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 17-06-2009
*/

// La funzione quando un giocatore risorge.

#include "nw_i0_plot"

void ApplyPenalty(object oDead)
{
    int nLV = GetHitDice(oDead);
    int nPenalty;
    int nGoldToTake;
    if (nLV <= 10){
        nPenalty = 100 * nLV;
        nGoldToTake = 100 * nLV;
    }
    else if (nLV <= 20){
        nPenalty = 200 * nLV;
        nGoldToTake = 500 * nLV;
    }
    else if (nLV <= 30){
        nPenalty = 300 * nLV;
        nGoldToTake = 2000 * nLV;
    }
    else if (nLV <= 40){
        nPenalty = 400 * nLV;
        nGoldToTake = 4000 * nLV;
    }
    int nXP = GetXP(oDead);
    int nMin = ((nLV * (nLV - 1)) / 2) * 1000;
    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}

void main()
{
    object oPlayer = GetLastRespawnButtonPresser();
    object oLimbo = GetObjectByTag("mod_inferno_t1");
    effect eVisual = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    effect eBad = GetFirstEffect(oPlayer);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
    while(GetIsEffectValid(eBad)){
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL){
                RemoveEffect(oPlayer, eBad);
            }
        eBad = GetNextEffect(oPlayer);
    }
    ApplyPenalty(oPlayer);
    int nAspect = GetAppearanceType(oPlayer);
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
                    DelayCommand(0.2,ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellFailure(100,SPELL_SCHOOL_GENERAL),oPlayer));
    ExecuteScript("mod_clas_poly_de",oPlayer);
    AssignCommand(oPlayer,ActionJumpToObject(oLimbo));
    DestroyObject(GetItemPossessedBy(oPlayer,"mod_bas_dead"));
    DelayCommand(6.5,FloatingTextStringOnCreature("", oPlayer));
    int stampa1=GetLocalInt(oPlayer,"class_special");
    int stampa2=GetLocalInt(oPlayer,"car_ability");
    if(stampa2==0)
        ExecuteScript("mod_bas_car",oPlayer);
    if(stampa1==0)
        ExecuteScript("mod_bas_cla_spe",oPlayer);
}
