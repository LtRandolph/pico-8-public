function EDLightning(color,segments)
    return {
        color=color,
        segments=segments,
        draw=drawEffectLightning
    }
end

function drawEffectLightning(ED)
    color(ED.color)
    v1=8*ED.segments[1]
    v2=8*ED.segments[2]
    line(v1.x,v1.y,v2.x,v2.y)
    for i=3,#ED.segments do
        v=8*ED.segments[i]
        line(v.x,v.y)
    end
end