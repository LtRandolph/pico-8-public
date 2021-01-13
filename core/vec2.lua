vec2mt={
    __add=function(v1,v2)
        return vec2(v1.x+v2.x,v1.y+v2.y)
    end,
    __sub=function(v1,v2)
        return v1+(-v2)
    end,
    __mul=function(s,v)
        return vec2(s*v.x,s*v.y)
    end,
    __unm=function(self)
        return -1*self
    end,
    __len=function(self)
        return sqrt(self:dot(self))
    end,
    __eq=function(v1,v2)
        return v1.x==v2.x and v1.y==v2.y
    end,
    dot=function(v1,v2)
        return v1.x*v2.x+v1.y*v2.y
    end,
    normalize=function(v)
        len=#v
        if (len==0) return
        v.x/=len
        v.y/=len
    end,
    floored=function(v)
        return vec2(flr(v.x),flr(v.y))
    end,
    atan=function(v)
        return atan2(v.x,v.y)
    end
}
vec2mt.__index=vec2mt

function vec2(x,y)
    return setmetatable({x=x,y=y},vec2mt)
end

function vec2FromAngle(angle)
    return vec2(cos(angle),sin(angle))
end