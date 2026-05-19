void main()
{
    object oPC = OBJECT_SELF;
    object oMob = GetItemActivatedTarget();
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(9999,DAMAGE_TYPE_MAGICAL),oMob,0.0);
}
