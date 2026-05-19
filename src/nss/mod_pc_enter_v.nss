void main()
{
    // Il giocatore che entra.
    object oPC = OBJECT_SELF;
    // Presentazione del server
    SetCutsceneMode(oPC,TRUE,FALSE);
    SetCutsceneCameraMoveRate(oPC,0.1);
    SetCameraMode(oPC,CAMERA_MODE_STIFF_CHASE_CAMERA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_BLACKOUT),oPC,16.0);
    DelayCommand(12.0,ActionStartConversation(oPC,"tut_vil",TRUE));
}
