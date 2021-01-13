function getSelectedVerticalList(current,minVal,maxVal)
    was=current
    
    if (btnp(3)) current+=1
    if (btnp(2)) current-=1

    if (current<minVal) current=maxVal
    if (current>maxVal) current=minVal

    if (was!=current) sfx(27)

    return current
end

function drawHudRect(hudRect)
    minX=hudRect.min.x
    minY=hudRect.min.y
    maxX=hudRect.max.x
    maxY=hudRect.max.y
    rectfill(minX,minY,maxX,maxY,hudDark)
    rect(minX+1,minY+1,maxX-1,maxY-1,hudLight)
    rect(minX,minX,maxX,maxY,0)
end