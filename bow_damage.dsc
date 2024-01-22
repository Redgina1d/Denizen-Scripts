bow_damage:
  type: world
  debug: true
  events:
    on entity damaged by arrow:
      - determine cancelled passively
      - playsound sound:entity_arrow_hit <context.entity.location> volume:1 pitch:1
      # У сущности в которую попали на время устанавливается 1-тиковый фрейм неуязвимости, чтобы по ней прошёл весь урон от стрелы.
      - adjust <context.entity> max_no_damage_duration:1t
      # Далее, один за другим наносятся нужные типы урона.
      ## ФИЗИЧЕСКИЙ ##
      - if <context.projectile.has_flag[arrof_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_damage]> cause:ENTITY_ATTACK source:<context.projectile.flag[shooter]>
      ## ОГНЕННЫЙ ##
      - if <context.projectile.has_flag[arrof_fire_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_fire_damage]> cause:FIRE
      ## МАГИЧЕСКИЙ ##
      - if <context.projectile.has_flag[arrof_magic_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_magic_damage]> cause:MAGIC source:<context.projectile.flag[shooter]>
      ## ЛЕДЯНОЙ ##
      - if <context.projectile.has_flag[arrof_cold_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_cold_damage]> cause:FREEZE source:<context.projectile.flag[shooter]>
      ## ЯДОВИТЫЙ ##
      - if <context.projectile.has_flag[arrof_poison_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_poison_damage]> cause:POISON
      ## ЭЛЕКТРИЧЕСКИЙ ##
      - if <context.projectile.has_flag[arrof_lightning_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_lightning_damage]> cause:CUSTOM
      - remove <context.projectile>
      - wait 7t
      # У сущности устанавливается стандартный фрейм неуязвимости.
      - adjust <context.entity> max_no_damage_duration:1s
    on player shoots bow:
      - if <player.has_flag[chargesound]>:
        - flag <player> chargesound:!
      - if <player.has_flag[largebowshooting]>:
        - flag <player> largebowshooting:!
      - define weapontype <script[<player.item_in_hand.script.name>].data_key[data.stats.weapon_type]>
      - if <[weapontype]> = bow || <[weapontype]> = large_bow:
        - if <[weapontype]> = large_bow:
          - if <player.is_sneaking> = false:
            - actionbar targets:<player> "<&c><&l><[smn_longbow]>"
            - determine cancelled
          # Проверка на тип стрел.
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != long_arrow:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l><[smn_longarrows]>"
        - if <[weapontype]> = bow:
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != arrow:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l><[smn_arrows]>"
        - if <player.has_flag[bowcharge]>:
          # Физический урон суммируется от показателя лука, и от показателя самой стрелы.
          - if <script[<player.item_in_hand.script.name>].data_key[data.stats.attribute_modifiers.arrow_damage.amount]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0> != 0:
              - define arrow_personal_dmg <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0>
              - define bowdmg <script[<player.item_in_hand.script.name>].data_key[data.stats.attribute_modifiers.arrow_damage.amount].mul[<player.flag[bowcharge]>]>
              - flag <context.projectile> arrof_damage:<[bowdmg].add[<[arrow_personal_dmg]>]||0>
          ## МАГИЧЕСКИЙ
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_magic_dmg]||0> != 0:
            - flag <context.projectile> arrof_magic_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_magic_dmg]||0>
          ## ОГОНЬ
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_fire_dmg]||0> != 0:
            - flag <context.projectile> arrof_fire_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_fire_dmg]||0>
          ## ЛЁД
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_cold_dmg]||0> != 0:
            - flag <context.projectile> arrof_cold_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_cold_dmg]||0>
          ## МОЛНИЯ
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_lightning_dmg]||0> != 0:
            - flag <context.projectile> arrof_lightning_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_lightning_dmg]||0>
          ## ЯД
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_poison_dmg]||0> != 0:
            - flag <context.projectile> arrof_poison_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_poison_dmg]||0>
          - flag <player> bowcharge:!
          - flag <context.projectile> shooter:<player>
        # Если не дождался зарядки, урон от самого лука и бонусы от стрел становятся значительно хуже.
        - else:
          ## ФИЗИЧЕСКИЙ
          - if <script[<player.item_in_hand.script.name>].data_key[data.stats.attribute_modifiers.arrow_damage.amount]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0> != 0:
              - define arrow_personal_dmg_penalty <script[<context.item.script.name>].data_key[data.stats.arrof_damage].div[2.5]||0>
              - define bowdmg_penalty <script[<player.item_in_hand.script.name>].data_key[data.stats.attribute_modifiers.arrow_damage.amount].div[2.5]||0>
              - flag <context.projectile> arrof_damage:<[bowdmg_penalty].add[<[arrow_personal_dmg_penalty]>]||0>
          ## МАГИЧЕСКИЙ
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_magic_dmg]||0> != 0:
            - flag <context.projectile> arrof_magic_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_magic_dmg].div[2.5]||0>
          ## ОГОНЬ
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_fire_dmg]||0> != 0:
            - flag <context.projectile> arrof_fire_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_fire_dmg]||0>
          ## ЛЁД
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_cold_dmg]||0> != 0:
            - flag <context.projectile> arrof_cold_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_cold_dmg].div[2.5]||0>
          ## МОЛНИЯ
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_lightning_dmg]||0> != 0:
            - flag <context.projectile> arrof_lightning_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_lightning_dmg].div[2.5]||0>
          ## ЯД
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_poison_dmg]||0> != 0:
            - flag <context.projectile> arrof_poison_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_poison_dmg].div[2.5]||0>
          - flag <context.projectile> shooter:<player>
        - itemcooldown bow duration:0.5s
      - if <[weapontype]> = crossbow || <[weapontype]> = ballista:
        # Проверка на тип стрел.
        - if <[weapontype]> = crossbow:
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != bolt:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l><[smn_bolts]>"
        - if <[weapontype]> = ballista:
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != longbolt:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l><[smn_longbolts]>"
        - if <script[<player.item_in_hand.script.name>].data_key[data.stats.attribute_modifiers.arrow_damage.amount]||0> != 0:
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0> != 0:
            - define arrow_personal_dmg <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0>
            - define bowdmg <script[<player.item_in_hand.script.name>].data_key[data.stats.attribute_modifiers.arrow_damage.amount]>
            - flag <context.projectile> arrof_damage:<[bowdmg].add[<[arrow_personal_dmg]>]||0>
        ## МАГИЧЕСКИЙ
        - if <script[<context.item.script.name>].data_key[data.stats.arrof_magic_dmg]||0> != 0:
          - flag <context.projectile> arrof_magic_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_magic_dmg]||0>
        ## ОГОНЬ
        - if <script[<context.item.script.name>].data_key[data.stats.arrof_fire_dmg]||0> != 0:
          - flag <context.projectile> arrof_fire_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_fire_dmg]||0>
        ## ЛЁД
        - if <script[<context.item.script.name>].data_key[data.stats.arrof_cold_dmg]||0> != 0:
          - flag <context.projectile> arrof_cold_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_cold_dmg]||0>
        ## МОЛНИЯ
        - if <script[<context.item.script.name>].data_key[data.stats.arrof_lightning_dmg]||0> != 0:
          - flag <context.projectile> arrof_lightning_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_lightning_dmg]||0>
        ## ЯД
        - if <script[<context.item.script.name>].data_key[data.stats.arrof_poison_dmg]||0> != 0:
          - flag <context.projectile> arrof_poison_damage:<script[<context.item.script.name>].data_key[data.stats.arrof_poison_dmg]||0>
        - flag <context.projectile> shooter:<player>
        - flag <player> bowcharge:!
        - itemcooldown crossbow duration:0.5s
    on player right clicks block:
      - if <player.item_in_hand.material.name> = bow:
        - define weapontype <script[<player.item_in_hand.script.name>].data_key[data.stats.weapon_type]>
        - if <[weapontype]> = bow || <[weapontype]> = large_bow:
          - if <player.has_flag[bowcharge]>:
            - flag <player> bowcharge:!
        - if <[weapontype]> = large_bow:
          - if <player.is_sneaking> = false:
            - determine passively cancelled
            - actionbar targets:<player> "<&c><&l><[smn_longbow]>"
          - if <player.item_in_hand.material.name> = bow:
            - flag <player> chargesound
            - flag <player> bowcd expire:14t
            - wait 15t
            - if !<player.has_flag[bowcd]>:
              - flag <player> bowcharge:1
              - flag <player> bowcd expire:8t
              - wait 9t
              - if <player.has_flag[bowcharge]>:
                - if <player.flag[bowcharge]> = 1:
                  - if !<player.has_flag[bowcd]>:
                    - flag <player> bowcharge:!
                    - flag <player> bowcharge:1.5
                    - if <player.has_flag[chargesound]>:
                      - if <player.item_in_hand.material.name> = bow:
                        - playsound <player.location> sound:item_crossbow_quick_charge_3 pitch:1.5 volume:1
                  - else:
                    - stop
            - else:
              - stop
        - if <[weapontype]> = large_bow:
          - flag <player> largebowcharging


