local PeboxUtils = {}

-- display a table contents
function PeboxUtils.dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

 function PeboxUtils.len(table)
   local count = 0
   for _ in pairs(table) do count = count + 1 end
   return count
 end

 return PeboxUtils