/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 13-07-2009
*/

// Funzione per gli Infliggi Ferite.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nMetaMagic = GetMetaMagicFeat();
    int nSpellID = GetSpellId();
    int nRoll;
    object oCaster = GetLastSpellCaster();
    int nLevel = GetCasterLevel(oCaster);
    int nCure = GetSkillRank(FEAT_EPIC_SKILL_FOCUS_HEAL,OBJECT_SELF);
    switch (nSpellID){
        nRoll = d8(nLevel);
        if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nRoll = nRoll + (nRoll / 2);
        }
        case 431:
            spellsInflictTouchAttack(0,nRoll, 0, (8)*nLevel, 246, VFX_IMP_HEALING_G, nSpellID);
            break;
        case 432:
        case 609:
            spellsInflictTouchAttack(1,nRoll+nLevel, 0, (9)*nLevel, 246, VFX_IMP_HEALING_G, nSpellID);
            break;
        case 433:
        case 610:
            spellsInflictTouchAttack(2,nRoll+(2*nLevel), 0, (10)*nLevel, 246, VFX_IMP_HEALING_G, nSpellID);
            break;
        case 434:
        case 611:
            spellsInflictTouchAttack(3,nRoll+(3*nLevel), 0, (11)*nLevel, 246, VFX_IMP_HEALING_G, nSpellID);
            break;
        case 435:
        case 612:
            spellsInflictTouchAttack(4,d8(nLevel)+(4*nLevel), 0, (12)*nLevel, 246, VFX_IMP_HEALING_G, nSpellID);
            break;
    }
}
