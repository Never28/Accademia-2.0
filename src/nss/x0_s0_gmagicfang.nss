/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Zanna Magica Superiore.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nPower = (nCasterLevel) / 5;
    if (nPower < 1)
        nPower = 1;
    int nDamagePower = DAMAGE_POWER_PLUS_ONE;
    switch (nPower){
        case 1:
            nDamagePower = DAMAGE_POWER_PLUS_ONE;
            break;
        case 2:
            nDamagePower = DAMAGE_POWER_PLUS_TWO;
            break;
        case 3:
            nDamagePower = DAMAGE_POWER_PLUS_THREE;
            break;
        case 4:
            nDamagePower = DAMAGE_POWER_PLUS_FOUR;
            break;
        case 5:
            nDamagePower = DAMAGE_POWER_PLUS_FIVE;
            break;
        case 6:
            nDamagePower = DAMAGE_POWER_PLUS_SIX;
            break;
        case 7:
            nDamagePower = DAMAGE_POWER_PLUS_SEVEN;
            break;
        case 8:
            nDamagePower = DAMAGE_POWER_PLUS_EIGHT;
            break;
    }
    DoMagicFang(nPower, nDamagePower);
}
