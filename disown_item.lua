--[[
    This is a script that will make a dwarf drop an item they are carrying.
    It will remove the items ownership data, and remove the item from the dwarf's owned_items and used_items.
    This script was made follwing the instructions of gchristopher in the forums,
    I just took those instructions and make it into an script to run with df hack
        http://www.bay12forums.com/smf/index.php?topic=155375.msg6721647#msg6721647

    HOW TO USE:
        * Put this file in your hack/scripts directory inside your main DF directory.
        * Select a dwarf and view their inventory, highlighting the item you want to remove.
        * type disown_item into the df-hack terminal
]]

unit = dfhack.gui.getSelectedUnit()
item = dfhack.gui.getSelectedItem()

-- Checks that the item is owned and not part of a job, then removed the ownership.

if (item.flags.in_job == false and item.flags.owned == true) then
    item.flags.owned = false

    -- Remove the ownership record on the item by deleting the ref type "general_ref_unit_itemownerst".
    if #item.general_refs > 0 then
        for key, value in pairs(item.general_refs) do
            owned = string.find(tostring(value), "general_ref_unit_itemownerst")
            if owned ~= nil then
                item.general_refs:erase(key)
            end
        end
    end

    -- Find and remove item from the unit's owned items list.
    if #unit.owned_items > 0 then
        for key, value in pairs(unit.owned_items) do
            if value == item.id then
                unit.owned_items:erase(key)
            end
        end
    end

    -- Remove from inventory - DOES NOT WORK
    if #unit.inventory > 0 then
        for k, v in pairs(unit.inventory) do
            print(k, v.item.id)
            if v.item.id == item.id then
                unit.inventory:erase(k)
            end
        end
    end

    --  Remove it from their list of item attachment too, to prevent them picking it up again. This may not be necessary.
    if #unit.used_items > 0 then
        for key, value in pairs(unit.used_items) do
            if value.id == item.id then
                unit.used_items:erase(key)
            end
        end
    end

    print(string.format("Ownership removed for item # %s", item.id))
elseif (item.flags.in_job == true) then
    print(string.format("Item # %s is part of a job.", item.id))
elseif item.flags.owned == false then
    print(string.format("Item # %s is already unowned.", item.id))
end
