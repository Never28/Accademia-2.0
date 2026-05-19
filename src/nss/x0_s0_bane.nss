/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Anatema.

#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oTarget;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_EVIL_30);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDC = GetSpellSaveDC();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    int Bonus = nDuration/10;
    if(Bonus<1)
        Bonus = 1;
    effect eAttack = EffectAttackDecrease(Bonus);
    effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, Bonus, SAVING_THROW_TYPE_FEAR);
    effect eLink = EffectLinkEffects(eAttack, eSave);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    if (nMetaMagic == METAMAGIC_EXTEND)
        nDuration = nDuration *2;
    location lLoc = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lLoc);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc);
    int MalusCAP = GetLocalInt(OBJECT_SELF,"SpellMalusCap");
    if(MalusCAP == 0){
        while(GetIsObjectValid(oTarget)){
            if (spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF)){
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 449, FALSE));
                if (!MyResistSpell(OBJECT_SELF, oTarget) ){
                    int nWillResult = WillSave(oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS);
                    if (nWillResult == 0){
                        fDelay = GetRandomDelay(0.4, 1.1);
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration)));
                        DelayCommand(TurnsToSeconds(nDuration), SetLocalInt(OBJECT_SELF,"SpellMalusCap",0));
                    }
                    else if (nWillResult == 2)
                        SpeakStringByStrRef(40105, TALKVOLUME_WHISPER);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lLoc);
        }
    }
    else
        SendMessageToPC(OBJECT_SELF,"Impossibile Lanciare la Magia, Anatema o Preghiera ancora attivi e non comulabili");
}



