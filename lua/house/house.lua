local house = {}

local pairs = {
    {"malt", "lay in"},
    {"rat", "ate"},
    {"cat", "killed"},
    {"dog", "worried"},
    {"cow with the crumpled horn", "tossed"},
    {"maiden all forlorn", "milked"},
    {"man all tattered and torn", "kissed"},
    {"priest all shaven and shorn", "married"},
    {"rooster that crowed in the morn", "woke"},
    {"farmer sowing his corn", "kept"},
    {"horse and the hound and the horn", "belonged to"}
}

house.verse = function(which)
    local lines = {}
    for i = which - 1, 1, -1 do
        table.insert(lines, pairs[i][1] .. "\nthat " .. pairs[i][2] .. " the ")
    end
    return "This is the " .. table.concat(lines) .. "house that Jack built."
end

house.recite = function()
    local verses = {}
    for i = 1, #pairs + 1, 1 do
        table.insert(verses, house.verse(i))
    end
    return table.concat(verses, "\n")
end

return house
