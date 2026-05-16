-- Returns true if the player has the given item or setting
function has(item)
    return Tracker:ProviderCountForCode(item) == 1
end

-- Returns true if the player can use any of the given items
function hasAny(items)
    for _, item in ipairs(items) do
        if has(item) then
            return true
        end
    end
    return false
end

-- Returns true if the player has ALL of the given items
function hasAll(items)
    for _, item in ipairs(items) do
        if not has(item) then
            return false
        end
    end
    return true
end

-- Returns true if the player has NONE of the given items
function hasNone(items)
    for _, item in ipairs(items) do
        if has(item) then
            return false
        end
    end
    return true
end

function hasNot(item)
    return not has(item)
end

function has_bottle()
    return hasAny({ "bottle1", "bottle2", "bottle3", "bottle4", "bottle5"})
end

function break_skull()
    return hasAny({ "fsword", "bow", "boomerang", "hookshot", "power_glove", "boots", "hammer", "bombs", "frod", "irod", "srod" })
end

function weather_vane(vane)
    return hasAll({ "bell", vane })
end

function weather_vane_lorule(vane)
    return has(vane) and warpLorule()
end

-- Returns the count of the given item or setting
function count(item)
    return Tracker:ProviderCountForCode(item)
end

-- Returns true if the player has at least a given amount of an item or setting
function has_amount(item, amount)
    return Tracker:ProviderCountForCode(item) >= amount
end

-- Returns true if we're using the specified settings, or (true, SequenceBreak) if not
function true_for(logic)
    if has(logic) then
        return true
    else
        return true, AccessibilityLevel.SequenceBreak
    end
end

-- Mix between true_for and attack : returns true if both return true or (true, SequenceBreak) if either returns (true, SequenceBreak) or false if attack returns false
function true_for_attack(logic)
    if has(logic) then 
        return attack()
    else
        return attack(), AccessibilityLevel.SequenceBreak
    end
end

-- Can the player attack
function attack()

    if hasAny({ "fsword", "bow", "bombs", "frod", "irod", "hammer", "boots", "nicetrod", "nicehookshot", "superlamp", "supernet" }) then
        return true
    elseif hasAny({"lamp", "net"}) then
        return true_for("lamp_net_weapons")
    end

    return false

end

-- Same as attack(), minus the bow
function attack_bowproof()

    if hasAny({ "fsword", "bombs", "frod", "irod", "hammer", "boots", "nicetrod", "nicehookshot", "superlamp", "supernet" }) then
        return true
    elseif hasAny({"lamp", "net"}) then
        return true_for("lamp_net_weapons")
    end

    return false
end

-- Same as attack(), minus the Ice Rod
function attack_iceproof()

    if hasAny({ "fsword", "bow", "bombs", "frod", "hammer", "boots", "nicetrod", "nicehookshot", "superlamp", "supernet" }) then
        return true
    elseif hasAny({"lamp", "net"}) then
        return true_for("lamp_net_weapons")
    end

    return false
end

-- Return if the player can deal damage to enemies that are immune to fire
function fire_enemy()

    if hasAny({ "fsword", "bow", "bombs", "irod", "hammer", "boots", "nicetrod", "nicehookshot", "supernet" }) then
        return true
    elseif has("net") then
        return true_for("lamp_net_weapons")
    end

    return false
end

function progression_enemies_floor()
    return hasAny({"bombs", "hammer", "progression_enemies"})
end

-- Return if the player can stun enemies
-- Foul Fruit is not considered here as its single-use nature makes it rarely useful
function stun()
    return hasAny({ "boomerang", "hookshot" })
end

-- Has Boomerang, Hookshot, or Fire Rod (used for Hyrule West DM middle level clips/boosts)
function boom_hook_fire()
    return hasAny({ "boomerang", "hookshot", "frod" })
end

function boulder()
    return hasAny({ "bombs", "hammer" })
end

-- Return if the player can Fire Rod Boost or Lemon Boost to small ledges
-- Regular Bomb Boosting is not considered unless the player enables the option
-- Bee Boosting is also considered if enabled and the player doesn't have the Bee Badge
function boost()
    return hasAny({ "frod", "nicebombs" })
