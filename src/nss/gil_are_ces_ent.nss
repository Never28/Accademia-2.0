void main()
{
    object oPC = GetEnteringObject();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectInvisibility(INVISIBILITY_TYPE_NORMAL),oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSeeInvisible(),oPC);
}
