void main()
{
    int nNumberSpell = GetLocalInt(GetModule(),"Quest_Strega_Spell");
    if(nNumberSpell != 3){
        object oPC = GetEnteringObject();
        effect eDamage = EffectDamage(100, DAMAGE_TYPE_ELECTRICAL);
        effect eLink = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        eLink = EffectLinkEffects(eLink,eDamage);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oPC);
        AssignCommand(oPC,ClearAllActions(TRUE));
        AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("tap_str_rep")));
        SendMessageToPC(oPC,"Una forza magica non ti permette di sbloccare il portale al momento");
    }
}
