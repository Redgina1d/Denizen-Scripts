
resistances:
  type: world
  debug: false
  events:
### PHYSICAL ###
    on entity damaged by ENTITY_ATTACK:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[physical_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[physical_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
    on entity damaged by ENTITY_EXPLOSION:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[physical_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[physical_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
    on entity damaged by ENTITY_SWEEP_ATTACK:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[physical_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[physical_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
    on entity damaged by PROJECTILE:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[physical_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[physical_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
### FIRE ###
    on entity damaged by FIRE:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[fire_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[fire_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
    on entity damaged by FIRE_TICK:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[fire_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[fire_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
    on entity damaged by HOT_FLOOR:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[fire_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[fire_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
    on entity damaged by LAVA:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[fire_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[fire_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
### ICE ###
    on entity damaged by FREEZE:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[cold_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[cold_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
### POISON ###
    on entity damaged by POISON:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[poison_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[poison_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
### LIGHTNING ###
    on entity damaged by CUSTOM:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[lightning_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[lightning_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
### MAGIC ###
    on entity damaged by MAGIC:
      - if <context.entity.has_flag[custom_stats_map]>:
        - if <context.entity.flag[custom_stats_map].get[magic_res]> < 90:
          - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[magic_res].mul[2]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>
        - else:
          - define damage <element[100].sub[<element[90]>]>
          - determine passively <context.damage.mul[0].add[<[damage]>]>

types_of_damage:
  type: world
  debug: false
  events:
    on player damages entity:
      - if <player.has_flag[custom_stats_map]>:
        - if <player.flag[custom_stats_map].get[poison_damage]||0> != 0:
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[poison_damage]||0> cause:POISON
        - if <player.flag[custom_stats_map].get[magic_damage]||0> != 0:
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[magic_damage]||0> cause:MAGIC source:<context.damager>
        - if <player.flag[custom_stats_map].get[fire_damage]||0> != 0:
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[fire_damage]||0> cause:FIRE
        - if <player.flag[custom_stats_map].get[cold_damage]||0> != 0:
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[cold_damage]||0> cause:FREEZE
        - if <player.flag[custom_stats_map].get[lightning_damage]||0> != 0:
          - hurt <context.entity||0> <player.flag[custom_stats_map].get[lightning_damage]||0> cause:CUSTOM
### POISON PARTICLES ###
    on entity damaged by POISON:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:REDSTONE quantity:8 special_data:1|<color[#40853b].hex> offset:0.3 visibility:50
        - playsound sound:PARTICLE_SOUL_ESCAPE pitch:1 volume:1.2 <context.entity.location||0>
### MAGIC PARTICLES ###
    on entity damaged by MAGIC:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:SPELL_INSTANT quantity:8 offset:0.3 visibility:50
        - playsound sound:BLOCK_AMETHYST_BLOCK_CHIME pitch:1 volume:0. <context.entity.location||0>
### FIRE PARTICLES ###
    on entity damaged by FIRE:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
        - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
        - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
    on entity damaged by FIRE_TICK:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
        - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
        - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
    on entity damaged by HOT_FLOOR:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
        - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
        - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
    on entity damaged by LAVA:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
        - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
        - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
### COLD PARTICLES ###
    on entity damaged by FREEZE:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:REDSTONE quantity:8 special_data:1|<color[#98d5e3].hex> offset:0.3 visibility:50
        - playsound sound:ENTITY_PLAYER_HURT_FREEZE pitch:1 volume:0.1 <context.entity.location||0>
### LIGHTNING PARTICLES ###
    on entity damaged by CUSTOM:
      - if <context.damage> > 0:
        - playeffect <context.entity.location||0> effect:ELECTRIC_SPARK quantity:8 offset:0.3 visibility:50
        - playsound sound:ELECTRIC_DAMAGE pitch:1 volume:0.05 <context.entity.location||0> custom