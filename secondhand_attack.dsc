## Secondhand Attack Mechanic
## In developing.

secondhand_attack:
    type: world
    debug: false
    events:
        on player right clicks entity:
          - if <script[<player.item_in_offhand.script.name>].data_key[data.stats.weapon]> = melee:
            - define weapon_type <script[<player.item_in_offhand.script.name>].data_key[data.stats.weapon_type]>
            - if <[weapon_type]> != polearm && <[weapon_type]> != scythe && <[weapon_type]> != spear && <[weapon_type]> != longsword && <[weapon_type]> != longaxe && <[weapon_type]> != longmace:
              - if <player.has_flag[sechand_atk_cd]> = false:
                - if <player.is_sneaking> = false:
                  - if <context.entity> != null:
                    - determine passively cancelled
                    - define entity <context.entity.location.add[0,1.3,0]||0>
                    - define entity2 <context.entity.location||0>
                    # Проверка на наличие эффектов силы, слабости, спешки или усталости.
                    - if <player.has_effect[INCREASE_DAMAGE]>:
                      - define strenght_raw_amp <element[<player.effects_data.filter[get[type].equals[INCREASE_DAMAGE]].parse[get[amplifier]].formatted>]>
                    - if <player.has_effect[WEAKNESS]>:
                      - define weakness_raw_amp <element[<player.effects_data.filter[get[type].equals[WEAKNESS]].parse[get[amplifier]].formatted>]>
                    - if <player.has_effect[FAST_DIGGING]>:
                      - define haste_raw_amp <element[<player.effects_data.filter[get[type].equals[FAST_DIGGING]].parse[get[amplifier]].formatted>]>
                    - if <player.has_effect[SLOW_DIGGING]>:
                      - define fatigue_raw_amp <element[<player.effects_data.filter[get[type].equals[SLOW_DIGGING]].parse[get[amplifier]].formatted>]>
                    - define raw_atk_cd <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_speed.amount].mul[-1].div[2]>
                    - define rawest_atk_cd <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_speed.amount].mul[-1]>
                    - define percent_atk_cd <[raw_atk_cd].div[100]>
                    # Определение естественного бонуса от эффекта.
                    - if <player.has_effect[INCREASE_DAMAGE]>:
                      - define strenght_bonus <[strenght_raw_amp].mul[3]>
                    - if <player.has_effect[WEAKNESS]>:
                      - define weakness_bonus <[weakness_raw_amp].mul[3]>
                    - if <player.has_effect[FAST_DIGGING]>:
                      - define haste_bonus <[haste_raw_amp].mul[10]>
                    - if <player.has_effect[SLOW_DIGGING]>:
                      - define fatigue_bonus <[fatigue_raw_amp].mul[10]>
                    # Проверка на наличие эффектов, и установка нужного времени кулдауна атаки.
                    ### ТОЛЬКО УТОМЛЕНИЕ ###
                    ## За каждый уровень дебаффа Утомление скорость атаки второй рукой снижается на 1 секунду.
                    - if <player.has_effect[FAST_DIGGING]> = false && <player.has_effect[SLOW_DIGGING]> = true:
                      - if <player.has_flag[strong_sechand]> = false:
                        - define final_atk_cd_penalty_fatigue <[raw_atk_cd].add[<[fatigue_raw_amp]>]>
                        - flag <player> sechand_atk_cd expire:<[final_atk_cd_penalty_fatigue]>s
                      - else:
                      ## При отсутствии штрафа, за каждый уровень дебаффа Утомление скорость атаки падает на 10%.
                        - define percent_ticks <element[20].div[100]>
                        - define percent_fatigue <[percent_ticks].mul[<[fatigue_bonus]>]>
                        - define final_atk_cd_fatigue <[percent_fatigue].add[<element[20].mul[<[rawest_atk_cd]>]>]>
                        - flag <player> sechand_atk_cd expire:<[final_atk_cd_fatigue]>t
                    ### ТОЛЬКО СПЕШКА ###
                    - if <player.has_effect[FAST_DIGGING]> = true && <player.has_effect[SLOW_DIGGING]> = false:
                      - if <player.has_flag[strong_sechand]> = false:
                        ## За каждый уровень баффа Спешка скорость атаки повышается на уровень баффа, поделённый на 4.
                        - define final_atk_cd_penalty_haste <[raw_atk_cd].sub[<[haste_raw_amp].div[4]>].mul[1]>
                        - flag <player> sechand_atk_cd expire:<[final_atk_cd_penalty_haste]>s
                      - else:
                        ## При отсутствии штрафа, за каждый уровень баффа Спешка скорость атаки повышается на 10%.
                        - define percent_ticks <element[20].div[100]>
                        - define percent_haste <[percent_ticks].mul[<[haste_bonus]>].mul[-1]>
                        - define final_atk_cd_haste <[percent_haste].add[<element[20].mul[<[rawest_atk_cd]>]>]>
                        - flag <player> sechand_atk_cd expire:<[final_atk_cd_haste]>t
                    ### СПЕШКА И УТОМЛЕНИЕ ###
                    - if <player.has_effect[FAST_DIGGING]> = true && <player.has_effect[SLOW_DIGGING]> = true:
                      - if <player.has_flag[strong_sechand]> = false:
                        - define final_atk_cd_penalty_fatigue_haste <[raw_atk_cd].add[<[fatigue_raw_amp].sub[<[haste_raw_amp].div[4]>]>]>
                        - flag <player> sechand_atk_cd expire:<[percent_atk_cd].mul[<element[100].sub[<[haste_bonus]>].add[<[fatigue_bonus]>]>]>s
                      - else:
                        - define percent_ticks <element[20].div[100]>
                        - define percent_fatigue <[percent_ticks].mul[<[fatigue_bonus]>]>
                        - define percent_haste <[percent_ticks].mul[<[haste_bonus]>].mul[-1]>
                        - define atk_cd_fatigue <[percent_fatigue].add[<element[20].mul[<[rawest_atk_cd]>]>]>
                        - define atk_cd_haste <[percent_haste].add[<element[20].mul[<[rawest_atk_cd]>]>]>
                        # Устанавливает КД как нечто среднее между КД с дебаффом Усталость и КД с баффом Спешка.
                        - define final_atk_cd_fatigue_haste <list[<[atk_cd_fatigue]>|<[atk_cd_haste]>].average>
                        - flag <player> sechand_atk_cd <[final_atk_cd_fatigue_haste]>t
                    - else:
                      - if <player.has_flag[strong_sechand]> = false:
                        - flag <player> sechand_atk_cd expire:<[raw_atk_cd]>s
                      - else:
                        - flag <player> sechand_atk_cd expire:<element[20].mul[<[rawest_atk_cd]>]>t
          ### ОТБРАСЫВАЮЩАЯ АТАКА ###
                    - if <player.is_sprinting> = true:
                      - animate <player> animation:ARM_SWING_OFFHAND for:<server.online_players>
                      - if <player.worldguard.test_flag[pvp]> = true || <player.location.in_region> = false:
                        - if <[entity]> != 0:
                          # Проверка на наличие эффектов, и установка нужного значения урона от атаки.
                          ### ТОЛЬКО СИЛА ###
                          - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = false:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty].add[<[strenght_bonus].div[2]>]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg].add[<[strenght_bonus]>]> source:<player> cause:ENTITY_EXPLOSION
                          ### ТОЛЬКО СЛАБОСТЬ ###
                          - if <player.has_effect[INCREASE_DAMAGE]> = false && <player.has_effect[WEAKNESS]> = true:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1]> source:<player> cause:ENTITY_EXPLOSION
                          ### СИЛА И СЛАБОСТЬ ###
                          - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = true:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus].div[2]>]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus]>]> source:<player> cause:ENTITY_EXPLOSION
                          ### БЕЗ ЭФФЕКТОВ ###
                          - else:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg]> source:<player> cause:ENTITY_EXPLOSION
                          - if <[entity]> != 0:
                            - push <context.entity||0> origin:<[entity2]> destination:<player.location.forward[7].add[0,3,0]> no_rotate speed:0.4
                            - playsound <[entity]> sound:entity_player_attack_knockback pitch:1 volume:1
                          - if <player.gamemode.is[!=].to[creative]||false>:
                            - if <player.item_in_offhand.material.max_durability.sub[2]> >= <player.item_in_offhand.durability>:
                              - inventory adjust slot:offhand durability:<player.item_in_offhand.durability.add[1]>
                            - else:
                              - playsound <player.location> sound:entity_item_break pitch:1 volume:1
                              - playeffect at:<player.location.add[0,1.25,0]> effect:item_crack special_data:<player.item_in_offhand.script.name> quantity:8 offset:0.2 velocity:<player.location.direction.vector.div[10]>
                              - take slot:offhand
                      - else:
                         - playsound at:<context.entity.location> sound:entity_player_attack_weak volume:1 pitch:1
          ### КРИТИЧЕСКАЯ АТАКА ###
                    - if <player.is_on_ground> = false:
                      - define loc1 <player.location.y>
                      - wait 1t
                      - define loc2 <player.location.y>
                      - if <[loc2]> < <[loc1]>:
                        - if <player.worldguard.test_flag[pvp]> = true || <player.location.in_region> = false:
                          - if <[entity]> != 0:
                            # Проверка на наличие эффектов, и установка нужного значения урона от атаки.
                            ### ТОЛЬКО СИЛА ###
                            - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = false:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].add[<[strenght_bonus].div[2]>].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].add[<[strenght_bonus]>].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                            ### ТОЛЬКО СЛАБОСТЬ ###
                            - if <player.has_effect[INCREASE_DAMAGE]> = false && <player.has_effect[WEAKNESS]> = true:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                            ### СИЛА И СЛАБОСТЬ ###
                            - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = true:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].add[<[strenght_bonus].div[2]>].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].add[<[strenght_bonus]>].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                            ### БЕЗ ЭФФЕКТОВ ###
                            - else:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].mul[1.5]> source:<player> cause:ENTITY_EXPLOSION
                            - if <[entity]> != 0:
                              - playsound <[entity]> sound:entity_player_attack_crit pitch:1 volume:1
                              - playeffect <[entity]> effect:crit quantity:20 offset:0.4
                            - if <player.gamemode.is[!=].to[creative]||false>:
                              - if <player.item_in_offhand.material.max_durability.sub[2]> >= <player.item_in_offhand.durability>:
                                - inventory adjust slot:offhand durability:<player.item_in_offhand.durability.add[2]>
                              - else:
                                - playsound <player.location> sound:entity_item_break pitch:1 volume:1
                                - playeffect at:<player.location.add[0,1.25,0]> effect:item_crack special_data:<player.item_in_offhand.script.name> quantity:8 offset:0.2 velocity:<player.location.direction.vector.div[10]>
                                - take slot:offhand
                        - else:
                          - playsound at:<context.entity.location> sound:entity_player_attack_weak volume:1 pitch:1
                      - else:
                        # Если при атаке игрок в воздухе, но не падает запускает часть скрипта отвечающую за обычную атаку.
                        - if <player.worldguard.test_flag[pvp]> = true || <player.location.in_region> = false:
                          - if <context.entity.is_living||0> = true:
                            # Проверка на наличие эффектов, и установка нужного значения урона от атаки.
                            ### ТОЛЬКО СИЛА ###
                            - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = false:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].add[<[strenght_bonus].div[2]>]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].add[<[strenght_bonus]>]> source:<player> cause:ENTITY_EXPLOSION
                            ### ТОЛЬКО СЛАБОСТЬ ###
                            - if <player.has_effect[INCREASE_DAMAGE]> = false && <player.has_effect[WEAKNESS]> = true:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1]> source:<player> cause:ENTITY_EXPLOSION
                            ### СИЛА И СЛАБОСТЬ ###
                            - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = true:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus].div[2]>]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus]>]> source:<player> cause:ENTITY_EXPLOSION
                            ### БЕЗ ЭФФЕКТОВ ###
                            - else:
                              - if <player.has_flag[strong_sechand]> = false:
                                - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                - hurt <context.entity> <[atk_dmg_penalty]> source:<player> cause:ENTITY_EXPLOSION
                              - else:
                                - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                - hurt <context.entity> <[atk_dmg]> source:<player> cause:ENTITY_EXPLOSION
          ### ОБЫЧНАЯ АТАКА ###
                    - else:
                      - if <player.worldguard.test_flag[pvp]> = true || <player.location.in_region> = false:
                        - if <[entity]> != 0:
                          # Проверка на наличие эффектов, и установка нужного значения урона от атаки.
                          ### ТОЛЬКО СИЛА ###
                          - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = false:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty].add[<[strenght_bonus].div[2]>]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg].add[<[strenght_bonus]>]> source:<player> cause:ENTITY_EXPLOSION
                          ### ТОЛЬКО СЛАБОСТЬ ###
                          - if <player.has_effect[INCREASE_DAMAGE]> = false && <player.has_effect[WEAKNESS]> = true:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1]> source:<player> cause:ENTITY_EXPLOSION
                          ### СИЛА И СЛАБОСТЬ ###
                          - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = true:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus].div[2]>]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus]>]> source:<player> cause:ENTITY_EXPLOSION
                          ### БЕЗ ЭФФЕКТОВ ###
                          - else:
                            - if <player.has_flag[strong_sechand]> = false:
                              - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                              - hurt <context.entity> <[atk_dmg_penalty]> source:<player> cause:ENTITY_EXPLOSION
                            - else:
                              - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                              - hurt <context.entity> <[atk_dmg]> source:<player> cause:ENTITY_EXPLOSION
                          - if <[weapon_type]> != axe:
                            - if <player.is_sprinting> = false:
                              - playeffect at:<player.location.forward.add[0,1.2,0]> effect:sweep_attack offset:0 visibility:2
                              - if <[entity]> != 0:
                                - playsound at:<[entity]> sound:entity_player_attack_sweep volume:1 pitch:1
                              - foreach <player.location.find.living_entities.within[1.5].exclude[<player>].exclude[<context.entity>]>:
                                - if <[value]> != null:
                                  # Проверка на наличие эффектов, и установка нужного значения урона от атаки.
                                  ### ТОЛЬКО СИЛА ###
                                  - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = false:
                                    - if <player.has_flag[strong_sechand]> = false:
                                      - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                      - hurt <[value]> <[atk_dmg_penalty].add[<[strenght_bonus].div[2]>].div[2.5]> source:<player> cause:ENTITY_EXPLOSION
                                    - else:
                                      - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                      - hurt <[value]> <[atk_dmg].add[<[strenght_bonus]>].div[2]> source:<player> cause:ENTITY_EXPLOSION
                                  ### ТОЛЬКО СЛАБОСТЬ ###
                                  - if <player.has_effect[INCREASE_DAMAGE]> = false && <player.has_effect[WEAKNESS]> = true:
                                    - if <player.has_flag[strong_sechand]> = false:
                                      - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                      - hurt <[value]> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1].div[2.5]> source:<player> cause:ENTITY_EXPLOSION
                                    - else:
                                      - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                      - hurt <[value]> <[atk_dmg].sub[<[weakness_bonus]>].mul[1].div[2]> source:<player> cause:ENTITY_EXPLOSION
                                  ### СИЛА И СЛАБОСТЬ ###
                                  - if <player.has_effect[INCREASE_DAMAGE]> = true && <player.has_effect[WEAKNESS]> = true:
                                    - if <player.has_flag[strong_sechand]> = false:
                                      - define atk_dmg_penalty <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount].div[1.5]>
                                      - hurt <[value]> <[atk_dmg_penalty].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus].div[2]>].div[2.5]> source:<player> cause:ENTITY_EXPLOSION
                                    - else:
                                      - define atk_dmg <script[<player.item_in_offhand.script.name>].data_key[data.stats.attribute_modifiers.generic_attack_damage.amount]>
                                      - hurt <[value]> <[atk_dmg].sub[<[weakness_bonus]>].mul[1].add[<[strenght_bonus]>].div[2]> source:<player> cause:ENTITY_EXPLOSION
                                  - if <player.gamemode.is[!=].to[creative]||false>:
                                    - if <player.item_in_offhand.material.max_durability.sub[2]> >= <player.item_in_offhand.durability>:
                                      - inventory adjust slot:offhand durability:<player.item_in_offhand.durability.add[1]>
                                    - else:
                                      - playsound <player.location> sound:entity_item_break pitch:1 volume:1
                                      - playeffect at:<player.location.add[0,1.25,0]> effect:item_crack special_data:<player.item_in_offhand.script.name> quantity:8 offset:0.2 velocity:<player.location.direction.vector.div[10]>
                                      - take slot:offhand
                          - else:
                            - playsound at:<context.entity.location> sound:entity_player_attack_strong volume:1 pitch:1
                      - else:
                        - playsound at:<context.entity.location> sound:entity_player_attack_weak volume:1 pitch:1
