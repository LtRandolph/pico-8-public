rectanglemt={
    __add=function(r,v)
        return rectangle(r.min+v,r.max+v)
    end,
    overlaps=function(r1,r2)
        return r1.max.x>=r2.min.x and
            r1.min.x<=r2.max.x and
            r1.max.y>=r2.min.y and
            r1.min.y<=r2.max.y
    end,
    contains=function(r,v)
        return r:overlaps(rectangle(v,v))
    end
}
rectanglemt.__index=rectanglemt

function rectangle(min,max)
    return setmetatable({min=min,max=max},rectanglemt)
end

function rectString(s)
    numbers=split(s)
    return rectangle(vec2(numbers[1],numbers[2]),vec2(numbers[3],numbers[4]))
end