## Образцы луков.

item_yew_bow:
    type: item
    debug: false
    material: bow
    display name: "Yew Bow"
    enchantments:
    - DURABILITY:4
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Yew Bow"
        rarity: epic
        weapon: ranged
        weapon_type: bow
        lvl_req: 12
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Bow"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 12"
          text: "<n><&7><&o>Excellent yew bow. Its bowstring<n><&7><&o>sings in the wind, and the handle lies<n><&7><&o>in the hand as comfortably as possible."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Bow damage: <&c>From 4 to 15<n><&7>[<&a>£<&7>] Weight:<&a> 5.0"
        attribute_modifiers:
          arrow_damage:
            type: custom
            operation: ADD_NUMBER
            amount: +10
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.05
            slot: any

item_samurai_longbow:
    type: item
    debug: false
    material: bow
    display name: "Samurai Longbow"
    enchantments:
    - DURABILITY:5
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Samurai Longbow"
        rarity: epic
        weapon: ranged
        weapon_type: long_bow
        lvl_req: 12
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Long bow"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 12"
          text: "<n><&7><&o>A long and strong bow that belonged<n><&7><&o>to one of the warriors of the Far East.<n><&7><&o>You have to crouch to shoot with it."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Bow damage: <&c>From 5.6 to 21<n><&7>[<&a>£<&7>] Weight:<&a> 7.0"
        attribute_modifiers:
          arrow_damage:
            type: custom
            operation: ADD_NUMBER
            amount: +14
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.07
            slot: any


