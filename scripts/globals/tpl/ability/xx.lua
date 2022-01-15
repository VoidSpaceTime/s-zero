---@param effectiveData noteOnAbilityEffectiveData
TPL_ABILITY.XX = AbilityTpl()
    .name("火焰飞弹")
    .targetType(ABILITY_TARGET_TYPE.TAG_E)
    .icon("fireRocketIcon")
    .coolDownAdv(1, 0)
    .mpCostAdv(50, 10)
    .levelMax(10)
    .castAnimation("slam")
    .levelUpNeedPoint(10)
    .description(
    {
        "发射火箭，对2000范围内敌人进行攻击造成：" .. colour.gold("{math.floor(this.bindUnit().attack()*this.level())}") .. "点" .. colour.yellowLight("火") .. "属性伤害(技能等级x攻击力)",
        "火箭数量：" .. colour.gold("{math.floor(2+this.level())}") .. "枚" .. "(技能等级+2)",
        colour.red("升级需要") .. "{math.floor(10*this.level())}" .. colour.red("技能点")
    })
    .onEvent(EVENT.Ability.Effective,
    function(effectiveData)
        local dam = effectiveData.triggerUnit.attack() * effectiveData.triggerAbility.level()
        local un = group.rand({
            key = "Unit",
            x = effectiveData.triggerUnit.x(),
            y = effectiveData.triggerUnit.y(),
            radius = 2000,
            limit = effectiveData.triggerAbility.level() + 2,
            ---@param enumUnit Unit
            filter = function(enumUnit)
                return enumUnit.isAlive() and effectiveData.triggerUnit.isEnemy(enumUnit.owner())
            end
        })
        if (#un > 0) then
            for _, u in ipairs(un) do
                ability.missile({
                    modelAlias = "FireBallMissile", --[必须]虚拟箭矢的特效
                    animateScale = 1.00, --虚拟箭矢的动画速度
                    scale = 1.00, --虚拟箭矢的模型缩放
                    hover = 50, --虚拟箭矢的初始离基点高度
                    speed = 500, --每秒冲击的距离（可选的，默认1秒500px)
                    height = math.rand(100, 300), --飞跃高度（可选的，默认0)
                    shake = "rand", --摇摆振幅程度度[0.00~1.00|rand]（可选的，默认0)
                    sourceUnit = effectiveData.triggerUnit, --[必须]伤害来源
                    targetUnit = u,
                    onEnd = function(sou, tar)
                        ability.damage(sou, tar, dam, DAMAGE_SRC.ability, { DAMAGE_TYPE.fire }, { BREAK_ARMOR.defend })
                        return true
                    end,
                })
            end
        end
    end)
    .onEvent(EVENT.Ability.LevelChange,
    function(effectiveData)
        local num = effectiveData.triggerAbility.level() * 10
        if (effectiveData.triggerAbility.level() > 1) then
            num = num + 10
        end
        effectiveData.triggerAbility.levelUpNeedPoint(num)
    end)