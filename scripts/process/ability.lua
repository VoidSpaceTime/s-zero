local process = Process("ability")

process.onSetup(function(this)
    local u1 = TPL_UNIT.HeroFlameLord.create(Player(1), 500, -500, 66.6)
                       .level(1)
                       .reborn(0.5)
                       .hp(100).hpRegen(10)
                       .mp(100)--.mpRegen(-1)
                       .move(522)
                       .attackSpaceBase(1).attack(91).attackRange(1000).attackSpeed(100)
                       .missilePush(Missile("PriestMissile").homing(true).height(300).speed(500))
                       .crit(10).odds("crit", 10)
                       .hpSuck("+=10")
                       .mpSuck("+=10")
                       .enchantWeapon("grass", "+=1")
                       .enchantWeapon("fire", "+=1")
                       .punish(2000)
                       .weight("+=10")

    u1.odds("hurtRebound", "+=100")

    this.stage("u1", u1)

    u1.abilitySlot().push(TPL_ABILITY.AB1)
    u1.abilitySlot().push(TPL_ABILITY.AB2)
    u1.abilitySlot().push(TPL_ABILITY.King, 6)
end)

process.onDestroy(function(this)
    this.stage("u1").destroy()
end)