end

-- Return if the player can perform Fake Flippers
function fakeFlippers()
    return has("boots") and boost()
end

-- Fake Flippers using either a Bee or regular Bomb to boost
function beeFakeFlippers()
    return has("boots") and (hasAny({ "bombs", "frod" }) or beeBoost())
end

-- Return if the player can perform a Shield Rod Clip
-- This must be enabled in options to be considered, and the player needs a sword to use the shield
function shieldRodClip()
    return hasAll({ "fsword", "trod", "shield" })
end

-- Return if the player is able to escape an otherwise softlock-able area
-- Having Bell would be ideal, but death warping using Bombs or Fire Rod also works
function escape()
    return hasAny({ "bell", "bombs", "frod" })
end

-- Return if the player is able to escape an otherwise softlock-able area in a Dungeon
-- Having Scoot Fruit would be ideal, but death warping using Bombs or Fire Rod also works
function dungeon_escape()
    return hasAny({ "scoot", "bombs", "frod" })
end

-- Return if Link has a Fire source
-- This is mostly for checking if Link can light torches
function fire()
    return hasAny({ "lamp", "frod" })
end

function canExtinguishTorches()
    return hasAny({ "fsword", "bombs", "trod", "irod", "net" })
end

function bawbs()
    return hasAny({ "progression_enemies", "bombs" })
end

-- Return if Link can hit Crystal Switches
-- Pots aren't accounted for here, but may make hitting some switches possible
function switch()
    return hasAny({ "fsword", "bow", "boomerang", "hookshot", "bombs", "irod", "hammer", "boots" })
end

-- Return if Link can hit Crystal Switches
-- This is the same as switch(), minus the ice rod
function shielded_switch()
    return hasAny({ "fsword", "bow", "boomerang", "hookshot", "bombs", "hammer", "boots" })
end

-- Return if Link either has lamp, or lampless is enabled
function lampless()
    --return hasAny({ "lamp", "lampless" })

    if has("lamp") then
        return true
    else
        return true_for("lampless")
    end
end

function hellBoost()
    return hasAny({ "frod", "bombs" }) or beeBoost()
end

-- Bee Boosting
-- This is a hard opt-in trick, and it can't be done if the player has the Bee Badge
function beeBoost()
    return cutGrass() and hasAny({ "beeBoost_show", "hell" }) and not has("bee_badge");
end

function cutGrass()
    return hasAny({ "fsword", "boomerang", "bombs", "frod", "irod", "lamp", "boots" });
end

