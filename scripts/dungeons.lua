function claimMirePrize()
    if hasAll({ "label_power_dp", "power" })
            or hasAll({ "label_wisdom_dp", "wisdom" })
            or hasAll({ "label_courage_dp", "courage" })
            or hasAll({ "label_gulley_dp", "gulley" })
            or hasAll({ "label_oren_dp", "oren" })
            or hasAll({ "label_seres_dp", "seres" })
            or hasAll({ "label_osfala_dp", "osfala" })
            or hasAll({ "label_impa_dp", "impa" })
            or hasAll({ "label_irene_dp", "irene" })
            or hasAll({ "label_rosso_dp", "rosso" }) then
        return true
    end
    return false
end

function claimDarkPalacePrize()
    return hasAll({ "label_power_pd", "power" })
            or hasAll({ "label_wisdom_pd", "wisdom" })
            or hasAll({ "label_courage_pd", "courage" })
            or hasAll({ "label_gulley_pd", "gulley" })
            or hasAll({ "label_oren_pd", "oren" })
            or hasAll({ "label_seres_pd", "seres" })
            or hasAll({ "label_osfala_pd", "osfala" })
            or hasAll({ "label_impa_pd", "impa" })
            or hasAll({ "label_irene_pd", "irene" })
            or hasAll({ "label_rosso_pd", "rosso" })
end

function claimDesertPrize()
    return hasAll({ "label_power_dp", "power" })
            or hasAll({ "label_wisdom_dp", "wisdom" })
            or hasAll({ "label_courage_dp", "courage" })
            or hasAll({ "label_gulley_dp", "gulley" })
            or hasAll({ "label_oren_dp", "oren" })
            or hasAll({ "label_seres_dp", "seres" })
            or hasAll({ "label_osfala_dp", "osfala" })
            or hasAll({ "label_impa_dp", "impa" })
            or hasAll({ "label_irene_dp", "irene" })
            or hasAll({ "label_rosso_dp", "rosso" })
end


------------------------------------------------------------------
--------------------------Eastern Palace--------------------------
------------------------------------------------------------------


function access_ep_boss()
    if ep_big_key() and (ep_small_keys(2) or (ep_small_keys(1) and hasAny({ "bombs", "irod" }))) then 
        return attack()
    end
    return false
end

function access_ep_boss_glitched()
    if access_ep_boss() then
        return true
    end
    return ep_small_keys(1) and (has("msword") or (hasAll({ "fsword", "great_spin" })))
end

function access_ep_boss_advanced()
    if access_ep_boss_glitched() then
        return true
    elseif ep_small_keys(1) and has("trod") then
        return attack()
    end
    return false
end

-- Can defeat Yuga 1 in Eastern Palace
function yuga_eastern()

    -- Normal
    if access_ep_boss() then
        if has("bow") then
            return true
        end
        
        --Hard
        if hasAny({ "bombs", "msword", "niceirod" }) or hasAny({ "boomerang", "hookshot" }) then
            return true_for_attack("hard")
        end
    end

    -- Glitched
    if access_ep_boss_glitched() then
        if hasAny({ "bow", "bombs", "msword", "niceirod" }) or hasAny({ "boomerang", "hookshot" }) then
            return true_for_attack("glitched")
        end
    end

    -- Advanced Glitched
    if access_ep_boss_advanced() then
        if hasAny({ "bow", "bombs", "msword", "niceirod" }) or hasAny({ "boomerang", "hookshot" }) then
            return true_for_attack("advanced")
        end

        -- Hell
        if has("irod") then
            return true_for("hell")
        end
    end

    return false
end


------------------------------------------------------------------
--------------------------House of Gales--------------------------
------------------------------------------------------------------


-- Can reach House of Gales 2F (assume TRod)
function hog2F()
    if hg_small_keys(1) then
        if has("merge") and switch() then
            return true
        elseif hasAny({ "bow", "boomerang", "hookshot", "bombs", "irod", "msword" }) or hasAll({ "great_spin", "fsword" }) then
            return true_for("hard")
        end
    end

    return false
