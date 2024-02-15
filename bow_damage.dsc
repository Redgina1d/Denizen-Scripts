bow_damage:
  type: world
  debug: false
  events:
    on entity damaged by arrow:
      - determine passively cancelled
      - playsound sound:entity_arrow_hit <context.entity.location> volume:1 pitch:1
      - adjust <context.entity> max_no_damage_duration:1t
      - define shooter <context.projectile.flag[shooter]||0>
      - define arrow_physdmg <context.projectile.flag[arrof_damage]||0>
      - define arrow_firedmg <context.projectile.flag[arrof_fire_damage]||0>
      - define arrow_magicdmg <context.projectile.flag[arrof_magic_damage]||0>
      - define arrow_colddmg <context.projectile.flag[arrof_cold_damage]||0>
      - define arrow_psndmg <context.projectile.flag[arrof_poison_damage]||0>
      - define arrow_lightdmg <context.projectile.flag[arrof_lightning_damage]||0>
      - wait 1t
      - remove <context.projectile>
      - if <[arrow_physdmg]||0> != 0 && <[shooter]||0> != 0:
        - wait 1t
        - hurt <context.entity||0> <[arrow_physdmg]> cause:ENTITY_ATTACK source:<[shooter]>
      - if <[arrow_firedmg]||0> != 0:
        - wait 1t
        - hurt <context.entity||0> <[arrow_firedmg]> cause:FIRE
      - if <[arrow_magicdmg]||0> != 0:
        - if <[shooter]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <[arrow_magicdmg]> cause:MAGIC source:<[shooter]>
        - else:
          - wait 1t
          - hurt <context.entity||0> <[arrow_magicdmg]> cause:MAGIC
      - if <[arrow_colddmg]||0> != 0:
        - wait 1t
        - hurt <context.entity||0> <[arrow_colddmg]> cause:DRYOUT
      - if <[arrow_psndmg]||0> != 0:
        - wait 1t
        - hurt <context.entity||0> <[arrow_psndmg]> cause:POISON
      - if <[arrow_lightdmg]||0> != 0:
        - wait 1t
        - hurt <context.entity||0> <[arrow_lightdmg]> cause:CUSTOM
      - wait 1t
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
        - run bow_check def:<player>|<context.item>|<context.projectile>|<player.item_in_hand>
        - if <[weapontype]> = bow:
          - itemcooldown bow duration:0.5s
        - if <[weapontype]> = large_bow:
          - itemcooldown bow duration:2s
      - if <[weapontype]> = crossbow || <[weapontype]> = ballista:
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
            - if <script[<player.item_in_offhand.script.name>].data_key[data.stats.arrow_type]||0> = 0 || <player.item_in_offhand.material> != air:
              - determine passively cancelled
              - playsound <player.location> sound:ITEM_CROSSBOW_SHOOT pitch:1.5 volume:1
              - actionbar targets:<player> "<&c><&l>smn_ballista_offhand"
        - run bow_check def:<player>|<context.item>|<context.projectile>|<player.item_in_hand>
        - flag <player> bowcharge:!
        - if <[weapontype]> = crossbow:
          - itemcooldown crossbow duration:0.5s
        - if <[weapontype]> = ballista:
          - itemcooldown crossbow duration:2.5s
    on player right clicks block:
      - if <player.item_in_hand.material.name> = bow:
        - define weapontype <script[<player.item_in_hand.script.name>].data_key[data.stats.weapon_type]>
        - if <[weapontype]> = ballista:
          - if <player.is_sneaking> = false:
            - determine passively cancelled
            - actionbar targets:<player> "<&c><&l>smn_ballista_sneaking"
        - if <[weapontype]> = bow || <[weapontype]> = large_bow:
          - if <player.has_flag[bowcharge]>:
            - flag <player> bowcharge:!
        - if <[weapontype]> = large_bow:
          - if <player.is_sneaking> = false:
            - determine passively cancelled
            - actionbar targets:<player> "<&c><&l>smn_longbow"
          - if <script[<player.item_in_offhand.script.name>].data_key[data.stats.arrow_type]||0> = 0 || <player.item_in_offhand.material> != air:
            - determine passively cancelled
            - actionbar targets:<player> "<&c><&l>smn_longbow_offhand"
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
## Позволяет присвоить мобу-лучнику (Или арбалетчику) любой дистанционный урон через флаг.
bow_damage_mob:
  type: world
  debug: false
  events:
    on entity shoots bow:
      - if <context.entity.has_flag[mob_arrow_dmg]>:
        - define physdmg  <context.entity.flag[mob_arrow_dmg].mul[2]>
        - flag <context.projectile> arrof_damage:<[physdmg]>
        - flag <context.projectile> shooter:<context.entity>
      - if <context.entity.has_flag[mob_arrow_fire_dmg]>:
        - define firedmg  <context.entity.flag[mob_arrow_fire_dmg]>
        - flag <context.projectile> arrof_fire_damage:<[firedmg]>
      - if <context.entity.has_flag[mob_arrow_magic_dmg]>:
        - define magicdmg  <context.entity.flag[mob_arrow_magic_dmg]>
        - flag <context.projectile> arrof_magic_damage:<[magicdmg]>
        - flag <context.projectile> shooter:<context.entity>
      - if <context.entity.has_flag[mob_arrow_cold_dmg]>:
        - define colddmg  <context.entity.flag[mob_arrow_cold_dmg]>
        - flag <context.projectile> arrof_cold_damage:<[colddmg]>
      - if <context.entity.has_flag[mob_arrow_lightning_dmg]>:
        - define lightdmg  <context.entity.flag[mob_arrow_lightning_dmg]>
        - flag <context.projectile> arrof_lightning_damage:<[lightdmg]>
      - if <context.entity.has_flag[mob_arrow_poison_dmg]>:
        - define poisondmg  <context.entity.flag[mob_arrow_poison_dmg]>
        - flag <context.projectile> arrof_poison_damage:<[poisondmg]>
      - else:
        - if <context.entity.is_player> = false:
          - if <context.entity.has_flag[mob_arrow_dmg]> = false:
            - if <context.entity.has_flag[mob_arrow_fire_dmg]> = false:
              - if <context.entity.has_flag[mob_arrow_magic_dmg]> = false:
                - if <context.entity.has_flag[mob_arrow_cold_dmg]> = false:
                  - if <context.entity.has_flag[mob_arrow_lightning_dmg]> = false:
                    - if <context.entity.has_flag[mob_arrow_poison_dmg]> = false:
                      - flag <context.projectile> arrof_damage:5
                      - flag <context.projectile> shooter:<context.entity>
