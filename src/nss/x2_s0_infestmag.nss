/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Infestazione di Parassiti.

#include "NW_I0_SPELLS"
#include "x2_I0_SPELLS"
#include "x2_inc_spellhook"

void RunInfestImpact(object oTarget, object oCaster, int nSaveDC, int nMetaMagic, int Spec);

void main()
{
    object oTarget = GetSpellTargetObject();
    object oCaster = OBJECT_SELF;
    if (!X2PreSpellCastCode())
        return;
    if (GetHasSpellEffect(GetSpellId(),oTarget) ){
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration  = 10 + GetCasterLevel(OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EXTEND)
       nDuration = nDuration * 2;
    float  fDist   = GetDistanceToObject(oTarget);
    float  fDelay  = fDist/25.0;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int Spec = nCasterLvl/8;
    if (Spec<1)
        Spec=1;
    effect eDur = EffectVisualEffect   ( VFX_DUR_FLIES );
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        if(MyResistSpell(OBJECT_SELF, oTarget, fDelay) == 0){
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget,RoundsToSeconds(nDuration)));
            SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFESTATION_OF_MAGGOTS), nDC);
            DelayCommand(fDelay+0.1f, RunInfestImpact(oTarget,oCaster,nDC, nMetaMagic, Spec));
        }
    }
}

void RunInfestImpact(object oTarget, object oCaster, int nSaveDC, int nMetaMagic,int Spec)
{
    if (GZGetDelayedSpellEffectsExpired(SPELL_INFESTATION_OF_MAGGOTS,oTarget,oCaster))
        return;
    if (GetIsDead(oTarget) == FALSE){
         int nDC = GetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFESTATION_OF_MAGGOTS));
         if (!MySavingThrow(SAVING_THROW_FORT,oTarget,nSaveDC,SAVING_THROW_TYPE_DISEASE,OBJECT_SELF)){
            effect eVis    = EffectVisualEffect   ( VFX_IMP_DISEASE_S );
            int    nDamage = d4(Spec);
            if ( nMetaMagic == METAMAGIC_MAXIMIZE )
                nDamage = 4*Spec;
            else if ( nMetaMagic == METAMAGIC_EMPOWER )
                nDamage = nDamage + (nDamage/2);
            effect eDam = ExtraordinaryEffect  ( EffectAbilityDecrease( ABILITY_CONSTITUTION, nDamage));
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
            if (GetAbilityScore(oTarget,ABILITY_CONSTITUTION)<=3 && GetGameDifficulty() >= GAME_DIFFICULTY_CORE_RULES){
                  if (!GetImmortal(oTarget)){
                     FloatingTextStrRefOnCreature(100932,oTarget);
                     effect eKill = EffectDamage(GetCurrentHitPoints(oTarget)+1);
                     ApplyEffectToObject(DURATION_TYPE_INSTANT,eKill,oTarget);
                     effect eVfx = EffectVisualEffect(VFX_IMP_DEATH_L);
                     ApplyEffectToObject(DURATION_TYPE_INSTANT,eVfx,oTarget);
                 }
            }
            else{
                 ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oTarget);
                 DelayCommand(6.0, RunInfestImpact(oTarget,oCaster,nSaveDC, nMetaMagic, Spec));
            }

         }
         else{
            DeleteLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (SPELL_INFESTATION_OF_MAGGOTS));
            GZRemoveSpellEffects(SPELL_INFESTATION_OF_MAGGOTS, oTarget);
         }
    }
}

