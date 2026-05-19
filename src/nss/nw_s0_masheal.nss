/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Guarigione di Massa.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
  effect eKill;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHeal;
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_G);
  effect eStrike = EffectVisualEffect(VFX_FNF_LOS_HOLY_10);
  int nTouch, nModify, nDamage, nHeal;
  int nMetaMagic = GetMetaMagicFeat();
  float fDelay;
  location lLoc =  GetSpellTargetLocation();
  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eStrike, lLoc);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
  nModify = d8(nCasterLevel*2);
  int nCure = GetSkillRank(SKILL_HEAL,OBJECT_SELF);
  nModify = nModify +(nCure*2);
  float fDamage = (IntToFloat(nModify)/100.0)*75.0;
  nModify = FloatToInt(fDamage);
  int nAlign;
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
  while(GetIsObjectValid(oTarget)){
      fDelay = GetRandomDelay();
      int nAspect = GetAppearanceType(oTarget);
      if ((GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD|| nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH)){
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL));
            nTouch = TouchAttackRanged(oTarget);
            if (nTouch > 0){
                if(!GetIsReactionTypeFriendly(oTarget)){
                    if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                        if(MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_ALL,OBJECT_SELF))
                            nDamage = nDamage / 2;
                        eKill = EffectDamage(nDamage,DAMAGE_TYPE_POSITIVE);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
            }
      }
      else{
            if(GetIsFriend(oTarget)==TRUE){
                    nAlign = GetAlignmentGoodEvil(oTarget);
                    if ((nAlign == ALIGNMENT_GOOD && GetItemPossessedBy(OBJECT_SELF,"mod_deity_latha")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID)
                    || (nAlign == ALIGNMENT_EVIL && GetItemPossessedBy(OBJECT_SELF,"mod_deity_talos")!=OBJECT_INVALID && GetItemPossessedBy(OBJECT_SELF,"mod_clas_gf")!=OBJECT_INVALID))
                    {
                        fDamage = (IntToFloat((24* nCasterLevel)+(nCure*2))/100.0)*75.0;
                        nDamage = FloatToInt(fDamage);
                        eHeal = EffectHeal(nDamage);
                    }
                    else
                        eHeal = EffectHeal(nModify);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HEAL, FALSE));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
      }
      oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
   }
}
