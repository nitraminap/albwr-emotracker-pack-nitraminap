
--[[ 
-- Return if we have any cracks in Lorule Castle Area, including the Lorule Castle Crack
function access_central_lorule()
    return has("merge") and (hasAny({ 
        "crack_lc", 
        "crack_vacant_house", 
        "crack_thieves_town", 
        "crack_swamp_pillar_lorule", 
        "crack_left_lorule_paradox", 
        "crack_right_lorule_paradox" 
    }) or (warpLorule() and (hasAny({ 
        "wv_vacant_house", 
        "wv_blacksmith", 
        "wv_thieves", 
        "wv_lorule_castle" 
    }) or (has("wv_swamp") and hasAny({ "hookshot", "flippers" })))))
end
 ]]

 -- Lorule Castle Area
function access_central_lorule()

    if has("not_cracksanity") and inspect_crack_lorule() then
        return true
    end

    if hasAll({ "cracksanity", "merge" }) then
        if hasAny({ 
            "crack_lc", 
            "crack_vacant_house", 
            "crack_left_lorule_paradox", 
            "crack_right_lorule_paradox", 
            "crack_swamp_pillar_lorule", 
            "crack_thieves_town" 
        }) then
            return true
        end
    end

    if weather_vane_lorule("wv_vacant_house")
            or weather_vane_lorule("wv_lorule_castle")
            or weather_vane_lorule("wv_thieves")
            or weather_vane_lorule("wv_blacksmith")
            or (weather_vane_lorule("wv_swamp") and hasAny({ "hookshot", "flippers" })) then
        return true
    end

    return false
end

-- [Adv Glitched] Lorule Castle Area
function advanced_access_central_lorule()
    -- Mire SLZ to Swamp Area
    if access_misery_mire() and advanced_misery_mire_oob() then
        return true
    end
    return false
end

-- [Hell] Lorule Castle Area
function hell_access_central_lorule()
    if advanced_access_central_lorule() then
        return true
    end
    -- Mire SLZ to Swamp Area
    if access_misery_mire() and hell_misery_mire_oob() then
        return true
    end
    return false
end





-- Dark Ruins
function access_dark_ruins()
    if access_lorule_not_cracksanity() then
        return true
    end

    if hasAll({ "cracksanity", "merge" }) then
        if hasAny({ "crack_dark_ruins_pillar", "crack_kus_domain", "crack_dark_ruins_se" }) or (hasAll({ "crack_waterfall_lorule", "flippers" })) then
            return true
        end
    end

    if weather_vane_lorule("wv_dark") and (has("merge") or claimDarkPalacePrize()) then
        return true
    end

    return false
end

-- [Glitched] Dark Ruins
function glitched_access_dark_ruins()
    if access_dark_ruins() then
        return true
    end

    -- From Graveyard
    if access_lorule_graveyard() and boost() and hasAny({ "flippers", "hookshot" }) then
        return true
    end

    -- From Turtle Rock
    if hasAll({ "cracksanity", "crack_lorule_hotfoot", "scroll", "nicebombs" }) then
        return true
    end
    if hasAll({ "cracksanity", "crack_lake_lorule", "flippers", "scroll", "nicebombs" }) then
        return true
    end
    if hasAll({ "cracksanity", "crack_river_lorule", "flippers", "scroll", "nicebombs" }) then
        return true
    end
    if weather_vane_lorule("wv_turtle") and hasAll({ "flippers", "scroll", "nicebombs" }) then
        return true
    end

    return false
end

-- [Advanced] Dark Ruins
function advanced_access_dark_ruins()
    if glitched_access_dark_ruins() then
        return true
    end

    -- From Graveyard
    if access_lorule_graveyard() and boost() and hasAny({ "boots", "hookshot" }) then
        return true
    end
    return false
end

-- [Hell] Dark Ruins
function hell_access_dark_ruins()
    if advanced_access_dark_ruins() then
        return true
    end

    -- From Graveyard
    if access_lorule_graveyard() and hellBoost() and hasAny({ "boots", "hookshot" }) then
        return true
    end

    -- From Turtle Rock
    if hasAll({ "cracksanity", "crack_lorule_hotfoot", "scroll", "bombs" }) then
        return true
    end

    return false
end




-- Lorule Graveyard
function access_lorule_graveyard()
    if access_lorule_not_cracksanity() and has("lamp") and hs_small_key() then
        return attack()
    end

    if hasAll({ "cracksanity", "merge" }) and hasAny({ "crack_philosopher", "crack_graveyard_lorule" }) then
        return true
    end

    if weather_vane_lorule("wv_graveyard") then
        return true
    end

    return false
end

