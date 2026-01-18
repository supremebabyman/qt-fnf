sectionshasstarted = false
haspressedspace = false
dodging = false

function ohio()
    if haspressedspace == true then
        playSound("press", 0.6)     
        --debugPrint('called function')
        dodging = true
        setProperty('timer.alpha', 1)
        doTweenAlpha('ale4', 'timer', 0, 1.25, 'linear')
        runTimer('duration', 0.35)
        runTimer('dodging2', 1.25)
    end
end

function onCreatePost()
    makeLuaSprite('sword', 'uiicons/sword', 200, 1000)
    setObjectOrder('sword', 800)
    scaleObject('sword', 0.8, 0.8)
    doTweenAngle('mySpriteTween', 'sword', 45, 0.005, 'quadOut')
    addLuaSprite('sword', false) 
    
    makeLuaSprite('timer', 'uiicons/cooldown', 985, 525)
    setObjectCamera('timer', 'camHUD')
    scaleObject('timer', 0.1, 0.1)
    setProperty('timer.alpha', 0)
    addLuaSprite('timer', false)
    
    makeLuaSprite('warn', 'uiicons/warning', 875, 525)
    setObjectCamera('warn', 'camHUD')
    scaleObject('warn', 0.1, 0.1)
    setProperty('warn.alpha', 0)
    addLuaSprite('warn', false) 

    makeLuaText('tip', "Press 'Space' to dodge.", 500, 175, 600, false)
    setObjectCamera('tip', 'camHUD')
    setObjectOrder('sword', getObjectOrder('timer') - 5000000)
    addLuaText('tip', true)
    setTextSize('tip', 22)
    setTextAlignment("tip", 'left')
    setTextBorder('tip', 2, '000000')
    setProperty('tip.alpha', 1)
end

function onUpdate(elapsed)
    if downscroll then
        setProperty('timer.y', 75)
        setProperty('warn.y', 75)
        setProperty('tip.y', 95)
    end
    if getPropertyFromClass("flixel.FlxG","keys.justPressed.SPACE") then
        if haspressedspace == false then
            haspressedspace = true
            --debugPrint(haspressedspace)
            playAnim('boyfriend', 'dodge', true, getProperty('boyfriend.specialAnim', true))
            ohio()
        end
    end
    if curStep == 255 then
        doTweenAlpha('ale5', 'tip', 0, 1.25, 'linear')
        sectionshasstarted = true
    end
    if curStep == 767 then
        sectionshasstarted = false
    end
    if curStep == 1279 then
        sectionshasstarted = true
    end
    if curStep == 1791 then
        sectionshasstarted = false
    end
    if curStep == 1903 then
        sectionshasstarted = true
    end
end

function onBeatHit()
    if sectionshasstarted == true then
            if mustHitSection then
        if curBeat % 8 == 4 then
            --debugPrint('three')
        end
        if curBeat % 8 == 5 then
            playSound("countTick", 0.75)
            setProperty('warn.alpha', 1)   
            doTweenAlpha('ale', 'warn', 0, 0.5, 'linear')
            --debugPrint('two')
        end
        if curBeat % 8 == 6 then
            playSound("countTick", 0.75)
            setProperty('warn.alpha', 1)   
            doTweenAlpha('ale', 'warn', 0, 0.5, 'linear')
            --debugPrint('one')
        end
        if curBeat % 8 == 7 then
            removeLuaSprite('sword')
            makeLuaSprite('sword', 'uiicons/sword', 200, 700)
            setObjectOrder('sword', 800)
            scaleObject('sword', 0.8, 0.8)
            doTweenAngle('mySpriteTween', 'sword', 45, 0.005, 'quadOut')
            addLuaSprite('sword', false) 
            doTweenX('swordtween', 'sword', 2350, 0.3, 'linear')
            playSound("sword", 0.25)
            runTimer('missed', 0.2)
            if dodging == true then
                cancelTimer('missed')
                --debugPrint('player dodged') 
            end
        end
    end
    end
end

function goodNoteHitPre(i)
    setProperty('notes.members['..i..'].noAnimation', (getProperty('boyfriend.animation.name') == 'dodge' and not getProperty('boyfriend.animation.finished')))
end

function onTimerCompleted(t, l, ll)
    if t == 'duration' then
        --debugPrint('dodgefinished')
        dodging = false
    end
    if t == 'dodging2' then
        setProperty('timer.alpha', 0)
        haspressedspace = false
        --debugPrint(haspressedspace)
    end
    if t == 'missed' then
        if dodging == false then
            health = getProperty('health')
            setProperty('health', health- 0.65);
            playSound("ouch", 0.5)
            triggerEvent('Play Animation','hurt', 'bf', true)
            getProperty('boyfriend.specialAnim', true)
            --debugPrint('player missed') 
        end
    end
end
