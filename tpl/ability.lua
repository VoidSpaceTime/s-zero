TPL_ABILITY = {

    AB1 = AbilityTpl("技能1", ABILITY_TARGET_TYPE.TAG_UL_600)
        .icon("AB1").coolDown(4).hpCast(1).mpCast(1)
        .chantCast(1)
        .keepCast(10)
        .levelMax(99)
        .description(
        {
            "基础消耗：" .. colour.purple("{this|mpCast|1}"),
            "对目标造成伤害：" .. colour.gold("{this|level|100}") .. "(技能等级x100)"
        })
        .onSpell(function(evtData)
        evtData.triggerUnit.effect("slash/Red_swing")
        local i = 0
        local ftp = 0.1
        time.setInterval(ftp, function(curTimer)
            if (not evtData.triggerUnit.abilityKeepCasting()) then
                curTimer.destroy()
                print("i=", i)
                return
            end
            i = i + ftp
            evtData.triggerAbility.exp("+33")
            evtData.triggerUnit.effect("slash/Red_swing")
        end)
    end),

    AB2 = AbilityTpl("唯我独尊", ABILITY_TARGET_TYPE.E)
        .icon("AB2")
        .description({ "强击单人特效: +100攻击" })
        .onGain(
        function(evtData)
            evtData.triggerAbility.properties("AB2",
                Buff(evtData.triggerUnit, "强击单人攻击", "AB2", 0, 100,
                    function(buffObj) buffObj.attack("+100") end,
                    function(buffObj) buffObj.attack("-100") end)
                    .purpose()
            )
        end)
        .onLose(function(evtData) evtData.triggerAbility.properties("AB2").rollback() end),

}