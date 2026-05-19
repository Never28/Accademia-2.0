const int BASE_ITEM_KATAR = 310;
const int BASE_ITEM_HEAVY_PICK = 301;
const int BASE_ITEM_LIGHT_PICK = 302;
const int BASE_ITEM_SAI = 303;
const int BASE_ITEM_NUNCHAKU = 304;
const int BASE_ITEM_FALCHION = 305;
const int BASE_ITEM_SAP = 308;
const int BASE_ITEM_DAGGERASSASSIN = 309;
const int BASE_ITEM_LIGHTMACECEP = 312;
const int BASE_ITEM_KUKRI2 = 313;
const int BASE_ITEM_FALCHION2 = 316;
const int BASE_ITEM_HEAVYMACE = 317;
const int BASE_ITEM_MAUL = 318;
const int BASE_ITEM_MERCURIALLONGSWORD = 319;
const int BASE_ITEM_MERCURIALGREATSWORD = 320;
const int BASE_ITEM_DOUBLESCIMITAR = 321;
const int BASE_ITEM_GOAD = 322;
const int BASE_ITEM_WINDFIREWHEEL = 323;
const int BASE_ITEM_MAUGDOUBLESWORD = 324;
const int BASE_ITEM_LONGSWORD2 = 330;
const int BASE_ITEM_LANCE = 92;

void main()
{
    object oPC = OBJECT_SELF;
    int nTypeWeapon;
    int nDam;
    int nTypeDam1;
    int nTypeDam2 = 999;
    int nRacial = GetRacialType(oPC);
    int eEffectType;
    effect eLoop = GetFirstEffect(oPC);
    while (GetIsEffectValid(eLoop)){
        eEffectType = GetEffectType(eLoop);
        if(eEffectType == EFFECT_TYPE_DAMAGE_INCREASE)
            RemoveEffect(oPC,eLoop);
        eLoop=GetNextEffect(oPC);
    }
    object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    nTypeWeapon = GetBaseItemType(oRightHand);
    if(nTypeWeapon!=BASE_ITEM_SHORTBOW&&nTypeWeapon!=BASE_ITEM_LONGBOW
    &&nTypeWeapon!=BASE_ITEM_HEAVYCROSSBOW&&nTypeWeapon!=BASE_ITEM_LIGHTCROSSBOW){
        if(nRacial == RACIAL_TYPE_HALFLING || nRacial == RACIAL_TYPE_GNOME){
            switch(nTypeWeapon){
                case BASE_ITEM_DART:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_SHURIKEN:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_THROWINGAXE:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_SLING:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_KATANA:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_CLUB:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_MORNINGSTAR:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    nTypeDam2 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_BATTLEAXE:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_LIGHTFLAIL:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_BASTARDSWORD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_LONGSWORD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_RAPIER:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_SCIMITAR:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_WARHAMMER:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_DWARVENWARAXE:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_HEAVY_PICK:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_LONGSWORD2:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_MAUGDOUBLESWORD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    nTypeDam2 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_MERCURIALLONGSWORD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    nTypeDam2 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_HEAVYMACE:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_SICKLE:
                case BASE_ITEM_KAMA:
                case BASE_ITEM_HANDAXE:
                case BASE_ITEM_KUKRI:
                case BASE_ITEM_KUKRI2:
                case BASE_ITEM_WHIP:
                case BASE_ITEM_WINDFIREWHEEL:
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    nDam = 50;
                    break;
                case BASE_ITEM_GOAD:
                case BASE_ITEM_KATAR:
                case BASE_ITEM_DAGGERASSASSIN:
                case BASE_ITEM_LIGHT_PICK:
                case BASE_ITEM_DAGGER:
                case BASE_ITEM_SHORTSWORD:
                case 202:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                default:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
            }
        }
        else{
            switch(nTypeWeapon){
                case BASE_ITEM_DART:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_SHURIKEN:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_THROWINGAXE:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_SLING:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_GREATSWORD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_GREATAXE:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_HALBERD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    nTypeDam2 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_TRIDENT:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_SHORTSPEAR:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_HEAVYFLAIL:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_SCYTHE:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    nTypeDam2 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_MERCURIALGREATSWORD:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    nTypeDam2 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_LANCE:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_FALCHION:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_FALCHION2:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    break;
                case BASE_ITEM_MAUL:
                    nDam = 75;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
                case BASE_ITEM_KATANA:
                case BASE_ITEM_BASTARDSWORD:
                case BASE_ITEM_BATTLEAXE:
                case BASE_ITEM_LONGSWORD:
                case BASE_ITEM_SCIMITAR:
                case BASE_ITEM_DWARVENWARAXE:
                case BASE_ITEM_LONGSWORD2:
                case BASE_ITEM_SICKLE:
                case BASE_ITEM_KAMA:
                case BASE_ITEM_DOUBLEAXE:
                case BASE_ITEM_HANDAXE:
                case BASE_ITEM_KUKRI:
                case BASE_ITEM_KUKRI2:
                case BASE_ITEM_WHIP:
                case BASE_ITEM_TWOBLADEDSWORD:
                case BASE_ITEM_WINDFIREWHEEL:
                case BASE_ITEM_DOUBLESCIMITAR:
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    nDam = 50;
                    break;
                case BASE_ITEM_MORNINGSTAR:
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    nTypeDam2 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_RAPIER:
                case BASE_ITEM_GOAD:
                case BASE_ITEM_KATAR:
                case BASE_ITEM_DAGGERASSASSIN:
                case BASE_ITEM_LIGHT_PICK:
                case BASE_ITEM_HEAVY_PICK:
                case BASE_ITEM_DAGGER:
                case BASE_ITEM_SHORTSWORD:
                case 202:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_PIERCING;
                    break;
                case BASE_ITEM_MAUGDOUBLESWORD:
                case BASE_ITEM_MERCURIALLONGSWORD:
                    nTypeDam1 = DAMAGE_TYPE_SLASHING;
                    nTypeDam2 = DAMAGE_TYPE_PIERCING;
                    nDam = 50;
                    break;
                default:
                    nDam = 50;
                    nTypeDam1 = DAMAGE_TYPE_BLUDGEONING;
                    break;
            }
        }
        if(nDam == 75){
            if(nTypeDam2 != 999){
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_12,nTypeDam2),oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_12,nTypeDam2),oPC);
            }
            else{
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_20,nTypeDam1),oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_4,nTypeDam1),oPC);
            }
        }
        else{
            if(nTypeDam2 != 999){
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_8,nTypeDam2),oPC);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_8,nTypeDam1),oPC);
            }
            else{
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectDamageIncrease(DAMAGE_BONUS_16,nTypeDam1),oPC);
            }
        }
    }
}
