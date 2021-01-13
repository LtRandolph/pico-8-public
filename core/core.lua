function clamp(v,low,hi)
    return max(low,min(hi,v))
end

function frac(v)
    return v-flr(v)
end

function randFloat(low,hi)
    return rnd(hi-low)+low
end

function absorbTable(dest,source)
    for k,v in pairs(source) do
        dest[k]=v
    end
end

function indexOf(t,v)
    for i=1,#t do
        if (t[i]==v) return i
    end
    return -1
end

function parseNumbers(table)
    for line in all(split(table.numbers,'\n')) do
        kv=split(line,'=')
        table[kv[1]]=kv[2]
    end
    table.numbers=nil
end

pi=3.14159