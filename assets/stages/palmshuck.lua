function onCreate()
    --setProperty('skipCountdown', true)
    setProperty('cameraSpeed', 9999999)
   
    makeLuaSprite('noob', 'stages/noob', 200, 300)
    setProperty('noob.scale.x', 1.5)
    setProperty('noob.scale.y', 1.5)
    addLuaSprite('noob', false) 

    makeLuaSprite('bfs', 'stages/bf2', 200, 300)
    setProperty('bfs.scale.x', 1.5)
    setProperty('bfs.scale.y', 1.5)
    addLuaSprite('bfs', false) 
    setProperty('bfs.visible', false)

    makeLuaSprite('ce', 'stages/middle', 500, 300)
    setProperty('ce.scale.x', 1.5)
    setProperty('ce.scale.y', 1.5)
    addLuaSprite('ce', false) 
    setProperty('ce.visible', false)
end

function onCreatePost()
    setProperty('showRating', false);
    setProperty('showComboNum', false);
    setProperty('gf.visible', false)
    setProperty('boyfriend.visible', false)
end

function onUpdate()
    triggerEvent('Camera Follow Pos', tonumber(1400), tonumber(700))
end

function onSectionHit()
    if not mid then
        if mustHitSection == false then
            setProperty('bfs.visible', false)
            setProperty('boyfriend.visible', false)
            setProperty('dad.visible', true)
            setProperty('noob.visible', true)
        else 
            setProperty('bfs.visible', true)
            setProperty('boyfriend.visible', true)
            setProperty('dad.visible', false)
            setProperty('noob.visible', false)
        end
    end
end

function goodNoteHitPre(i, _, t, s)
    if s then
        setProperty('notes.members['..i..'].noAnimation', true)
        setProperty((getProperty('notes.members['..i..'].gfNote') and 'gf' or 'boyfriend')..'.holdTimer', 0)
    end
end

function opponentNoteHitPre(i, _, t, s)
    if s then
        setProperty('notes.members['..i..'].noAnimation', true)
        setProperty((getProperty('notes.members['..i..'].gfNote') and 'gf' or 'dad')..'.holdTimer', 0)
    end
end
