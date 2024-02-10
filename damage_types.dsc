## Damage types and Resistances Mechanic
## By: Rёdginald

resistances:
  type: world
  debug: false
  events:
### PHYSICAL ###
    on entity damaged by ENTITY_ATTACK:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_physical_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_physical_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_physical_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_physical_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[physdisplaycd]> = false:
            - flag <context.entity> physdisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[physical_res_mob]>:
          - if <context.entity.flag[physical_res_mob]||0> != 0:
            - if <context.entity.flag[physical_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[physical_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled
    on entity damaged by ENTITY_EXPLOSION:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_physical_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_physical_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_physical_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_physical_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[physdisplaycd]> = false:
            - flag <context.entity> physdisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[physical_res_mob]>:
          - if <context.entity.flag[physical_res_mob]||0> != 0:
            - if <context.entity.flag[physical_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[physical_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled
    on entity damaged by ENTITY_SWEEP_ATTACK:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_physical_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_physical_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_physical_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_physical_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[physdisplaycd]> = false:
            - flag <context.entity> physdisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[physical_res_mob]>:
          - if <context.entity.flag[physical_res_mob]||0> != 0:
            - if <context.entity.flag[physical_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[physical_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[physdisplaycd]> = false:
                - flag <context.entity> physdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&8>🗡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled

### FIRE ###
    on entity damaged by FIRE:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_fire_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_fire_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[firedisplaycd]> = false:
            - flag <context.entity> firedisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[fire_res_mob]>:
          - if <context.entity.flag[fire_res_mob]||0> != 0:
            - if <context.entity.flag[fire_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[fire_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled
    on entity damaged by FIRE_TICK:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_fire_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_fire_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[firedisplaycd]> = false:
            - flag <context.entity> firedisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[fire_res_mob]>:
          - if <context.entity.flag[fire_res_mob]||0> != 0:
            - if <context.entity.flag[fire_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[fire_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled
    on entity damaged by HOT_FLOOR:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_fire_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_fire_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[firedisplaycd]> = false:
            - flag <context.entity> firedisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[fire_res_mob]>:
          - if <context.entity.flag[fire_res_mob]||0> != 0:
            - if <context.entity.flag[fire_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[fire_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled
    on entity damaged by LAVA:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_fire_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_fire_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_fire_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[firedisplaycd]> = false:
            - flag <context.entity> firedisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[fire_res_mob]>:
          - if <context.entity.flag[fire_res_mob]||0> != 0:
            - if <context.entity.flag[fire_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[fire_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[firedisplaycd]> = false:
                - flag <context.entity> firedisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&c>🔥<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled
### ICE ###
    on entity damaged by DRYOUT:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_cold_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_cold_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_cold_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[colddisplaycd]> = false:
                - flag <context.entity> colddisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&9>❄<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[colddisplaycd]> = false:
                - flag <context.entity> colddisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&9>❄<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_cold_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[colddisplaycd]> = false:
                - flag <context.entity> colddisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&9>❄<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[colddisplaycd]> = false:
                - flag <context.entity> colddisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&9>❄<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[colddisplaycd]> = false:
            - flag <context.entity> colddisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&9>❄<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[cold_res_mob]>:
          - if <context.entity.flag[cold_res_mob]||0> != 0:
            - if <context.entity.flag[cold_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[cold_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[colddisplaycd]> = false:
                - flag <context.entity> colddisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&9>❄<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled

### POISON ###
    on entity damaged by POISON:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_poison_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_poison_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_poison_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[poisndisplaycd]> = false:
                - flag <context.entity> poisndisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&2>@<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[poisndisplaycd]> = false:
                - flag <context.entity> poisndisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&2>@<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_poison_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[poisndisplaycd]> = false:
                - flag <context.entity> poisndisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&2>@<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[poisndisplaycd]> = false:
                - flag <context.entity> poisndisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&2>@<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[poisndisplaycd]> = false:
            - flag <context.entity> poisndisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&2>@<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[poison_res_mob]>:
          - if <context.entity.flag[poison_res_mob]||0> != 0:
            - if <context.entity.flag[poison_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[poison_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[poisndisplaycd]> = false:
                - flag <context.entity> poisndisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&2>@<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled

### LIGHTNING ###
    on entity damaged by CUSTOM:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_lightning_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_lightning_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_lightning_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[lightdisplaycd]> = false:
                - flag <context.entity> lightdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&e><&l>⚡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[lightdisplaycd]> = false:
                - flag <context.entity> lightdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&e><&l>⚡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_lightning_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[lightdisplaycd]> = false:
                - flag <context.entity> lightdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&e><&l>⚡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[lightdisplaycd]> = false:
                - flag <context.entity> lightdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&e><&l>⚡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[lightdisplaycd]> = false:
            - flag <context.entity> lightdisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&e><&l>⚡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[lightning_res_mob]>:
          - if <context.entity.flag[lightning_res_mob]||0> != 0:
            - if <context.entity.flag[lightning_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[lightning_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[lightdisplaycd]> = false:
                - flag <context.entity> lightdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&e><&l>⚡<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled

### MAGIC ###
    on entity damaged by MAGIC:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[generic_magic_res]||0> != 0:
          - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> = 0:
            - if <context.entity.flag[custom_stats_map].get[generic_magic_res]> < 70:
              - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_magic_res].mul[2]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[mgcdisplaycd]> = false:
                - flag <context.entity> mgcdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&f>✦<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[mgcdisplaycd]> = false:
                - flag <context.entity> mgcdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&f>✦<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

          - else:
            - define currentdef <context.entity.flag[custom_stats_map].get[generic_magic_res].mul[2]>
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
            - define finalres <element[<[currentdef].add[<[alldef]>]>]>
            - if <[finalres]> < 70:
              - define damage <element[100].sub[<[finalres]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[mgcdisplaycd]> = false:
                - flag <context.entity> mgcdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&f>✦<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively <context.damage.div[100].mul[30]>
              - define dmgdis <context.damage.div[100].mul[30]>
              - if <context.entity.has_flag[mgcdisplaycd]> = false:
                - flag <context.entity> mgcdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&f>✦<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0

        - else:
          - wait 1t
          - define dmgdis <context.damage>
          - if <context.entity.has_flag[mgcdisplaycd]> = false:
            - flag <context.entity> mgcdisplaycd expire:0.7s
            - fakespawn <entity[text_display].with[text=<&f>✦<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
            - define display <entry[indicator].faked_entity>
            - adjust <[display]> interpolation_start:0
            - adjust <[display]> interpolation_duration:25t
            - adjust <[display]> translation:0,1,0

      - else:
        - if <context.entity.has_flag[magic_res_mob]>:
          - if <context.entity.flag[magic_res_mob]||0> != 0:
            - if <context.entity.flag[magic_res_mob]> < 100:
              - define damage <element[100].sub[<context.entity.flag[magic_res_mob]>]>
              - determine passively <context.damage.div[100].mul[<[damage]>]>
              - define dmgdis <context.damage.div[100].mul[<[damage]>]>
              - if <context.entity.has_flag[mgcdisplaycd]> = false:
                - flag <context.entity> mgcdisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&f>✦<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
            - else:
              - determine passively cancelled

##### ALLRES #####
    on entity damaged:
      - if <context.cause> != MAGIC && <context.cause> != CUSTOM && <context.cause> != POISON && <context.cause> != DRYOUT && <context.cause> != FIRE:
        - if <context.cause> != DRAGON_BREATH && <context.cause> != ENTITY_ATTACK && <context.cause> != LAVA && <context.cause> != HOT_FLOOR:
          - if <context.cause> != ENTITY_EXPLOSION && <context.cause> != ENTITY_SWEEP_ATTACK && <context.cause> != FIRE_TICK:
            - if <context.entity.has_flag[custom_stats_map]>:
              - if <context.entity.flag[custom_stats_map].get[generic_res_all]||0> != 0:
                - if <context.entity.flag[custom_stats_map].get[generic_res_all]> < 70:
                  - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>]>
                  - determine passively <context.damage.div[100].mul[<[damage]>]>
                  - define dmgdis <context.damage.div[100].mul[<[damage]>]>
                  - if <context.entity.has_flag[alldisplaycd]> = false:
                    - flag <context.entity> alldisplaycd expire:0.7s
                    - fakespawn <entity[text_display].with[text=<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                    - define display <entry[indicator].faked_entity>
                    - adjust <[display]> interpolation_start:0
                    - adjust <[display]> interpolation_duration:25t
                    - adjust <[display]> translation:0,1,0
                - else:
                  - determine passively <context.damage.div[100].mul[30]>
                  - define dmgdis <context.damage.div[100].mul[30]>
                  - if <context.entity.has_flag[alldisplaycd]> = false:
                    - flag <context.entity> alldisplaycd expire:0.7s
                    - fakespawn <entity[text_display].with[text=<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                    - define display <entry[indicator].faked_entity>
                    - adjust <[display]> interpolation_start:0
                    - adjust <[display]> interpolation_duration:25t
                    - adjust <[display]> translation:0,1,0
            - if <context.entity.has_flag[allres_mob]>:
              - if <context.entity.flag[allres_mob]||0> != 0:
                - if <context.entity.flag[allres_mob]> < 100:
                  - define damage <element[100].sub[<context.entity.flag[allres_mob]>]>
                  - determine passively <context.damage.div[100].mul[<[damage]>]>
                  - define dmgdis <context.damage.div[100].mul[<[damage]>]>
                  - if <context.entity.has_flag[alldisplaycd]> = false:
                    - flag <context.entity> alldisplaycd expire:0.7s
                    - fakespawn <entity[text_display].with[text=<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                    - define display <entry[indicator].faked_entity>
                    - adjust <[display]> interpolation_start:0
                    - adjust <[display]> interpolation_duration:25t
                    - adjust <[display]> translation:0,1,0
                - else:
                  - determine passively cancelled
            - else:
              - wait 1t
              - define dmgdis <context.damage>
              - if <context.entity.has_flag[alldisplaycd]> = false:
                - flag <context.entity> alldisplaycd expire:0.7s
                - fakespawn <entity[text_display].with[text=<&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
                - define display <entry[indicator].faked_entity>
                - adjust <[display]> interpolation_start:0
                - adjust <[display]> interpolation_duration:25t
                - adjust <[display]> translation:0,1,0
# True damage
    on entity damaged by DRAGON_BREATH:
      - wait 1t
      - define dmgdis <context.damage>
      - if <context.entity.has_flag[truedisplaycd]> = false:
        - flag <context.entity> truedisplaycd expire:0.7s
    ## ψ  Ψ ☽
        - fakespawn <entity[text_display].with[text=<element[☽].color[#FF0000]><&7><[dmgdis]>;scale=0.4,0.4,0.4;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator
        - define display <entry[indicator].faked_entity>
        - adjust <[display]> interpolation_start:0
        - adjust <[display]> interpolation_duration:25t
        - adjust <[display]> translation:0,1,0



types_of_damage:
  type: world
  debug: false
  events:
    on player damages entity:
      - adjust <context.entity> max_no_damage_duration:1t
      - if <player.has_flag[custom_stats_map]>:
        - if <player.flag[custom_stats_map].get[generic_poison_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[generic_poison_damage]||0> cause:POISON
        - if <player.flag[custom_stats_map].get[generic_magic_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[generic_magic_damage]||0> cause:MAGIC source:<context.damager>
        - if <player.flag[custom_stats_map].get[generic_fire_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[generic_fire_damage]||0> cause:FIRE
        - if <player.flag[custom_stats_map].get[generic_cold_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[generic_cold_damage]||0> cause:FREEZE
        - if <player.flag[custom_stats_map].get[generic_lightning_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[generic_lightning_damage]||0> cause:CUSTOM
        - if <player.flag[custom_stats_map].get[generic_pure_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[generic_pure_damage]||0> cause:DRAGON_BREATH source:<player>
      - wait 1t
      - adjust <context.entity> max_no_damage_duration:1s
### POISON PARTICLES ###
    on entity damaged by POISON:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[poisonparticlecd]> = false:
          - flag <context.entity> poisonparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:REDSTONE quantity:8 special_data:1|<color[#40853b].hex> offset:0.3 visibility:50
          - playsound sound:PARTICLE_SOUL_ESCAPE pitch:1 volume:1.2 <context.entity.location||0>
### MAGIC PARTICLES ###
    on entity damaged by MAGIC:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[magicparticlecd]> = false:
          - flag <context.entity> magicparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:SPELL_INSTANT quantity:8 offset:0.3 visibility:50
          - playsound sound:BLOCK_AMETHYST_BLOCK_CHIME pitch:1 volume:0. <context.entity.location||0>
### FIRE PARTICLES ###
    on entity damaged by FIRE:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[fireparticlecd]> = false:
          - flag <context.entity> fireparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
          - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
          - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
    on entity damaged by FIRE_TICK:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[fireparticlecd]> = false:
          - flag <context.entity> fireparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
          - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
          - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
    on entity damaged by HOT_FLOOR:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[fireparticlecd]> = false:
          - flag <context.entity> fireparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
          - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
          - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
    on entity damaged by LAVA:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[fireparticlecd]> = false:
          - flag <context.entity> fireparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
          - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
          - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
### COLD PARTICLES ###
    on entity damaged by DRYOUT:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[coldparticlecd]> = false:
          - flag <context.entity> coldparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:REDSTONE quantity:8 special_data:1|<color[#98d5e3].hex> offset:0.3 visibility:50
          - playsound sound:ENTITY_PLAYER_HURT_FREEZE pitch:1 volume:0.1 <context.entity.location||0>
### LIGHTNING PARTICLES ###
    on entity damaged by CUSTOM:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[lightparticlecd]> = false:
          - flag <context.entity> lightparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:ELECTRIC_SPARK quantity:8 offset:0.3 visibility:50
          - playsound sound:ELECTRIC_DAMAGE pitch:1 volume:0.05 <context.entity.location||0> custom


prevent_fastkill_lava:
  type: world
  debug: false
  events:
    on entity damaged by LAVA:
      - if <context.entity.has_flag[lavadmg_cd]> = true:
        - determine passively cancelled
      - else:
        - flag <context.entity> lavadmg_cd expire:0.7s

prevent_fastkill_void:
  type: world
  debug: false
  events:
    on entity damaged by void:
      - if <context.entity.has_flag[voiddmg_cd]> = true:
        - determine passively cancelled
      - else:
        - flag <context.entity> voiddmg_cd expire:1s

prevent_berserker_attack:
  type: world
  debug: false
  events:
    on player damages entity:
      - if <player.attack_cooldown_percent> < 70:
        - determine passively cancelled