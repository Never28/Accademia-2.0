/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 18-06-2009
*/

// Funzione per il Dominare di Massa.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

int nRoundDominated(int nLevel, object oCreature){
    int nHitDice = GetHitDice(oCreature);
    int nRound = nLevel/2;
    if(nRound<1)
        nRound = 1;
    switch(nHitDice){
        case 1: case 2:
            nRound = nRound + 20;
            break;
        case 3: case 4:
            nRound = nRound + 19;
            break;
        case 5: case 6:
            nRound = nRound + 18;
            break;
        case 7: case 8:
            nRound = nRound + 17;
            break;
        case 9: case 10:
            nRound = nRound + 16;
            break;
        case 11: case 12:
            nRound = nRound + 15;
            break;
        case 13: case 14:
            nRound = nRound + 14;
            break;
        case 15: case 16:
            nRound = nRound + 13;
            break;
        case 17: case 18:
            nRound = nRound + 12;
            break;
        case 19: case 20:
            nRound = nRound + 11;
            break;
        case 21: case 22:
            nRound = nRound + 10;
            break;
        case 23: case 24:
            nRound = nRound + 9;
            break;
        case 25: case 26:
            nRound = nRound + 8;
            break;
        case 27: case 28:
            nRound = nRound + 7;
            break;
        case 29: case 30:
            nRound = nRound + 6;
            break;
        case 31: case 32:
            nRound = nRound + 5;
            break;
        case 33: case 34:
            nRound = nRound + 4;
            break;
        case 35: case 36:
            nRound = nRound + 3;
            break;
        case 37: case 38:
            nRound = nRound + 2;
            break;
        default:
            nRound = nRound + 1;
            break;
    }
    return nRound;
}


void main()
{
    float fDelay;
    int nDC;
    object oPC = OBJECT_SELF;
    location lTarget = GetLocalLocation(oPC,"Arcimago");
    object oTarget;
    int nDuration = 43;
    effect eDom = EffectCutsceneDominated();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    effect eVis2 = EffectVisualEffect(VFX_FNF_BLINDDEAF);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eVis2, GetItemActivatedTargetLocation());
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eMind, eDom);
    eLink = EffectLinkEffects(eLink, eDur);
    effect eVis = EffectVisualEffect(VFX_IMP_DOMINATE_S);
            nDC = 24;
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT,oPC))
                nDC = nDC +6;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT,oPC))
                nDC = nDC + 2;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT,oPC))
                nDC = nDC + 4;
            nDC = nDC + GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
            oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            while (GetIsObjectValid(oTarget)){
                if(GetIsFriend(oTarget)==FALSE&& GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
                            if (!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC, SAVING_THROW_TYPE_MIND_SPELLS)){
                                DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                                nDuration= nRoundDominated(40, oTarget);
                                DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget,RoundsToSeconds(nDuration)));
                            }

                }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            }
}
