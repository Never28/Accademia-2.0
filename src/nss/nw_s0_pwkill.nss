//::///////////////////////////////////////////////
//:: Power Word, Kill
//:: NW_S0_PWKill
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// When power word, kill is uttered, you can either
// target a single creature or let the spell affect a
// group.
// If power word, kill is targeted at a single creature,
// that creature dies if it has 100 or fewer hit points.
// If the power word, kill is cast as an area spell, it
// kills creatures in a 15-foot-radius sphere. It only
// kills creatures that have 20 or fewer hit points, and
// only up to a total of 200 hit points of such
// creatures. The spell affects creatures with the lowest.
*/
//:://////////////////////////////////////////////
//:: Created By: Noel Borstad
//:: Created On: Dec 18, 2000
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
//:: Update Pass By: Preston W, On: Aug 3, 2001
#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


      //Declare major variables
      object oTarget = GetSpellTargetObject();
        int nHP =  GetHitDice(oTarget);
        int Spec = GetCasterLevel(OBJECT_SELF);
      int nDamageDealt = 0;
      int nHitpoints, nMin;
      object oWeakest;
      effect eDeath = EffectDeath();
      effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
      effect eWord =  EffectVisualEffect(VFX_FNF_PWKILL);
      float fDelay;
      int bKill;;
    int FireCap = GetLocalInt(OBJECT_SELF,"pwkill");
    if(FireCap==0){
        SetLocalInt(OBJECT_SELF,"pwkill",1);
        nHP = nHP + d20(1);
        Spec = Spec + d20(1);
        if(Spec> nHP){
            //Apply the VFX impact
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWord, GetSpellTargetLocation());
            //Check for the single creature or area targeting of the spell
            if (GetIsObjectValid(oTarget)){
                if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF)){
                    if(!MyResistSpell(OBJECT_SELF, oTarget)){
                        //Apply the death effect and the VFX impact
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    }
                }
            }
        }
        DelayCommand(320.0, SetLocalInt(OBJECT_SELF,"pwkill",0));
    }
    else
        SendMessageToPC(OBJECT_SELF,"Questa magia e' lanciabile solo una volta ogni 5 minuti");
}
