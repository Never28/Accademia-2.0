#include "nw_i0_spells"

void main()
{
    ActionStartConversation(OBJECT_SELF, "mod_clas_har", FALSE, FALSE);
    IncrementRemainingFeatUses(OBJECT_SELF,FEAT_CRAFT_HARPER_ITEM);
}
