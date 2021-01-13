function EDCircle(center,radius,color)
    return {
        center=center,
        radius=radius,
        color=color,
        draw=drawEffectCircle
    }
end

function drawEffectCircle(ED)
    circ(ED.center.x*8,ED.center.y*8,ED.radius*8,ED.color)
end