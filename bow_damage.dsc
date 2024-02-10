## Advanced bows and types of arrow damage mechanic
## By: Rёdginald

bow_damage:
  type: world
  debug: false
  events:
    on entity damaged by arrow:
      - determine passively cancelled
      - playsound sound:entity_arrow_hit <context.entity.location> volume:1 pitch:1
      - adjust <context.entity> max_no_damage_duration:1t
      # Далее, один за другим наносятся нужные типы урона.
      ## ФИЗИЧЕСКИЙ ##
      - if <context.projectile.has_flag[arrof_damage]>:
        - wait 1t
        - if <context.projectile.has_flag[shooter]>:
          - hurt <context.entity||0> <context.projectile.flag[arrof_damage]> cause:ENTITY_ATTACK source:<context.projectile.flag[shooter]>
        - else:
          - hurt <context.entity||0> <context.projectile.flag[arrof_damage]>
      ## ОГНЕННЫЙ ##
      - if <context.projectile.has_flag[arrof_fire_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_fire_damage]> cause:FIRE
      ## МАГИЧЕСКИЙ ##
      - if <context.projectile.has_flag[arrof_magic_damage]>:
        - wait 1t
        - if <context.projectile.has_flag[shooter]>:
          - hurt <context.entity||0> <context.projectile.flag[arrof_magic_damage]> cause:MAGIC source:<context.projectile.flag[shooter]>
        - else:
          - hurt <context.entity||0> <context.projectile.flag[arrof_magic_damage]> cause:MAGIC
      ## ЛЕДЯНОЙ ##
      - if <context.projectile.has_flag[arrof_cold_damage]>:
        - wait 1t
        - hurt <context.entity||0> <context.projectile.flag[arrof_cold_damage]> cause:DRYOUT
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
      - if <player.has_flag[largebowcharging]>:
        - flag <player> largebowcharging:!
      - define weapontype <script[<player.item_in_hand.script.name>].data_key[data.stats.weapon_type]>
      - if <[weapontype]> = bow || <[weapontype]> = large_bow:
        - if <[weapontype]> = large_bow:
          - if <player.is_sneaking> = false:
            - determine passively cancelled
            - actionbar targets:<player> "<&c><&l>smn_longbow"
          # Проверка на тип стрел.
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != long_arrow:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l>smn_longarrows"
        - if <[weapontype]> = bow:
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != arrow:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l>smn_arrows"
        - if <player.has_flag[bowcharge]>:
          # Физический урон суммируется от показателя лука, и от показателя самой стрелы.
          - if <script[<player.item_in_hand.script.name>].data_key[data.stats.bow_damage]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0> != 0:
              - define arrow_personal_dmg <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0>
              - define bowdmg <script[<player.item_in_hand.script.name>].data_key[data.stats.bow_damage].mul[<player.flag[bowcharge]>]>
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
          - if <script[<player.item_in_hand.script.name>].data_key[data.stats.bow_damage]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0> != 0:
              - define arrow_personal_dmg_penalty <script[<context.item.script.name>].data_key[data.stats.arrof_damage].div[2.5]||0>
              - define bowdmg_penalty <script[<player.item_in_hand.script.name>].data_key[data.stats.bow_damage].div[2.5]||0>
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
        - if <[weapontype]> = bow:
          - itemcooldown bow duration:0.5s
        - if <[weapontype]> = large_bow:
          - itemcooldown bow duration:2s
      - if <[weapontype]> = crossbow || <[weapontype]> = ballista:
        # Проверка на тип стрел.
        - if <[weapontype]> = crossbow:
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != bolt:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l>smn_bolts"
              - drop <context.item> quantity:1 <player.location>
        - if <[weapontype]> = ballista:
          - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != 0:
            - if <script[<context.item.script.name>].data_key[data.stats.arrow_type]||0> != long_bolt:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l>smn_longbolts"
              - drop <context.item> quantity:1 <player.location>
        - if <script[<player.item_in_hand.script.name>].data_key[data.stats.bow_damage]||0> != 0:
          - if <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0> != 0:
            - define arrow_personal_dmg <script[<context.item.script.name>].data_key[data.stats.arrof_damage]||0>
            - define bowdmg <script[<player.item_in_hand.script.name>].data_key[data.stats.bow_damage]>
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
        - if <[weapontype]> = crossbow:
          - itemcooldown crossbow duration:0.5s
        - if <[weapontype]> = ballista:
          - itemcooldown crossbow duration:2.5s
    on player right clicks block:
      - if <player.item_in_hand.material.name> = bow:
        - define weapontype <script[<player.item_in_hand.script.name>].data_key[data.stats.weapon_type]>
        - if <[weapontype]> = bow || <[weapontype]> = large_bow:
          - if <player.has_flag[bowcharge]>:
            - flag <player> bowcharge:!
        - if <[weapontype]> = large_bow:
          - if <player.is_sneaking> = false:
            - determine passively cancelled
            - actionbar targets:<player> "<&c><&l>smn_longbow"
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


