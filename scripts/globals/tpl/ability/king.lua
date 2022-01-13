---@param getData noteOnAbilityGetData
---@param loseData noteOnAbilityLoseData
---@param lvcData noteOnAbilityLevelChangeData
---@param attackData noteOnUnitAttackData
TPL_ABILITY.King = AbilityTpl()
    .name("唯我独尊")
    .targetType(ABILITY_TARGET_TYPE.PAS)
    .icon("AB3")
    .description({ "强击单人特效: +{50+this.level()*100}攻击" })
    .levelMax(5)
    .levelUpNeedPoint(101)
    .onEvent(EVENT.Ability.Get, function(getData) getData.triggerUnit.attack("+=" .. 100 * getData.triggerAbility.level()) end)
    .onEvent(EVENT.Ability.Lose, function(loseData) loseData.triggerUnit.attack("+=" .. 100 * loseData.triggerAbility.level()) end)
    .onEvent(EVENT.Ability.LevelChange,
    function(lvcData)
        if (lvcData.value > 0) then
            lvcData.triggerUnit.attack("+=" .. 100 * lvcData.value)
        elseif (evtData.value < 0) then
            lvcData.triggerUnit.attack("-=" .. 100 * math.abs(lvcData.value))
        end
    end)
    .onUnitEvent(EVENT.Unit.Attack,
    function(attackData)
        ability.lightningChain({
            qty = 3,
            sourceUnit = attackData.triggerUnit,
            targetUnit = attackData.targetUnit,
            damage = 100,
            damageSrc = DAMAGE_SRC.ability,
            damageType = { DAMAGE_TYPE.thunder }
        })
    end)
