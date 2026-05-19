/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Canto OnExit.

#include "x2_inc_spellhook"

void main()
{
    object oTarget = GetExitingObject();
    effect eAOE;
    if(GetHasSpellEffect(SPELL_DIRGE, oTarget)){
        DeleteLocalInt(oTarget, "X0_L_LASTPENALTY");
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) ){
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator()){
                if(GetEffectSpellId(eAOE) == SPELL_DIRGE)
                    RemoveEffect(oTarget, eAOE);
            }
            eAOE = GetNextEffect(oTarget);
        }
    }
}



