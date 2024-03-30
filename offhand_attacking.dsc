## Secondhand Attack Mechanic
## By: Rёdginald

# A script of mechanic, that allows players fighting with weapon in second hand.

offhand_attack:
    type: world
    debug: true
    events:
        on player right clicks entity:
          - if <player.item_in_offhand||0> != 0 && <player.item_in_offhand.script||0> != 0:
            - if <script[<player.item_in_offhand.script.name>].data_key[data.stats.weapon]> = melee:
              - define weapon_type <script[<player.item_in_offhand.script.name>].data_key[data.stats.weapon_type]>
              - if <[weapon_type]> != polearm && <[weapon_type]> != scythe && <[weapon_type]> != spear && <[weapon_type]> != longsword && <[weapon_type]> != longaxe && <[weapon_type]> != longmace:
                - if <player.has_flag[sechand_atk_cd]> = false:
                  - if <player.is_sneaking> = false:
                    - if <context.entity> != null:
                      - if !<player.is_on_ground>:
                        - define loc1 <player.location.y>
                        - wait 2t
                        - define loc2 <player.location.y>
                        - if <[loc2]> < <[loc1]> && !<[player].is_sprinting>:
                          - define crit <element[1.5]>
                      - determine passively cancelled
                      - define hh <player.has_effect[FAST_DIGGING]>
                      - define ff <player.has_effect[SLOW_DIGGING]>
                      - if <[hh]>:
                        - define hh_raw_amp <element[<player.effects_data.filter[get[type].equals[FAST_DIGGING]].parse[get[amplifier]].formatted>]>
                      - if <[ff]>:
                        - define ff_raw_amp <element[<player.effects_data.filter[get[type].equals[SLOW_DIGGING]].parse[get[amplifier]].formatted>]>
                      - define parsed_atk_cd <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_speed.amount].mul[-10]>
                      - if <[hh]>:
                        - define hh_bonus <[hh_raw_amp].mul[10]>
                      - if <[ff]>:
                        - define ff_bonus <[ff_raw_amp].mul[10]>
                      - define raw_pen <[parsed_atk_cd].add[20]>
                      - define raw <[parsed_atk_cd].add[10]>
                      - if !<[hh]> && <[ff]>:
                        - if !<player.has_flag[strong_sechand]>:
                          - define ff_pen <[ff_raw_amp].mul[20]>
                          - flag <player> sechand_atk_cd expire:<[raw_pen].add[<[ff_raw_amp]>]>t
                        - else:
                          - define ff_str <[ff_raw_amp].mul[10]>
                          - flag <player> sechand_atk_cd expire:<[raw].add[<[ff_str]>]>t
                      - if <[hh]> && !<[ff]>:
                        - if !<player.has_flag[strong_sechand]>:
                          - define hh_pen <[hh_raw_amp].mul[10]>
                          - flag <player> sechand_atk_cd expire:<[raw_pen].sub[<[hh_pen]>]>t
                        - else:
                          - define hh_str <[hh_raw_amp].mul[20]>
                          - flag <player> sechand_atk_cd expire:<[raw].sub[<[hh_str]>]>t
                      - if <[hh]> && <[ff]>:
                        - if !<player.has_flag[strong_sechand]>:
                          - define ff_pen <[ff_raw_amp].mul[-20]>
                          - define hh_pen <[hh_raw_amp].mul[10]>
                          - define duo <[ff_pen].add[<[hh_pen]>]>
                          - flag <player> sechand_atk_cd expire:<[raw_pen].add[<[duo]>]>t
                        - else:
                          - define ff_str <[ff_raw_amp].mul[-10]>
                          - define hh_str <[hh_raw_amp].mul[20]>
                          - define duo_str <[ff_str].add[<[hh_str]>]>
                          - flag <player> sechand_atk_cd expire:<[raw_pen].add[<[duo]>]>t
                      - else:
                        - if !<player.has_flag[strong_sechand]>:
                          - flag <player> sechand_atk_cd expire:<[raw_pen]>t
                        - else:
                          - flag <player> sechand_atk_cd expire:<[raw]>t
                        - animate <player> animation:ARM_SWING_OFFHAND for:<server.online_players>
                        - run offhand_damaging def:<player>|<context.entity>|<script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>|<[crit]>
