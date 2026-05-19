/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Tempesta di Ghiaccio.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nSave = SAVING_THROW_TYPE_COLD;
    int nType = DAMAGE_TYPE_COLD;
    int nBonus;
    int nElement = GetLocalInt(OBJECT_SELF,"SapienteElementale");
    switch(nElement){
        case 1:
            nType = DAMAGE_TYPE_BLUDGEONING;
            break;
        case 2:
            nType = DAMAGE_TYPE_COLD;
            nBonus = 50;
            break;
        case 3:
            nType = DAMAGE_TYPE_ELECTRICAL;
            break;
        case 4:
            nType = DAMAGE_TYPE_FIRE;
            break;
    }
    int nVariable = nCasterLvl;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_ICESTORM);
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eDam;
    location lTarget = GetSpellTargetLocation();
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget)){
        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
            fDelay = GetRandomDelay(0.75, 2.25);
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ICE_STORM));
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay)){
                nDamage = d4(nVariable*2);
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    nDamage = 8*nVariable;
                else if (nMetaMagic == METAMAGIC_EMPOWER)
                   nDamage = nDamage + (nDamage / 2);
                nDamage = nDamage + nBonus;
                float fDamage = (IntToFloat(nDamage)/100.0)*30.0;
                nDamage = FloatToInt(fDamage);
                eDam = EffectDamage(nDamage, nType);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
             }
        }
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}