# Эта часть скрипта позволяет присвоить мобу-лучнику (Или арбалетчику) любой дистанционный урон.
bow_damage_mob:
  type: world
  debug: false
  events:
    on entity shoots bow:
      ## Физика
      - if <context.entity.has_flag[mob_arrow_dmg]>:
        - define physdmg  <context.entity.flag[mob_arrow_dmg].mul[2]>
        - flag <context.projectile> arrof_damage:<[physdmg]>
        - flag <context.projectile> shooter:<context.entity>
      ## Огонь
      - if <context.entity.has_flag[mob_arrow_fire_dmg]>:
        - define firedmg  <context.entity.flag[mob_arrow_fire_dmg]>
        - flag <context.projectile> arrof_fire_damage:<[firedmg]>
      ## Магия
      - if <context.entity.has_flag[mob_arrow_magic_dmg]>:
        - define magicdmg  <context.entity.flag[mob_arrow_magic_dmg]>
        - flag <context.projectile> arrof_magic_damage:<[magicdmg]>
        - flag <context.projectile> shooter:<context.entity>
      ## Холод
      - if <context.entity.has_flag[mob_arrow_cold_dmg]>:
        - define colddmg  <context.entity.flag[mob_arrow_cold_dmg]>
        - flag <context.projectile> arrof_cold_damage:<[colddmg]>
      ## Молния
      - if <context.entity.has_flag[mob_arrow_lightning_dmg]>:
        - define lightdmg  <context.entity.flag[mob_arrow_lightning_dmg]>
        - flag <context.projectile> arrof_lightning_damage:<[lightdmg]>
      ## Яд
      - if <context.entity.has_flag[mob_arrow_poison_dmg]>:
        - define poisondmg  <context.entity.flag[mob_arrow_poison_dmg]>
        - flag <context.projectile> arrof_poison_damage:<[poisondmg]>
      # Если мобу забыли присвоить урон, то его урон от стрелы устанавливается как 5.
      - else:
        - if <context.entity.is_player> = false:
          - if <context.entity.has_flag[mob_arrow_dmg]> = false:
            - if <context.entity.has_flag[mob_arrow_fire_dmg]> = false:
              - if <context.entity.has_flag[mob_arrow_magic_dmg]> = false:
                - if <context.entity.has_flag[mob_arrow_cold_dmg]> = false:
                  - if <context.entity.has_flag[mob_arrow_lightning_dmg]> = false:
                    - if <context.entity.has_flag[mob_arrow_poison_dmg]> = false:
                      - flag <context.projectile> arrof_damage:6
                      - flag <context.projectile> shooter:<context.entity>


arrow_pick_up:
  type: world
  debug: false
  events:
    # Возможность подбирать выпущенные кастомные стрелы.
    on player picks up launched arrow:
      - if <context.arrow.has_flag[arrow_item]>:
        - determine passively cancelled
        - define item <context.arrow.flag[arrow_item]>
        - remove  <context.arrow>
        - give <[item]> to:<player.inventory>
        - playsound sound:entity_item_pickup <player.location> volume:0.8 pitch:1
    on player shoots bow:
      - if <context.item.script.name||0> != 0:
        - define scriptofarrow <context.item.script.name>
        - if <context.projectile||0> != 0:
          - flag <context.projectile> arrow_item:<[scriptofarrow]>


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
        bow_damage: 8
        lvl_req: 10
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Bow"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 10"
          text: "<n><&7><&o>Excellent yew bow. Its bowstring<n><&7><&o>sings in the wind, and the handle lies<n><&7><&o>in the hand as comfortably as possible."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Ranged damage: <&c>From 3.2 to 12<n><&7>[<&a>£<&7>] Weight:<&a> 5.0"
        attribute_modifiers:
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
        weapon_type: large_bow
        bow_damage: 10
        lvl_req: 10
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Long bow"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 10"
          text: "<n><&7><&o>A long and strong bow that belonged<n><&7><&o>to one of the warriors of the Far East.<n><&7><&o>You have to crouch to shoot with it."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Ranged damage: <&c>From 4 to 15<n><&7>[<&a>£<&7>] Weight:<&a> 7.0"
        attribute_modifiers:
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.07
            slot: any


