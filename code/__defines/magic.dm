// Defines for dispell strengths
#define DISPELL_WEAK 1
#define DISPELL_MEDIUM 2
#define DISPELL_STRONG 3
#define DISPELL_UNSTOPPABLE 4

// All possible spell categories. Please follow them.
#define SPELL_CATEGORY_FIRE "Fire"
#define SPELL_CATEGORY_EXPLOSIVE "Explosive"
#define SPELL_CATEGORY_HEALING "Healing"
#define SPELL_CATEGORY_MOBILITY "Mobility"
#define SPELL_CATEGORY_PASSIVE "Passive"
#define SPELL_CATEGORY_ANTIMAGIC "Anti-magic"
#define SPELL_CATEGORY_FORBIDDEN "Forbidden arts"

// Spell flags
#define GHOSTCAST		0x1		//can a ghost cast it?
#define NEEDSCLOTHES	0x2		//does it need the wizard garb to cast? Nonwizard spells should not have this
#define NEEDSHUMAN		0x4		//does it require the caster to be human?
#define Z2NOCAST		0x8		//if this is added, the spell can't be cast at centcomm
#define NO_SOMATIC		0x10	//spell will go off if the person is incapacitated or stunned
#define IGNOREPREV		0x20	//if set, each new target does not overlap with the previous one
//The following flags only affect different types of spell, and therefore overlap
//Targeted spells
#define INCLUDEUSER		0x40	//does the spell include the caster in its target selection?
#define SELECTABLE		0x80	//can you select each target for the spell?
#define NOFACTION		0x1000  //Don't do the same as our faction
#define NONONFACTION	0x2000  //Don't do people other than our faction
//AOE spells
#define IGNOREDENSE		0x40	//are dense turfs ignored in selection?
#define IGNORESPACE		0x80	//are space turfs ignored in selection?
//End split flags
#define CONSTRUCT_CHECK	0x100	//used by construct spells - checks for nullrods
#define NO_BUTTON		0x200	//spell won't show up in the HUD with this

// Invocation
#define INVOKE_SHOUT	"shout"
#define INVOKE_WHISPER	"whisper"
#define INVOKE_EMOTE	"emote"
#define INVOKE_NONE		"none"

// Upgrading
#define UPGRADE_SPEED	"speed"
#define UPGRADE_POWER	"power"
#define UPGRADE_TOTAL	"total"

// Casting costs
#define SPELL_RECHARGE	"recharge"
#define SPELL_CHARGES	"charges"
#define SPELL_HOLDVAR	"holdervar"
