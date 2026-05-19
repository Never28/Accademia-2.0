#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"

void RunImpact(object oTarget, object oCaster, int nMetamagic,int nType);

void main()
{
    object oTarget = GetSpellTargetObject();
    if (!X2PreSpellCastCode())
        return;
    if (GetHasSpellEffect(GetSpellId(),oTarget)){
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
    int nType = DAMAGE_TYPE_ACID;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    int nSpec = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage = MaximizeOrEmpower(4,nSpec,nMetaMagic);
    int nDuration = (GetCasterLevel(OBJECT_SELF)/3);
    if (nMetaMagic == METAMAGIC_EXTEND)
       nDuration = nDuration * 2;
    if (nDuration < 1)
        nDuration = 1;
    int Aspect = GetAppearanceType(OBJECT_SELF);
    if(Aspect == APPEARANCE_TYPE_SPIDER_DEMON){
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        nDuration = nDruidLv/3;
        nDamage = MaximizeOrEmpower(6,nDruidLv,nMetaMagic);
    }
    object oSelf = OBJECT_SELF;
    effect eVis      = EffectVisualEffect(VFX_IMP_ACID_L);
    effect eDur      = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eArrow = EffectVisualEffect(245);
    eDur = ExtraordinaryEffect(eDur);
    if (GetIsReactionTypeFriendly(oTarget) == FALSE){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        float fDist = GetDistanceToObject(oTarget);
        float fDelay = (fDist/25.0);
        if(!MyResistSpell(OBJECT_SELF, oTarget)){
            float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
            nDamage = FloatToInt(fDamage);
            effect eDam = EffectDamage(nDamage,nType);
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(nDuration)));
            DelayCommand(6.0f,RunImpact(oTarget,oSelf,nMetaMagic,nType));
        }
        else{
            effect eSmoke = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
            DelayCommand(fDelay+0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oTarget));
        }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);

}


void RunImpact(object oTarget, object oCaster, int nMetaMagic,int nType)
{
    int nSpec = GetCasterLevel(OBJECT_SELF);
    int nDamage = MaximizeOrEmpower(4,nSpec,nMetaMagic);
    int Aspect = GetAppearanceType(oCaster);
    if(Aspect == APPEARANCE_TYPE_SPIDER_DEMON){
        int nMutaLv = GetLevelByClass(CLASS_TYPE_SHIFTER,OBJECT_SELF);
        int nDruidLv = GetLevelByClass(CLASS_TYPE_DRUID,OBJECT_SELF);
        nDruidLv = nMutaLv + nDruidLv;
        nMutaLv = nDruidLv/2;
        nDamage = MaximizeOrEmpower(6,nSpec,nMetaMagic);
    }
    if (GZGetDelayedSpellEffectsExpired(SPELL_MELFS_ACID_ARROW,oTarget,oCaster))
        return;
    if (GetIsDead(oTarget) == FALSE){
        float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
        nDamage = FloatToInt(fDamage);
        effect eDam = EffectDamage(nDamage, nType);
        effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
        eDam = EffectLinkEffects(eVis,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f,RunImpact(oTarget,oCaster,nMetaMagic,nType));
    }
}

