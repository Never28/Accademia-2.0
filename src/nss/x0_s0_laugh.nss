/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Risata Incontenibile di Tasha

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nClass = GetLastSpellCastClass();
    int nDC = GetSpellSaveDC();
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
    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt;
    effect eVis = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);
    int nDuration = d3(1);
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    int nModifier = 0;
    if (GetRacialType(oTarget) != GetRacialType(OBJECT_SELF))
        nModifier = 4;
    if(!GetIsReactionTypeFriendly(oTarget)){
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_TASHAS_HIDEOUS_LAUGHTER));
        if (spellsIsMindless(oTarget) == FALSE){
            if (!MyResistSpell(OBJECT_SELF, oTarget) && !MySavingThrow(SAVING_THROW_WILL, oTarget, nDC-nModifier, SAVING_THROW_TYPE_MIND_SPELLS)){
                if ( !GetIsImmune(oTarget,IMMUNITY_TYPE_MIND_SPELLS )){
                    effect eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
                    float fDur = RoundsToSeconds(nDuration);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, oTarget, fDur);
                    AssignCommand(oTarget, ClearAllActions());
                    AssignCommand(oTarget, PlayVoiceChat(VOICE_CHAT_LAUGH));
                    AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
                    effect eLaugh = EffectKnockdown();
                    DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLaugh, oTarget, fDur));
                }
            }
        }
    }
}





