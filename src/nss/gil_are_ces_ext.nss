void main()
{
    object oPC = GetExitingObject();
    effect eEffect = GetFirstEffect(oPC);
    while(GetIsEffectValid(eEffect)==TRUE){
        if(GetEffectType(eEffect)==EFFECT_TYPE_INVISIBILITY || GetEffectType(eEffect)==EFFECT_TYPE_SEEINVISIBLE)
            RemoveEffect(oPC,eEffect);
        eEffect = GetNextEffect(oPC);
    }
}
