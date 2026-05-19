/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 28-06-2009
*/

// Funzione per il level up.

void main()
{
    object oPC = GetPCLevellingUp();
    int nDice = GetHitDice(oPC);
    int nType;
    switch(nDice){
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
            nType = VFX_FNF_LOS_HOLY_10;
            break;
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            nType = VFX_IMP_UNSUMMON;
            break;
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
            nType = VFX_IMP_HARM;
            break;
        case 16:
        case 17:
        case 18:
        case 19:
        case 20:
            nType = VFX_FNF_SUMMON_CELESTIAL;
            break;
        case 21:
        case 22:
        case 23:
        case 24:
        case 25:
            nType = VFX_FNF_SOUND_BURST;
            break;
        case 26:
        case 27:
        case 28:
        case 29:
        case 30:
            nType = VFX_FNF_SUMMON_EPIC_UNDEAD;
            break;
        case 31:
        case 32:
        case 33:
        case 34:
        case 35:
            nType = VFX_FNF_PWKILL;
            break;
        case 36:
        case 37:
        case 38:
        case 39:
            nType = VFX_FNF_NATURES_BALANCE;
            break;
        case 40:
            nType = VFX_FNF_IMPLOSION;
            break;
    }
    // Effetto visivo per il teletrasporto.
    effect eEffect = EffectVisualEffect(nType);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oPC));
    ExecuteScript("mod_pc_lev_dev",oPC);
}
