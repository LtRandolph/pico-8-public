function dump(any,depth)
    local thisDepth=depth or 0
    local indent=""
    for i=1,thisDepth do indent=indent.." " end
    if type(any)=="function" then 
        return "function" 
    end
    if any==nil then 
        return "nil" 
    end
    if type(any)=="string" then
        return any
    end
    if type(any)=="boolean" then
        if any then return "true" end
        return "false"
    end
    if type(any)=="table" then
        local str="\n"..indent.."{"
        for k,v in pairs(any) do
            str=str.."\n"..indent.." "..dump(k,thisDepth+1).." : "..dump(v,thisDepth+1)
        end
        return str.."\n"..indent.."}"
    end
    if type(any)=="number" then
        return ""..any
    end
    return any:__tostring()
end

function drawDebugStats()
    print(flr(100*stat(0)/2048).."% mem",1,1,0)
    print(flr(100*stat(1)).."% cpu",1,6,0)
    print(stat(7).." fps",1,11,0)
end

rectanglemt.__tostring=function(r)
    return "["..tostring(r.min).." | "..tostring(r.max).."]"
end
vec2mt.__tostring=function(v)
    return "("..v.x..","..v.y..")"
end