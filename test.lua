-- Select the dwarf and view their inventory, highlighting the item in question.
unit = dfhack.gui.getSelectedUnit()
item = dfhack.gui.getSelectedItem()

print("Start Item owned : ", item.flags.owned)
if item.flags.owned == true then
    item.flags.owned = false

    -- Remove the ownership record on the item by deleting the ref type "general_ref_unit_itemownerst".
    for key, value in pairs(item.general_refs) do
        owned = string.find(tostring(value), "general_ref_unit_itemownerst")
        if owned ~= nil then
            item.general_refs:erase(key)
        end
    end
    printall(item.general_refs)

    -- Find and remove item from the unit's owned items list.
    for key, value in pairs(unit.owned_items) do
        if value == item.id then
            print(string.format("Deleting index %s, item.id %s", key, item.id))
            unit.owned_items:erase(key)
        end
    end
end
print("End Item owned : ", item.flags.owned)
-- printall(unit.owned_items)