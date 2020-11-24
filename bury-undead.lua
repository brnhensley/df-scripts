--[====[

bury-undead
===============================
This script fixes a current (47.04) bug (0010396) that makes undead citizens
unable to be put in coffins after being re-killed. To use it select with
the cursor any part of a formerly undead citizen and run `bury-undead` in
the dfhack terminal. It will find all their body parts and make them buryable.

by pillbo
]====]

local function buryUndead()
    local deadDwarf = dfhack.gui.getSelectedItem()
    local partsFound = 0
    local partsFixed = 0

    if deadDwarf == nil then
        return
    end

    -- check is cursor is on a corpse
    if df.item_corpsest:is_instance(deadDwarf) or df.item_corpsepiecest:is_instance(deadDwarf) then
        local unit = df.unit.find(deadDwarf.unit_id)
        local name = dfhack.TranslateName(dfhack.units.getVisibleName(unit))

        --loop through all corpses looking for other body parts from same dwarf
        for _, corpse in ipairs(df.global.world.items.other.ANY_CORPSE) do
            if corpse.unit_id == deadDwarf.unit_id then
                if corpse.flags.dead_dwarf == false then
                    corpse.flags.dead_dwarf = true
                    partsFixed = partsFixed + 1
                end
                partsFound = partsFound + 1
            end
        end
        print("Found " .. partsFound .. " pieces of " .. name .. ". Made " .. partsFixed .. " corpse pieces buryable.")
    else
        print("That's not a corpse! Put the cursor over a dead dwarf or body part that needs buried!")
    end
end

buryUndead()
