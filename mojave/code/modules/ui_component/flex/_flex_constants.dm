
// Flex singleton bro
GLOBAL_DATUM_INIT(flex, /datum/flex, new)


// the *count defines are the number of enum values, important to loop over edge types, etc.
// not including the NeverUsed_1 ones

#define FLEX_EDGECOUNT = 9
#define FLEX_EXPERIMENTALFEATURECOUNT = 1
#define FLEX_MEASUREMODECOUNT = 3

/// <summary>
/// This value was chosen based on empiracle data. Even the most complicated
/// layouts should not require more than 16 entries to fit within the cache.
/// Gomble note - this was written back in endlesstravel/Rockyfi, I have no idea what it means
/// </summary>
#define FLEX_MAXCACHEDRESULTCOUNT = 16

#define FLEX_MEASUREMODENAMES = list( "UNDEFINED", "EXACTLY", "AT_MOST" )
#define FLEX_LAYOUTMODENAMES = list( "LAY_UNDEFINED", "LAY_EXACTLY", "LAY_AT_MOST" )
#define FLEX_NODEDEFAULTS = GLOB.flex.CreateDefaultNode()
#define FLEX_CONFIGDEFAULTS = GLOB.flex.CreateDefaultConfig()
#define FLEX_DEFAULTFLEXGROW = 0
#define FLEX_DEFAULTFLEXSHRINK = 0
#define FLEX_WEBDEFAULTFLEXSHRINK = 1
