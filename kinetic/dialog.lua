function showDialog(dialogs)
    dialogChain={}
    for dialog in all(split(dialogs,'~')) do
        add(dialogChain,split(dialog,'|'))
    end
    startDialogIndex(1)
    previousUpdate=_update60
    _update60=updateDialog
    _draw=drawDialog
end

function startDialogIndex(index)
    dialogIndex=index
    spriteIndex,string=unpack(dialogChain[dialogIndex])
    sfx(spriteIndex+22)
    dismissTicks=15
end

function updateDialog()
    updateCamera()
    if dismissTicks>0 then
        dismissTicks-=1
    elseif btnp(btnJump) then
        if dialogIndex<#dialogChain then
            startDialogIndex(dialogIndex+1)
        else
            sfx(spriteIndex+23)
            _update60=previousUpdate
            _draw=drawDefault
        end
    end
end

function drawDialog()
    drawDefault()
    rectfill(0,109,128,128,0)
    onLeft=spriteIndex==26
    spr(spriteIndex,onLeft and 0 or 112,111,2,2)
    print(string,onLeft and 17 or 1,110,7)
end

originalFns={}
function wrapFnWithDialog(fnName,strings)
    if (originalFns[fnName]) return

    originalFns[fnName]=_ENV[fnName]

    _ENV[fnName]=function(...)
        showDialog(strings)
        _ENV[fnName]=originalFns[fnName]
        originalFns[fnName]=nil
        return _ENV[fnName](...)
    end
end

function clearWrappedFns()
    for k,v in pairs(originalFns) do
        _ENV[k]=v
    end
    originalFns={}
end