-- Can use Cracks
-- Not for Hyrule Castle crack (doesn't need Quake)
function crack()
    return hasAll({ "quake", "merge" })
end

function crack_clip()
    return has("boomerang") or (hasAll({ "not_nice_mode", "hookshot" }) and hasNot("nicehookshot")) or shieldRodClip()
end

function warpLorule()
    return hasAll({ "bell", "merge" }) and (hasAll({ "not_cracksanity", "quake" }) or hasAny({ 
        "crack_hc", 
        "crack_vacant_house", 
        "crack_skull_woods_pillar", 
        "crack_destroyed_house", 
        "crack_lorule_dm_west", 
        "crack_lofi", 
        "crack_rom_lorule", 
        "crack_philosopher", 
        "crack_graveyard_lorule", 
        "crack_waterfall_lorule", 
        "crack_kus_domain", 
        "crack_n-shaped_house", 
        "crack_thieves_town", 
        "crack_dark_ruins_pillar", 
        "crack_dark_ruins_se", "crack_river_lorule", 
        "crack_swamp_pillar_lorule", 
        "crack_lake_lorule", 
        "crack_lorule_hotfoot", 
        "crack_left_lorule_paradox", 
        "crack_right_lorule_paradox", 
        "crack_mire_exit", 
        "crack_mire_north", 
        "crack_mire_pillar_left", 
        "crack_mire_pillar_right", 
        "crack_mire_middle", 
        "crack_mire_sw", 
        "crack_zaganaga", 
        "crack_lc" 
    }))
end


-- Can players complete Sanctuary
function sanctuary()
    if hs_small_key() and hasAny({ "lamp", "frod" }) then
        return attack()
    end
    return false
end

function maiamaiUpgradeAvailable()
    if has("maiamai_100") then
        return 10
    elseif has("maiamai_90") then
        return 9
    elseif has("maiamai_80") then
        return 8
    elseif has("maiamai_70") then
        return 7
    elseif has("maiamai_60") then
        return 6
    elseif has("maiamai_50") then
        return 5
    elseif has("maiamai_40") then
        return 4
    elseif has("maiamai_30") then
        return 3
    elseif has("maiamai_20") then
        return 2
    elseif has("maiamai_10") then
        return 1
    else
        return 0
    end
end

function canUpgradeItem()
    return maiamaiUpgradeAvailable() > motherMaiamaiItemsReceived()
end

function motherMaiamaiItemsReceived()
    return count("maiamai_bow") 
    + count("maiamai_boomerang") 
    + count("maiamai_hookshot") 
    + count("maiamai_hammer") 
    + count("maiamai_bombs") 
    + count("maiamai_fire_rod") 
    + count("maiamai_ice_rod") 
    + count("maiamai_tornado_rod") 
    + count("maiamai_sand_rod")
end

function inspect_crack_lorule()
    return crack() or hasAll({ "crack_hc", "merge" })
end

function access_lorule_not_cracksanity()
    return hasAll({ "not_cracksanity", "merge", "quake" })
end

-- Small Keysy
function ep_small_keys(amount) return has("keysy_small") or has_amount("ep_small_keys", tonumber(amount)) end
function hg_small_keys(amount) return has("keysy_small") or has_amount("hg_small_keys", tonumber(amount)) end
function th_small_keys(amount) return has("keysy_small") or has_amount("th_small_keys", tonumber(amount)) end
function hs_small_key() return hasAny({ "keysy_small", "hs_small_key" }) end
function ls_small_key() return hasAny({ "keysy_small", "ls_small_key" }) end
function pd_small_keys(amount) return has("keysy_small") or has_amount("pd_small_keys", tonumber(amount)) end
function sp_small_keys(amount) return has("keysy_small") or has_amount("sp_small_keys", tonumber(amount)) end
function sw_small_keys(amount) return has("keysy_small") or has_amount("sw_small_keys", tonumber(amount)) end
function tt_small_key() return hasAny({ "keysy_small", "tt_small_key" }) end
function tr_small_keys(amount) return has("keysy_small") or has_amount("tr_small_keys", tonumber(amount)) end
function dp_small_keys(amount) return has("keysy_small") or has_amount("dp_small_keys", tonumber(amount)) end
function ir_small_keys(amount) return has("keysy_small") or has_amount("ir_small_keys", tonumber(amount)) end
function lc_small_keys(amount) return has("keysy_small") or has_amount("lc_small_keys", tonumber(amount)) end

-- Big Keysy
function ep_big_key() return hasAny({ "keysy_big", "ep_big_key" }) end
function hg_big_key() return hasAny({ "keysy_big", "hg_big_key" }) end
function th_big_key() return hasAny({ "keysy_big", "th_big_key" }) end
function pd_big_key() return hasAny({ "keysy_big", "pd_big_key" }) end
function sp_big_key() return hasAny({ "keysy_big", "sp_big_key" }) end
function sw_big_key() return hasAny({ "keysy_big", "sw_big_key" }) end
function tt_big_key() return hasAny({ "keysy_big", "tt_big_key" }) end
function tr_big_key() return hasAny({ "keysy_big", "tr_big_key" }) end
function dp_big_key() return hasAny({ "keysy_big", "dp_big_key" }) end
function ir_big_key() return hasAny({ "keysy_big", "ir_big_key" }) end

-- Used for entrance randomizer : the corresponding entrance is obtained upon being captured
function tracker_on_location_updated(section)
    if section.CapturedItem == nil then return end

    local item = section.CapturedItem
    if item:CanProvideCode("entrance") then 
        item.Active = true
    end

    return
end
