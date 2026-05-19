void main()
{
    object oDoor = OBJECT_SELF;
    object oPC = GetLastUnlocked();
    GiveXPToCreature(oPC,200);
    DelayCommand(1800.0,ActionLockObject(oDoor));
}
