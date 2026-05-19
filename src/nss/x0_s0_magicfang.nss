/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 06-08-2009
*/

// Funzione per Zanna Magica.

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nPower = (nCasterLevel) / 10;
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
    }
    DoMagicFang(nPower, nDamagePower);
}


