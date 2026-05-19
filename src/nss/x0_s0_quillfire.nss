/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Pioggia di Aculei.

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "mod_bad_dice"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    int nDam = 0;
    int nClass = GetLastSpellCastClass();
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_TROLL_CHIEFTAIN){
        int nSag = GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF);
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
    nDruidLv = nMutaLv + nDruidLv;
    nMutaLv = nDruidLv/2;
    if (nMutaLv >= 1){
            nDam = d4(nDruidLv*2);
            nDam = nDam+d2(nDruidLv);
            nDC = 10 + nSag + nMutaLv;
        }
    }
    else{
        nDC = GetSpellSaveDC();
        nDam = nNumberRandom(3,nCasterLvl*2);
        if(GetHitDice(OBJECT_SELF)==40)
            nDC = nDC +5;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_QUILLFIRE));
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDam = 6*(nCasterLvl);
                if (nMetaMagic == METAMAGIC_EMPOWER)
                      nDam = nDam + nDam/2;
                float fDamage = (IntToFloat(nDam)/100.0)*65.0;
                nDam = FloatToInt(fDamage);
                effect eDam = EffectDamage(nDam, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
    }
}