-- [Lampless] Lorule Graveyard
function lampless_access_lorule_graveyard()
    return access_lorule_not_cracksanity() and has("frod") and hs_small_key()
end

-- Skull Woods Area
function access_skull_woods_area()
    if access_lorule_not_cracksanity() then
        return true
    end

    if hasAll({ "cracksanity", "merge" }) and hasAny({ "crack_n-shaped_house", "crack_skull_woods_pillar", "crack_destroyed_house" }) then
        return true
    end

    if weather_vane_lorule("wv_skull") then
        return true
    end

    return false
end





-- Return if we can access the Weather Vane outside Turtle Rock
function access_turtleWV()
    if weather_vane_lorule("wv_turtle") then
        return true
    end
    if access_lorule_not_cracksanity() and has("flippers") then
        return true
    end
    if hasAll({ "cracksanity", "flippers", "merge" }) and hasAny({ "crack_lake_lorule", "crack_river_lorule", "crack_lorule_hotfoot" }) then
        return true
    end
    return false
end

-- [Advanced] Return if we can access the Weather Vane outside Turtle Rock
function advanced_access_turtleWV()
    if access_turtleWV() then
        return true
    end
    if access_lorule_not_cracksanity() and fakeFlippers() then
        return true
    end
    if hasAll({ "cracksanity", "merge", "crack_lorule_hotfoot"}) and fakeFlippers() then
        return true
    end
    if advanced_access_dark_ruins() and fakeFlippers() then
        return true
    end
    return false
end

-- [Hell] Return if we can access the Weather Vane outside Turtle Rock
function hell_access_turtleWV()
    if advanced_access_turtleWV() then
        return true
    end
    if access_lorule_not_cracksanity() and beeFakeFlippers() then
        return true
    end
    if hasAll({ "cracksanity", "crack_lorule_hotfoot"}) and beeFakeFlippers() then
        return true
    end
    if hell_access_dark_ruins() and beeFakeFlippers() then
        return true
    end
    return false
end

-- Return if we can enter Turtle Rock
function enterTR()
    return hasAll({ "irod", "merge" }) and access_turtleWV()
end

-- [Advanced] Return if we can enter Turtle Rock
function advanced_enterTR()
    return hasAll({ "irod", "merge" }) and advanced_access_turtleWV()
end

-- [Hell] Return if we can enter Turtle Rock
function hell_enterTR()
    return hasAll({ "irod", "merge" }) and hell_access_turtleWV()
end





-- Misery Mire
function access_misery_mire()
    if access_lorule_not_cracksanity() then
        return true
    end

    if hasAll({ "cracksanity", "merge" }) and
            (hasAny({ "crack_mire_exit", "crack_mire_pillar_right", "crack_mire_north", "crack_mire_middle", "crack_mire_sw" }) or
                    (hasAll({ "crack_mire_pillar_left", "flippers" })))
            or (has("crack_zaganaga") and claimMirePrize()) then
        return true
    end

    if weather_vane_lorule("wv_mire") then
        return true
    end

    return false
end

-- Return if we can get OoB on the south wall of Misery Mire
function advanced_misery_mire_oob()
    if access_misery_mire() then
        if has("nicebombs") then
            return true
        end
        if hasAll({ "irod", "trod", "frod" }) then
            return true
        end
        if hasAll({ "irod", "trod" }) and crack_clip() then
            return true
        end
    end

    if hasAll({ "cracksanity", "frod" }) and hasAny({ "crack_mire_sw", "crack_mire_middle" }) then
        return true
    end
    if has("cracksanity") and hasAny({ "crack_mire_sw", "crack_mire_middle" }) and crack_clip() then
        return true
    end



    --if (access_misery_mire()
    --        and hasAll({ "irod", "trod" })
    --        or (
    --            has("merge")
    --                    and ((has("cracksanity")
    --                    and hasAny({ "crack_mire_sw", "crack_mire_middle" }))
    --                    or (hasAll({ "not_cracksanity", "quake" })
    --                    and (hasAny({ "srod", "scroll" })
    --                    or boost())))))
    --        and (boost()
    --        or (has("trod")
    --        and crack_clip())) then
    --    return true
    --end

    return false
end

-- Return if we can get OoB on the south wall of Misery Mire
function hell_misery_mire_oob()
    if advanced_misery_mire_oob() then
        return true
    end

    if access_misery_mire() and has("bombs") then
        return true
    end

    if (access_misery_mire() and hasAll({ "irod", "trod" }) 
                                 or (has("merge") and (hasAll({ "not_cracksanity", "quake" }) 
                                                       or (has("cracksanity") and hasAny({ "crack_mire_sw", "crack_mire_middle" }))))) 
       and (has("frod") 
            or (has("trod") and crack_clip())) then
        return true
    end

    return false
end
