local Utils = {}

function Utils.deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end
  
    local no
    if type(o) == 'table' then
      no = {}
      seen[o] = no
  
      for k, v in next, o, nil do
        no[Utils.deepcopy(k, seen)] = Utils.deepcopy(v, seen)
      end
      setmetatable(no, Utils.deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
      no = o
    end
    return no
  end
  

return Utils