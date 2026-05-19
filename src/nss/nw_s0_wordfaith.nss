

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
        object oTarget;
        int nCasterLevel = GetCasterLevel(OBJECT_SELF);
        effect eBlind = EffectBlindness();
        effect eStun = EffectStunned();
        effect eConfuse = EffectConfused();
        effect eDeath = EffectDeath();
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        effect eSmite = EffectVisualEffect(VFX_FNF_WORD);
        effect eSonic = EffectVisualEffect(VFX_IMP_SONIC);
        effect eUnsummon =  EffectVisualEffect(VFX_IMP_UNSUMMON);
        effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eKill;
        effect eLink;
        int nHD;
        int nDC = GetSpellSaveDC();

    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
        float fDelay;
        int nDuration = nCasterLevel / 2;
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSmite, GetSpellTargetLocation());
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
        while (GetIsObjectValid(oTarget)){
            if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF)){
                fDelay = GetRandomDelay(0.5, 2.0);
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WORD_OF_FAITH));
                if(!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSonic, oTarget);
                    if (GetIsObjectValid(GetMaster(oTarget))){
                        if (GetAssociateType(oTarget) == ASSOCIATE_TYPE_SUMMONED){
                            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eUnsummon, oTarget));
                            if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH))
                                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                            else{
                                eKill  = EffectDamage(GetCurrentHitPoints(oTarget)+10);
                                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                            }
                         }
                    }
                    else{
                        int nCasual = Random(4);
                        switch (nCasual){
                            case 0:
                                eLink = EffectLinkEffects(eBlind, eDur);
                                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                                break;
                            case 1:
                                eLink = EffectLinkEffects(eStun, eDur);
                                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                                break;
                            case 2:
                                if(!GetIsImmune(oTarget, IMMUNITY_TYPE_DEATH)&&(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))){
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
                                }
                                break;
                            case 3:
                                eLink = EffectLinkEffects(eLink, eConfuse);
                                if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC))
                                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                                break;
                            default:
                                break;
                        }
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetSpellTargetLocation());
        }
}