item_mechanical_crossbow:
    type: item
    debug: false
    material: crossbow
    display name: "Mechanical Crossbow"
    enchantments:
    - DURABILITY:4
    - QUICK_CHARGE:3
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Mechanical Crossbow"
        rarity: epic
        weapon: ranged
        weapon_type: crossbow
        bow_damage: 8.5
        lvl_req: 11
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Crossow"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 11"
          text: "<n><&7><&o>Crossbow of the latest design, created<n><&7><&o>by Faustus Scipion. Thanks to its<n><&7><&o> convenient design, it can be recharged<n><&7><&o>quickly and easily."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Ranged damage: <&c>+8.5<n><&7>[<&a>£<&7>] Weight:<&a> 5.0"
        attribute_modifiers:
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.05
            slot: any

# Отрицательное значение для зачарования почему-то не работает.
item_ballista:
    type: item
    debug: false
    material: crossbow
    display name: "Ballista"
    enchantments:
    - DURABILITY:5
    - QUICK_CHARGE:-3
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Ballista"
        rarity: epic
        weapon: ranged
        weapon_type: ballista
        bow_damage: 14
        lvl_req: 12
        lore:
          item: "<n><&8><&l>| Item: <&c>Ranged Weapon"
          type: "<&7><&l>| Type: <&4>Ballista"
          rare: "<&7><&l>| Rarity: <&5>Epic"
          req_lvl: "<n><&8>♦ <&l><&n>Level Required:<&f> 12"
          text: "<n><&7><&o>A huge crossbow used to<n><&7><&o>defend a castle during a siege."
          attributes: "<n><&8><&l>Stats:<n><&7>[<element[🏹].color[#805D38]><&7>] Crossbow damage: <&c>+16<n><&7>[<&a>£<&7>] Weight:<&a> 7.6"
        attribute_modifiers:
          generic_movement_speed:
            type: vanilla
            operation: ADD_SCALAR
            amount: -0.076
            slot: any


## Образцы стрел.

item_quality_arrow:
    type: item
    debug: false
    material: arrow
    display name: "Quality Arrow"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Quality Arrow"
        rarity: rare
        arrow_type: arrow
        arrof_damage: 3
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Arrow"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron-tipped<n><&7><&o>arrow used by the military."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+3"

item_quality_longarrow:
    type: item
    debug: false
    material: arrow
    display name: "Quality Long Arrow"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Quality Long Arrow"
        rarity: rare
        arrow_type: long_arrow
        arrof_damage: 4
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Arrow"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron tipped long<n><&7><&o>arrow used by strong warriors."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+4"

item_quality_bolt:
    type: item
    debug: false
    material: arrow
    display name: "Quality Bolt"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:   "Quality Bolt"
        rarity: rare
        arrow_type: bolt
        arrof_damage: 3
        lore:
          item: "<n><&8><&l>| Item: <&c>Ammo"
          type: "<&7><&l>| Type: <&4>Bolt"
          rare: "<&7><&l>| Rarity: <&9>Rare"
          text: "<n><&7><&o>Quality iron tipped<n><&7><&o>bolt used by the military."
          attributes: "<n><&8><&l>Stats:<n><&7>[<&8>🏹<&7>] Arrow physical damage: <&c>+3"

item_quality_longbolt:
    type: item
    debug: false
    material: arrow
    display name: "Quality Long Bolt"
    enchantments:
    - DURABILITY:1
    mechanisms:
      hides: ATTRIBUTES|ENCHANTS
    data:
      stats:
        display:  "Quality Long Bolt"
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