end

-- Can reach House of Gales 3F (assume TRod)
function hog3F()
    if hog2F() then
        if hg_small_keys(3) and fire_enemy() and has("merge") then
            return fire_enemy()
        else
            return true_for("glitched")
        end
    else
        return false
    end
end

-- Return if the player can attack Margomill
-- This is the same as attack(), minus the ice rod
function margomill()

    if hg_big_key() and hg_small_keys(4) then 
        return attack_iceproof() 
    elseif hg_big_key() and hg_small_keys(2) then
        return attack_iceproof(), AccessibilityLevel.SequenceBreak
    end

    return false
end


-----------------------------------------------------------------
--------------------------Hyrule Castle--------------------------
-----------------------------------------------------------------


function yuga2()
    return hasAny({ "fsword", "bombs", "frod", "irod", "hammer" })
end


-----------------------------------------------------------------
--------------------------Desert Palace--------------------------
-----------------------------------------------------------------


-- Desert of Mystery
function access_desert()
    if access_lorule_not_cracksanity() then return true end
    if weather_vane("wv_desert") then return true end
    if hasAll({ "cracksanity", "merge" }) and hasAny({ 
        "crack_desert_north", 
        "crack_desert_pillar_left", 
        "crack_desert_pillar_right", 
        "crack_desert_middle", 
        "crack_desert_sw" 
    }) then return true end
    if hasAll({ "cracksanity", "merge" , "crack_desert_palace", "scoot" }) then return true end
    return false
end

-- Desert Palace
function access_desert_palace()
    if weather_vane("wv_desert") and has("srod") then return true end
    if access_lorule_not_cracksanity() and has("srod") then return true end
    if hasAll({ "cracksanity", "crack_desert_sw", "srod" }) then return true end
    if hasAll({ "cracksanity", "crack_desert_palace", "scoot"}) then return true end 
    if access_desert() and hasAll({ "srod", "scroll" }) then return true end

    return false
end

-- [Glitched] Desert Palace
function glitched_access_desert_palace()
    if access_desert_palace() then return true end
    if has("srod") and access_desert() then return true end

    return false
end

-- Return if we can reach Desert Palace 2F
function dp2F()

    if hasAll({ "merge", "srod", "titansmitt" }) and dp_small_keys(1) then 
        if dp_small_keys(2) and switch() then
            return attack()
        else 
            return attack(), AccessibilityLevel.SequenceBreak
        end
    end

    return false 
end

-- Return if we can perform Reverse Desert Palace
function reverseDP()
    if hasAll({ "cracksanity", "merge", "crack_desert_palace", "srod" }) then
        return true_for("advanced") 
    end
    if hasAll({ "not_cracksanity", "merge", "quake", "srod" }) then 
        if advanced_misery_mire_oob() then 
            return true_for("advanced") 
        elseif hell_misery_mire_oob() then
            return true_for("hell") 
        end
    end
    return false
end

-- Return if we can reach and defeat Zaganaga
function zaganaga()
    if hasAll({"not_cracksanity", "quake"}) and dp2F() then 
        if dp_small_keys(5) and dp_big_key() and has("$bawbs") then
            if access_desert_palace() or hasAll({"ER", "dp_entrance"}) then 
                if has("msword") then
                    return true
                else
                    return true_for("hard")
                end
            elseif glitched_access_desert_palace() then
                return true_for("glitched")
            end
        elseif glitched_access_desert_palace() or hasAll({"ER", "dp_entrance"}) then
            if hasAll({"trod", "boots"}) then
                if dp_big_key() and has("$bawbs") then
                    return true_for("advanced")
                else
                    return true, AccessibilityLevel.SequenceBreak
                end
            elseif dp_small_keys(4) and dp_big_key() then
                return true, AccessibilityLevel.SequenceBreak
            end
        end

    elseif hasAll({"cracksanity", "merge", "crack_zaganaga"}) then
        if has("srod") then 
            if has("msword") then
                return true
            else
                return true_for_attack("hard")
            end 
        elseif hasAny({"bow", "msword"}) then
            return true_for("hell")
        end
    
    elseif advanced_misery_mire_oob() and (has("boots") or has("srod")) then
        return true_for_attack("advanced")

    elseif hell_misery_mire_oob() and (hasAny({"boots", "bow", "msword"}) or has("srod")) then
        return true_for_attack("hell")
    end
    return false
