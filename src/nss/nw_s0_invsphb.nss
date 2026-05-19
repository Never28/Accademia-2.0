/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 10-08-2009
*/

// Funzione per Sfera Invisibilita' OnExit.

void main()
{
    object oTarget = GetExitingObject();
    int bValid = FALSE;
    effect eAOE;
    if(GetHasSpellEffect(SPELL_INVISIBILITY_SPHERE, oTarget)){
        eAOE = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eAOE) && bValid == FALSE){
            if (GetEffectCreator(eAOE) == GetAreaOfEffectCreator()){
                if(GetEffectType(eAOE) == EFFECT_TYPE_SKILL_INCREASE){
                    if(GetEffectSpellId(eAOE) == SPELL_INVISIBILITY_SPHERE){
                        RemoveEffect(oTarget, eAOE);
                        bValid = TRUE;
                    }
                }
            }
            eAOE = GetNextEffect(oTarget);
        }
    }
}