bow_check:
  type: task
  debug: false
  definitions: shooter|item|proj|bow
  script:
  - if <script[<[bow].script.name>].data_key[data.stats.bow_damage]||0> != 0:
    - if <script[<[item].script.name>].data_key[data.stats.arrof_damage]||0> != 0:
      - define <[rangeweapontype]> <script[<[bow].script.name>].data_key[data.stats.weapon_type]||0>
      - if <[rangeweapontype]> = bow || <[rangeweapontype]> = large_bow:
        - if <[shooter].has_flag[bowcharge]> = true:
          - define bowdmg <script[<[bow].script.name>].data_key[data.stats.bow_damage].mul[<[shooter].flag[bowcharge]>]||0>
          - define arrow_personal_dmg <script[<[item].script.name>].data_key[data.stats.arrof_damage]||0>
          - define penalty <element[1]>
        - else:
          - define bowdmg <script[<[bow].script.name>].data_key[data.stats.bow_damage].div[2.5]||0>
          - define arrow_personal_dmg <script[<[item].script.name>].data_key[data.stats.arrof_damage].div[2.5]||0>
          - define penalty <element[2.5]>
      - else:
        - define bowdmg <script[<[bow].script.name>].data_key[data.stats.bow_damage]||0>
        - define arrow_personal_dmg <script[<[item].script.name>].data_key[data.stats.arrof_damage]||0>
        - define penalty <element[1]>
      - flag <[proj]> arrof_damage:<[bowdmg].add[<[arrow_personal_dmg]>]||0>
    - if <script[<[item].script.name>].data_key[data.stats.arrof_magic_dmg]||0> != 0:
      - flag <[proj]> arrof_magic_damage:<script[<[item].script.name>].data_key[data.stats.arrof_magic_dmg].div[<[penalty]>]||0>
    - if <script[<[item].script.name>].data_key[data.stats.arrof_fire_dmg]||0> != 0:
      - flag <[proj]> arrof_fire_damage:<script[<[item].script.name>].data_key[data.stats.arrof_fire_dmg].div[<[penalty]>]||0>
    - if <script[<[item].script.name>].data_key[data.stats.arrof_cold_dmg]||0> != 0:
      - flag <[proj]> arrof_cold_damage:<script[<[item].script.name>].data_key[data.stats.arrof_cold_dmg].div[<[penalty]>]||0>
    - if <script[<[item].script.name>].data_key[data.stats.arrof_lightning_dmg]||0> != 0:
      - flag <[proj]> arrof_lightning_damage:<script[<[item].script.name>].data_key[data.stats.arrof_lightning_dmg].div[<[penalty]>]||0>
    - if <script[<[item].script.name>].data_key[data.stats.arrof_poison_dmg]||0> != 0:
      - flag <[proj]> arrof_poison_damage:<script[<[item].script.name>].data_key[data.stats.arrof_poison_dmg].div[<[penalty]>]||0>
    - flag <[proj]> shooter:<[shooter]>
