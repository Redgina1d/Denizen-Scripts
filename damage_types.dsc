resistances:
  type: world
  debug: false
  events:
    on entity damaged:
	  # custom stats resistances
	  - if <context.cause> = ENTITY_ATTACK || <context.cause> = ENTITY_EXPLOSION || <context.cause> = ENTITY_SWEEP_ATTACK || <context.cause> = PROJECTILE:
	    - define res_name <element[generic_res_physical]>
		- define d_indicator "<&8>🗡<&7>"
		- define mob_res <element[physical_res_mob]>
		- define indicator_name <element[physical]>
	  - if <context.cause> = FIRE || <context.cause> = LAVA || <context.cause> = FIRE_TICK || <context.cause> = HOT_FLOOR:
	    - define res_name <element[generic_res_fire]>
		- define d_indicator "<&c>🔥<&7>"
		- define mob_res <element[fire_res_mob]>
		- define indicator_name <element[fire]>
	  - if <context.cause> = FREEZE:
	    - define res_name <element[generic_res_cold]>
		- define d_indicator "<&9>❄<&7>"
		- define mob_res <element[cold_res_mob]>
		- define indicator_name <element[cold]>
	  - if <context.cause> = POISON || <context.cause> = WITHER:
	    - define res_name <element[generic_res_poison]>
		- define d_indicator "<&2>@<&7>"
		- define mob_res <element[poison_res_mob]>
		- define indicator_name <element[poison]>
	  - if <context.cause> = LIGHTNING:
	    - define res_name <element[generic_res_lightning]>
		- define d_indicator "<&e><&l>⚡<&7>"
		- define mob_res <element[lightning_res_mob]>
		- define indicator_name <element[lightning]>
	  - if <context.cause> = MAGIC:
	    - define res_name <element[generic_res_magic]>
		- define d_indicator "<&f>✦<&7>"
		- define mob_res <element[magic_res_mob]>
		- define indicator_name <element[magic]>
	  - if <[res_name]||null> = null:
	    - stop
      - if <context.entity.has_flag[custom_stats_map]> = true:
        - if <context.entity.flag[custom_stats_map].contains[generic_res_all]> = true:
		  - if <context.entity.flag[custom_stats_map].get[generic_res_all]> < 70:
            - define alldef <context.entity.flag[custom_stats_map].get[generic_res_all].mul[2]>
		  - else if <context.entity.flag[custom_stats_map].get[<[res_name]>]> > 69:
		    - define alldef <element[30]>
		- else:
		  - define alldef <element[0]>
        - if <context.entity.flag[custom_stats_map].contains[<[res_name]>]> = true:
          - if <context.entity.flag[custom_stats_map].get[<[res_name]>]> < 70:
            - define damage <element[100].sub[<context.entity.flag[custom_stats_map].get[<[res_name]>].mul[2]>].sub[<[alldef]>]>
	      - else if <context.entity.flag[custom_stats_map].get[<[res_name]>]> > 69:
		    - define damage <element[30]>
		- if <[damage]||null> = null:
		  - define damage <element[100].sub[<[alldef]>]>
	    - if <[damage]||null> != null:
		  - define dmgdis <context.damage.div[100].mul[<[damage]>]>
          - determine passively <[dmgdis]>
	  # Mob's resistances
      - if <context.entity.has_flag[<[mob_res]>]> = true:
        - if <context.entity.flag[<[mob_res]>]> > 0:
          - if <context.entity.flag[<[mob_res]>]> < 100:
            - define damage <element[100].sub[<context.entity.flag[<[mob_res]>]>]>
            - define dmgdis <context.damage.div[100].mul[<[damage]>]>
			- determine passively <[dmgdis]>
          - else:
            - determine passively cancelled
	  - if <[d_indicator]||null> != null && <[indicator_name]||null> != null:
	    - if <context.entity.has_flag[<[indicator_name]>_cd]> = true:
		  - stop
		- flag <context.entity> <[indicator_name]>_cd expire:0.5s
	    - define dmgdis <context.damage.round_to[1]>
	    - fakespawn <entity[text_display].with[text=<[d_indicator]><[dmgdis]>;scale=1,1,1;pivot=center;background_color=transparent]> <context.entity.location.above[1].center> duration:1.4s save:indicator players:<context.entity.location.find_entities[player].within[20]>
        - define display <entry[indicator].faked_entity||null>
	    - if <[display]> = null:
		  - stop
        - adjust <[display]> interpolation_start:0
        - adjust <[display]> interpolation_duration:25t
        - adjust <[display]> translation:0,1,0
types_of_damage:
  type: world
  debug: false
  events:
    on entity damages entity:
      - if <context.damager.has_flag[custom_stats_map]> = true:
        - if <context.damager.flag[custom_stats_map].get[generic_poison_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <context.damager.flag[custom_stats_map].get[generic_poison_damage]||0> cause:POISON
        - if <context.damager.flag[custom_stats_map].get[generic_magic_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <context.damager.flag[custom_stats_map].get[generic_magic_damage]||0> cause:MAGIC source:<context.damager>
        - if <context.damager.flag[custom_stats_map].get[generic_fire_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <context.damager.flag[custom_stats_map].get[generic_fire_damage]||0> cause:FIRE
        - if <context.damager.flag[custom_stats_map].get[generic_cold_damage]||0> != 0:
          - wait 1t
          - hurt <context.entity||0> <context.damager.flag[custom_stats_map].get[generic_cold_damage]||0> cause:FREEZE
        - if <context.damager.flag[custom_stats_map].get[generic_lightning_damage]||0> != 0:
          - adjust <context.entity> no_damage_duration:1t
          - hurt <context.entity||0> <context.damager.flag[custom_stats_map].get[generic_lightning_damage]||0> cause:CUSTOM
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
    on entity damaged by FIRE|FIRE_TICK|LAVA|HOT_FLOOR:
      - if <context.damage> > 0:
        - if <context.entity.has_flag[fireparticlecd]> = false:
          - flag <context.entity> fireparticlecd expire:0.7s
          - playeffect <context.entity.location||0> effect:FLAME quantity:8 offset:0.3 visibility:50
          - playsound sound:BLOCK_FIRE_AMBIENT pitch:2 volume:0.5 <context.entity.location||0>
          - playsound sound:BLOCK_FIRE_EXTINGUISH pitch:1 volume:0.05 <context.entity.location||0>
### COLD PARTICLES ###
    on entity damaged by FREEZE:
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
immunity_frames:
  type: world
  debug: false
  events:
    on entity damaged:
      - if <context.cause> != ENTITY_EXPLOSION:
        - if <context.cause> != ENTITY_ATTACK:
          - if <context.cause> != FREEZE:
            - if <context.cause> != CUSTOM:
              - if <context.cause> != FIRE:
                - if <context.cause> != POISON:
                  - if !<context.entity.has_flag[immun_frame_<context.cause>]>:
                    - flag <context.entity> immun_frame_<context.cause> expire:0.7s
                  - else:
                    - determine passively cancelled
    on player joins:
      - adjust <player> max_no_damage_duration:1t
    on entity added to world:
      - adjust <context.entity> max_no_damage_duration:1t