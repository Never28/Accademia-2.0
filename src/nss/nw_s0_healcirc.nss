/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Cerchio di Guarigione.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDamagen, nModify, nHP;
    int nMetaMagic = GetMetaMagicFeat();
    effect eKill;
    effect eHeal;
    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
    float fDelay;
    int nCure = GetSkillRank(SKILL_HEAL,OBJECT_SELF);
    nModify = nNumberRandom(5,nCasterLvl*2)+ (nCure/2);
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nModify = 10* nCasterLvl + (nCure/2);
    if (nMetaMagic == METAMAGIC_EMPOWER)
        nModify = nModify + (nModify/2);
    float fDamage = (IntToFloat(nModify)/100.0)*75.0;
    nModify = FloatToInt(fDamage);
    int nDC = GetSpellSaveDC();
    int nClass = GetLastSpellCastClass();
    if(nClass == CLASS_TYPE_BARD){
        int nBard = GetLevelByClass(CLASS_TYPE_BARD,OBJECT_SELF);
        if(nBard >=21)
            nDC = nDC +5;
        else if(nBard >=15)
            nDC = nDC +3;
        else if(nBard >=10)
            nDC = nDC +2;
        else if(nBard >=5)
            nDC = nDC +1;
    }
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int nAlign,nDamage;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget)){
            fDelay = GetRandomDelay();
            int nAspect = GetAppearanceType(oTarget);
            if ((GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD|| nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH)){
                if(!GetIsReactionTypeFriendly(oTarget)){
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE));
                    if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                        if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                            nModify /= 2;
                        eKill = EffectDamage(nModify, DAMAGE_TYPE_POSITIVE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                }
            }
            else{
                if(GetIsFriend(oTarget)==TRUE){
                    nAlign = GetAlignmentGoodEvil(oTarget);
                    if ((nAlign == ALIGNMENT_GOOD && GetItemPossessedBy(OBJECT_SELF,"mod_deity_latha")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID)
                    || (nAlign == ALIGNMENT_EVIL && GetItemPossessedBy(OBJECT_SELF,"mod_deity_talos")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID))
                    {
                        fDamage = (IntToFloat((24* nCasterLvl)+(nCure/2))/100.0)*75.0;
                        nDamage = FloatToInt(fDamage);
                        eHeal = EffectHeal(nDamage);
                    }
                    else
                        eHeal = EffectHeal(nModify);
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE, FALSE));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
        }
}