end


--------------------------------------------------------------------
--------------------------Thieves' Hideout--------------------------
--------------------------------------------------------------------


-- Can open Thieves' Hideout B1 Door
function thB1DoorOpen()
    if has("merge") and switch() then
        return true
    elseif has("boots") then
        if hasAny({ "boomerang", "irod" }) then
            return has("glitched")
        elseif has("bombs") then
            return has("hell")
        end
    end
    return false
end

-- Can open Thieves' Hideout B2 Door
function thB2DoorOpen()
    if thB1DoorOpen() and has("merge") and hasAny({ "progression_enemies", "bombs" }) then
        return true
    elseif (has("merge") or dungeon_escape()) and adv_th_statue_clip() then
        return has("advanced")
    elseif has("bombs") then
        return has("hell")
    end
    return false
end

function thB1B2DoorsOpen()
    return thB1DoorOpen() and thB2DoorOpen()
end

-- Can drain the water in Thieves' Hideout B3
function thDrainWaterB3()
    if thB1B2DoorsOpen() and hasAll({ "merge", "flippers" }) then
        return true
    end

    if has("trod") then
        if adv_th_statue_clip() then
            return has("advanced")
        elseif hell_th_statue_clip() then
            return has("hell")
        end
    end

    return false
end

--
function thEscapeEquipment()
    return hasAll({"merge"}) and tt_small_key() and thB1B2DoorsOpen() and thDrainWaterB3()
end

-- Can statue clip OOB in Thieves' Hideout under Adv. Glitched Logic
function adv_th_statue_clip()
    return has("merge") and hasAny({ "bow", "boomerang", "irod", "bombs" })
end

-- Can statue clip OOB in Thieves' Hideout under Hell Logic
function hell_th_statue_clip()
    return has("bombs")
            or (has("msword") and (hasAny({ "merge", "boomerang", "irod", "great_spin" })))
            or adv_th_statue_clip()
end

-- Can reach the Thieves' Hideout Escape
--[[ function thEscape()
    if hasAll({ "merge", "flippers" }) and attack() then
        return true
    elseif has("trod") and hasAny({ "bombs", "irod" }) then
        return true_for("advanced")
    else
        return false
    end
end ]]


---------------------------------------------------------------
--------------------------Skull Woods--------------------------
---------------------------------------------------------------


-- Return if the player can attack Knucklemaster (also used for the yuga hyrule castle fight)
-- This is the same as attack(), minus the bow
function knucklemaster()

    if has("msword") then
        return true
    elseif has("swordless") then
        return attack_bowproof()
    else
        return attack_bowproof(), AccessibilityLevel.SequenceBreak
    end

    return false
end



-----------------------------------------------------------------
--------------------------Lorule Castle--------------------------
-----------------------------------------------------------------


-- Never in logic
function barrier_skip()
    return hell_access_central_lorule() and hasAll({ "boots", "trod", "bombs" }) and hasAny({ "hookshot", "boomerang" }) and not lc_requirement()
end

-- Map the Lorule Castle requirement from a progressive item to a number
function lc_requirement()

    local requirement
    if has("lc_requirement_7") then
        requirement = 7
    elseif has("lc_requirement_6") then
        requirement = 6
    elseif has("lc_requirement_5") then
        requirement = 5
    elseif has("lc_requirement_4") then
        requirement = 4
    elseif has("lc_requirement_3") then
        requirement = 3
    elseif has("lc_requirement_2") then
        requirement = 2
    elseif has("lc_requirement_1") then
        requirement = 1
    else
        requirement = 0
    end

    return count("sage") >= requirement
