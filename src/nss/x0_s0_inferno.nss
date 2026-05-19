/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "mod_bad_dice"

void RunImpact(object oTarget, object oCaster, int nMetamagic);

void main()
{
    object oTarget = GetSpellTargetObject();
    if (!X2PreSpellCastCode())
        return;
    if (GetHasSpellEffect(GetSpellId(),oTarget) || GetHasSpellEffect(SPELL_COMBUST,oTarget)){
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
        int nMetaMagic = GetMetaMagicFeat();
        int nDuration = GetCasterLevel(OBJECT_SELF);
        if (nMetaMagic == METAMAGIC_EXTEND)
           nDuration = nDuration * 2;
        if (nDuration < 1)
            nDuration = 1;
        effect eRay      = EffectBeam(444,OBJECT_SELF,BODY_NODE_CHEST);
        effect eDur      = EffectVisualEffect(498);
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        float fDelay = GetDistanceBetween(oTarget, OBJECT_SELF)/13;
        if(!MyResistSpell(OBJECT_SELF, oTarget)){
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 3.0f);
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(nDuration)));
            object oSelf = OBJECT_SELF;
            DelayCommand(fDelay+0.1f,RunImpact(oTarget, oSelf,nMetaMagic));
        }
        else{
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 2.0f);
            effect eSmoke = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
            DelayCommand(fDelay+0.3f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oTarget));
        }
}


void RunImpact(object oTarget, object oCaster, int nMetaMagic)
{
    if (GZGetDelayedSpellEffectsExpired(446,oTarget,oCaster))
        return;
    if (GetIsDead(oTarget) == FALSE){
        int nDamage;

            int i;
            int nLevel = GetCasterLevel(OBJECT_SELF);
        nDamage = nNumberRandom(5,nLevel*2);
        float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
        nDamage = FloatToInt(fDamage);
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        eDam = EffectLinkEffects(eVis,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f,RunImpact(oTarget,oCaster,nMetaMagic));
    }
}