offhand_damaging:
  type: task
  debug: false
  definitions: player|entity|it|crit
  script:
  - wait 1t
  - if <[player].worldguard.test_flag[pvp]> = true || <[player].location.in_region> = false:
    - if <[entity].is_player>:
      - define gm <[entity].gamemode>
    - else:
      - define gm survival
    - define ss <[player].has_flag[strong_sechand]>
    - define we <[player].has_effect[WEAKNESS]>
    - define st <[player].has_effect[INCREASE_DAMAGE]>
    - define wt <script[<[player].item_in_offhand.script.name>].data_key[data.stats.weapon_type]>
    - if <[st]>:
      - define str_bonus <element[<player.effects_data.filter[get[type].equals[INCREASE_DAMAGE]].parse[get[amplifier]].formatted>]>
    - if <[we]>:
      - define weak_bonus <element[<player.effects_data.filter[get[type].equals[WEAKNESS]].parse[get[amplifier]].formatted>]>
    - if <[crit]||0> = 0:
      - define atk_dmg <[it].div[1.5]>
      - define el <element[1]>
      - define crit false
    - else:
      - define atk_dmg <[it]>
      - define el <[crit]>
      - define crit true
    - if <[player].is_sprinting>:
      - define sprint true
    - else:
      - define sprint false
    - if <[entity]> != 0:
      - define entloc <[entity].location>
      - if <[st]> && !<[we]>:
        - if !<[ss]>:
          - hurt <[entity]> <[atk_dmg].add[<[str_bonus].div[2]>]> source:<[player]> cause:ENTITY_EXPLOSION
        - else:
          - hurt <[entity]> <[it].add[<[str_bonus]>].mul[<[el]>]> source:<[player]> cause:ENTITY_EXPLOSION
      - if !<[st]> && <[we]>:
        - if !<[ss]>:
          - hurt <[entity]> <[atk_dmg].sub[<[weak_bonus]>].mul[1]> source:<[player]> cause:ENTITY_EXPLOSION
        - else:
          - hurt <[entity]> <[it].sub[<[weak_bonus]>].mul[<[el]>]> source:<[player]> cause:ENTITY_EXPLOSION
      - if <[st]> && <[we]>:
        - if !<[ss]>:
          - define str <[str_bonus].div[2]>
          - define weak <[atk_dmg].sub[<[weak_bonus]>].mul[1]>
          - hurt <[entity]> <[weak].add[<[str]>]> source:<[player]> cause:ENTITY_EXPLOSION
        - else:
          - define weak <[it].sub[<[weak_bonus]>].mul[1]>
          - hurt <[entity]> <[weak].add[<[str_bonus]>]> source:<[player]> cause:ENTITY_EXPLOSION
      - else:
        - if !<[ss]>:
          - hurt <[entity]> <[it].div[1.5]> source:<[player]> cause:ENTITY_EXPLOSION
        - else:
          - hurt <[entity]> <[it]> source:<[player]> cause:ENTITY_EXPLOSION
      - run offhand_checkdur def:<[player]>|<[crit]>
      - if <[sprint]>:
        - if <[entity]> != 0:
          - if <[gm]> != creative:
            - push <[entity]> origin:<[entloc]> destination:<[player].location.forward[7].add[0,1.5,0]> no_rotate speed:0.3
            - playsound at:<[entloc]> sound:entity_player_attack_knockback pitch:1 volume:1
      - else:
        - if <[entity]> != 0:
          - if <[crit]||0> = 0:
            - if <[wt]> != axe:
              - if <[gm]> != creative:
                - playeffect at:<player.location.forward.add[0,1.2,0]> effect:sweep_attack offset:0 visibility:100
                - playsound at:<[entloc]> sound:entity_player_attack_sweep volume:1 pitch:1
                - foreach <[entloc].find.living_entities.within[1].exclude[<[player]>].exclude[<[entity]>]>:
                  - if <[value]> != 0:
                    - define valloc <[value].location>
                    - if <[value].is_player>:
                      - define valgm <[value].gamemode>
                    - else:
                      - define valgm survival
                    - hurt <[value]> 1.5 source:<[player]> cause:ENTITY_ATTACK
                    - if <[value]> != 0:
                      - if <[valgm]> != creative:
                        - push <[value]> origin:<[valloc]> destination:<[player].location.forward[7].add[0,1.5,0]> no_rotate speed:0.2
            - else:
              - if <[gm]> != creative:
                - push <[entity]> origin:<[entloc]> destination:<[player].location.forward[7].add[0,1.5,0]> no_rotate speed:0.1
          - else:
            - if <[gm]> != creative:
              - push <[entity]> origin:<[entloc]> destination:<[player].location.forward[7].add[0,1.5,0]> no_rotate speed:0.15
offhand_checkdur:
  type: task
  debug: false
  definitions: player|crit
  script:
  - if <[player].gamemode> != creative:
    - define offh <[player].item_in_offhand>
    - if <[crit]>:
      - define par <element[2]>
    - else:
      - define par <element[1]>
    - if <[offh].material.max_durability.sub[<[par]>]> >= <[offh].durability>:
      - inventory adjust slot:offhand durability:<[player].item_in_offhand.durability.add[<[par]>]>
    - else:
      - playsound <[player].location> sound:entity_item_break pitch:1 volume:1
      - playeffect at:<[player].location.add[0,1.25,0]> effect:item_crack special_data:<[offh].script.name> quantity:8 offset:0.2 velocity:<[player].location.direction.vector.div[10]>
      - take item:<[offh]> from:<[player].inventory> slot:offhand