end

-- Return if we can enter Lorule Castle, either with Sages or via the Hyrule Castle Crack
function canEnterLC()
    if lc_requirement() and access_central_lorule() then
        return true
    end

    if hasAll({"not_cracksanity", "merge", "crack_hc", "lc_trials_door"}) then
        return true
    end

    if hasAll({ "cracksanity", "crack_lc", "merge", "lc_trials_door"}) then
        return true
    end

    return false
end

-- [Advanced] Return if we can enter Lorule Castle, either with Sages or via the Hyrule Castle Crack
function advanced_canEnterLC()
    if canEnterLC() then
        return true
    end
    if lc_requirement() and advanced_access_central_lorule() then
        return true
    end
    return false
end

-- [Hell] Return if we can enter Lorule Castle, either with Sages or via the Hyrule Castle Crack
function hell_canEnterLC()
    if advanced_canEnterLC() then
        return true
    end
    if lc_requirement() and hell_access_central_lorule() then
        return true
    end
    return false
end

-- Return if we can reach Lorule Castle 2F
function lc2F()
    if hasAll({"not_cracksanity", "crack_hc", "lc_trials_door"}) then
        return true
    elseif hasAll({"cracksanity", "crack_lc", "lc_trials_door"}) then
        return true
    end

    if has("hard") then
        return true
    end

    return attack()
end

function advanced_lc3F4F()
    if hasAll({"nicebombs", "trod"}) and hasAny({"bow", "merge"}) then
        return true_for("advanced")
    end

    return false
end

-- Returns if we can complete the Lorule Castle Trials normally, without glitches or cracks.
function lc_trials()
    return has("merge") and lc_requirement() and (has("trials_skipped") or hasAll({ "merge", "hookshot", "bombs", "$fire" }))

end

-- Returns only if we can perform Trial's Skip to fight Yuganon, NOT if we can obtain Zelda's check or win the fight
function can_skip_trials()
    if lc_requirement() and yg_requirement() and hasAll({ "merge", "fsword" }) then
        if has("bombs") then
            return true_for("advanced")
        elseif has("niceirod") then
            return true, AccessibilityLevel.SequenceBreak
        end
    end

    return false
end

-- Map the Yuganon requirement from a progressive item to a number
function yg_requirement()
    --return true -- Add this back when it's working

    local requirement
    if has("yg_requirement_7") then
        requirement = 7
    elseif has("yg_requirement_6") then
        requirement = 6
    elseif has("yg_requirement_5") then
        requirement = 5
    elseif has("yg_requirement_4") then
        requirement = 4
    elseif has("yg_requirement_3") then
        requirement = 3
    elseif has("yg_requirement_2") then
        requirement = 2
    elseif has("yg_requirement_1") then
        requirement = 1
    else
        requirement = 0
    end
    
    return count("sage") >= requirement
end

-- Returns only if we can reach the final boss, NOT if we can obtain Zelda's check or win the fight
function can_reach_final_boss()
    if yg_requirement() then

        if has("merge") and (hasAll({"not_cracksanity", "crack_hc"}) or hasAll({"cracksanity", "crack_lc"}))  then
            return true
        end

        if has("ER") then 
            if hasAll({"lc_entrance", "lc_trials_door"}) then
                return true
            elseif hasAll({"lc_entrance", "fsword"}) then
                return true_for("advanced")
            end
            
        else   
            if access_central_lorule() and has("lc_trials_door") then
                return true
            end

            if hasAny({"lc_trials_door", "fsword"}) then
                if access_central_lorule() or advanced_access_central_lorule() then
                    return true_for("advanced")
                elseif hell_access_central_lorule() then
                    return true_for("hell")
                end
            end
        end
    end

    return false
end