## Даёт возможность подбирать выпущенные кастомные стрелы.
arrow_pick_up:
  type: world
  debug: false
  events:
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
arrow_fire_particles:
  type: task
  debug: false
  definitions: proj
  script:
  - while <[proj].is_spawned||0>:
    - wait 2t
    - if <[proj].is_spawned||0>:
      - playeffect at:<[proj].location> effect:smoke quantity:1 offset:0.1
    - else:
      - while stop
arrow_exploding_particles:
  type: task
  debug: false
  definitions: proj
  script:
  - while <[proj].is_spawned||0>:
    - wait 2t
    - if <[proj].is_spawned||0>:
      - playeffect at:<[proj].location> effect:redstone quantity:1 offset:0.1 special_data:1|<color[#1F1F1F].hex>
    - else:
      - while stop
arrow_cold_particles:
  type: task
  debug: false
  definitions: proj
  script:
  - while <[proj].is_spawned||0>:
    - wait 2t
    - if <[proj].is_spawned||0>:
      - playeffect at:<[proj].location> effect:redstone quantity:1 offset:0.1 special_data:0.3|<color[#98d5e3].hex>
    - else:
      - while stop
arrow_poison_particles:
  type: task
  debug: false
  definitions: proj
  script:
  - while <[proj].is_spawned||0>:
    - wait 2t
    - if <[proj].is_spawned||0>:
      - playeffect at:<[proj].location> effect:redstone quantity:1 offset:0.1 special_data:0.3|<color[#40853b].hex>
    - else:
      - while stop
arrow_lightning_particles:
  type: task
  debug: false
  definitions: proj
  script:
  - while <[proj].is_spawned||0>:
    - wait 2t
    - if <[proj].is_spawned||0>:
      - playeffect at:<[proj].location> effect:electric_spark quantity:1 offset:0.1
    - else:
      - while stop
## Убирает стрелу через 100 сек. после того как она попала в блок.
arrow_removing:
  type: world
  debug: false
  events:
    on projectile hits block:
      - wait 100s
      - if <context.projectile.is_spawned||0>:
        - remove <context.projectile>
