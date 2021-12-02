TPL_ABILITY.King = AbilityTpl()
    .name("唯我独尊")
    .targetType(ABILITY_TARGET_TYPE.PAS)
    .icon("AB2")
    .description({ "强击单人特效: +{50+this.level()*100}攻击" })
    .levelMax(5)
    .levelUpNeedPoint(101)
    .onGet(function(evtData)
    evtData.triggerUnit.attack("+=" .. 100 * evtData.triggerAbility.level())
end)
    .onLose(function(evtData)
    evtData.triggerUnit.attack("-=" .. 100 * evtData.triggerAbility.level())
end)
    .onLevelChange(function(evtData)
    if (evtData.value > 0) then
        evtData.triggerUnitt.attack("+=" .. 100 * evtData.value)
    elseif (evtData.value < 0) then
        evtData.triggerUnitt.attack("-=" .. 100 * math.abs(evtData.value))
    end
end)