item_new_crossbow:
    type: item
    debug: false
    material: crossbow
    display name: "Mechanical Crossbow"
    enchantments:
    - DURABILITY:4
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Mechanical Crossbow"
        rarity: epic
        weapon: ranged
        weapon_type: crossbow
        lvl_req: 12
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Crossow"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 12"
          text: "<n><&7><&o>Crossbow of the latest design,<n><&7><&o>created by Faustus Scipion."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Crossbow damage: <&c>+13<n><&7>[<&a>£<&7>] Weight:<&a> 5.0"
        attribute_modifiers:
          arrow_damage:
            type: custom
            operation: ADD_NUMBER
            amount: +13
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.05
            slot: any

item_ballista:
    type: item
    debug: false
    material: crossbow
    display name: "Ballista"
    enchantments:
    - DURABILITY:5
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Ballista"
        rarity: epic
        weapon: ranged
        weapon_type: ballista
        lvl_req: 12
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Ballista"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 12"
          text: "<n><&7><&o>A huge crossbow used to<n><&7><&o>defend a castle during a siege."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Crossbow damage: <&c>+16<n><&7>[<&a>£<&7>] Weight:<&a> 7.6"
        attribute_modifiers:
          arrow_damage:
            type: custom
            operation: ADD_NUMBER
            amount: +14
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.076
            slot: any


## Образцы стрел.

item_iron_bold:
    type: item
    debug: false
    material: arrow
    display name: "Iron-tipped Arrow"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Iron-tipped Arrow"
        rarity: rare
        arrow_type: arrow
        arrof_damage: 3
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Arrow"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron tipped<n><&7><&o>arrow used by the military."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+3"

item_iron_longarrow:
    type: item
    debug: false
    material: arrow
    display name: "Iron-tipped Long Arrow"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Iron-tipped Long Arrow"
        rarity: rare
        arrow_type: long_arrow
        arrof_damage: 4
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Arrow"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron tipped long<n><&7><&o>arrow used by strong warriors."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+4"

item_iron_bolt:
    type: item
    debug: false
    material: arrow
    display name: "Iron-tipped Bolt"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Iron-tipped Bolt"
        rarity: rare
        arrow_type: bolt
        arrof_damage: 3
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Bolt"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron tipped<n><&7><&o>bolt used by the military."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+3"

item_iron_longbolt:
    type: item
    debug: false
    material: arrow
    display name: "Iron-tipped Long Bolt"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Iron-tipped Long Bolt"
        rarity: rare
        arrow_type: long_bolt
        arrof_damage: 4
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Long bolt"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron tipped long<n><&7><&o>bolt used by strong warriors."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+4"

item_flaming_arrow:
    type: item
    debug: false
    material: arrow
    display name: "Flaming Arrow"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Flaming Arrow"
        rarity: rare
        arrow_type: arrow
        arrof_damage: 2
        arrof_fire_dmg: 4
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Arrow"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>An arrow whose tip is<n><&7><&o>wrapped in a burning oily rag."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+2<n><&7>[<&c>🔥<&7>] Arrow fire damage: <&c>+4"
