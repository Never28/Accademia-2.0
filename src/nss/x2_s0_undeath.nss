/*
  CREATO DA:      Tempesta
  DATA CREAZIONE: 07-08-2009
*/

// Funzione per Morte ai Non Morti.


#include "NW_I0_SPELLS"
#include "x0_i0_spells"
#include "x2_inc_toollib"
#include "x2_inc_spellhook"

void DoUndeadToDeath(object oCreature)
{
    SignalEvent(oCreature, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
    SetLocalInt(oCreature,"X2_EBLIGHT_I_AM_DEAD", TRUE);
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nDC = GetSpellSaveDC();
    if(GetHitDice(OBJECT_SELF)==40)
        nDC = nDC +5;
    else if(GetHitDice(OBJECT_SELF)>=31)
        nDC = nDC +3;
    else if(GetHitDice(OBJECT_SELF)>=21)
        nDC = nDC +2;
    else if(GetHitDice(OBJECT_SELF)>=11)
        nDC = nDC +1;
    if (!MySavingThrow(SAVING_THROW_WILL,oCreature,nDC,SAVING_THROW_TYPE_NONE,OBJECT_SELF)){
       float fDelay = GetRandomDelay(0.2f,0.4f);
       if (!MyResistSpell(OBJECT_SELF, oCreature, fDelay)){
            effect eDeath = EffectDamage(GetCurrentHitPoints(oCreature),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_ENERGY);
            effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
            DelayCommand(fDelay+0.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oCreature));
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oCreature));
       }
       else
            DelayCommand(1.0f,DeleteLocalInt(oCreature,"X2_EBLIGHT_I_AM_DEAD"));
   }
          else
            DelayCommand(1.0f,DeleteLocalInt(oCreature,"X2_EBLIGHT_I_AM_DEAD"));
}

void main()
{
    if (!X2PreSpellCastCode())
        return;
    int nMetaMagic = GetMetaMagicFeat();
    location lLoc = GetSpellTargetLocation();

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_STRIKE_HOLY),lLoc);
    TLVFXPillar(VFX_FNF_LOS_HOLY_20, lLoc,3,0.0f);
     int nLevel = GetCasterLevel(OBJECT_SELF);
     int nLow = 9999;
     object oLow;
     int nHDLeft = (nLevel) *d2();
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
        nHDLeft = 2 * GetCasterLevel(OBJECT_SELF);
    if (nMetaMagic == METAMAGIC_EMPOWER)
        nHDLeft += (nHDLeft/2);
    int nCurHD;
    object oFirst = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f,lLoc );
     if  (GetIsObjectValid(oFirst)){
        object oTarget = oFirst;
        while (GetIsObjectValid(oTarget) && nHDLeft >0){
            int nAspect = GetAppearanceType(oTarget);
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD || nAspect == APPEARANCE_TYPE_SKELETON_CHIEFTAIN ||
      nAspect == APPEARANCE_TYPE_ZOMBIE_WARRIOR_2 || nAspect == APPEARANCE_TYPE_MOHRG || nAspect == APPEARANCE_TYPE_MUMMY_GREATER
      || nAspect == APPEARANCE_TYPE_VAMPIRE_MALE || nAspect == APPEARANCE_TYPE_VAMPIRE_FEMALE || nAspect == APPEARANCE_TYPE_LICH
      || nAspect == APPEARANCE_TYPE_MINDFLAYER_ALHOON || nAspect == APPEARANCE_TYPE_DEMI_LICH || nAspect == APPEARANCE_TYPE_GOLEM_BONE
      || nAspect == APPEARANCE_TYPE_DRACOLICH){
                nCurHD = GetHitDice(oTarget);
                if (nCurHD <= nHDLeft ){
                    if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
                        if (GetLocalInt(oTarget,"X2_EBLIGHT_I_AM_DEAD") == 0 && !GetPlotFlag(oTarget) && !GetIsDead(oTarget)){
                            // store the creature with the lowest HD
                            if (GetHitDice(oTarget) <= nLow){
                                nLow = GetHitDice(oTarget);
                                oLow = oTarget;
                            }
                        }
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 20.0f ,lLoc);
            if (!GetIsObjectValid(oTarget)){
                if (GetIsObjectValid(oLow) && nHDLeft >= nLow){
                    DoUndeadToDeath(oLow);
                    nHDLeft -= nLow;
                    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 20.0f, GetSpellTargetLocation());
                }
                oLow = OBJECT_INVALID;
                nLow = 9999;
            }
        }
    }
 }
