pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	npcs()
	px=48
	py=32//starting spots
	pxm=0
	pym=0//direction the player wants to go
	ps=0//player sprite
	pss=0//sprite state: for animations
	anicycle=1
	psc=0
	psm=1//timer for walking
	
	wall=0//this is for checking if a sprite has the ability to be walked through (the floor can be walked through, npcs, walls, windows, roofs, cannot).
	talkable=1
	
end

function _update()
	moving()
	talking()
	if btnp(🅾️) then
	sfx(00)
	end
end

function _draw()
	cls()
	map()
	spr(ps+4*pss, px, py)
	camera(px-64, py-64)
	
end


-->8
--movement & talking

--movement

function isfloor(floortype)
	tile=mget((px+pxm)/8,(py+pym)/8)
	hasflag=fget(tile,floortype)
	return hasflag
end

function canmove(x,y)
	return not isfloor(wall,px,py,pxm,pym)
end

function walkin()
	if psc==psm then
		if anicycle==4 then
				anicycle=1
		elseif anicycle==1 then
				pss=1
				anicycle=2
		elseif anicycle==3 then
				pss=2
				anicycle=4
		elseif anicycle==2 then
			anicycle=3
		end		
		psc=0
	elseif psc<psm then
		psc+=1
	end
end

function moving()
	if btn(⬅️)==true and pxm==0 and pym==0 then
		ps=0
		pxm-=8
		play_sound(1,true)
	end
	if btn(➡️)==true and pxm==0 and pym==0 then
		ps=1
		pxm+=8
		play_sound(1,true)
	end
	if btn(⬇️)==true and pym==0 and pxm==0 then
		ps=2
		pym+=8
		play_sound(1,true)
	end
	if btn(⬆️)==true and pym==0 and pxm==0 then
		ps=3
		pym-=8
		play_sound(1,true)
	end
	
	if (canmove(px, py)) then
		px=mid(0, px, 508)
		py=mid(0, py, 252)
	else
		sfx(06)
		pxm=0
		pym=0
	end
	
	if pym>0 then
		pym-=2
		py+=2
		walkin()
	end
	if pym<0 then
		pym+=2
		py-=2
		walkin()
	end
	if pxm>0 then
		pxm-=2
		px+=2
		walkin()
	end
	if pxm<0 then
		pxm+=2
		px-=2
		walkin()
	end
	if btn(⬆️)==false and btn(⬇️)==false and btn(⬅️)== false and btn(➡️)==false and pxm==0 and pym==0 then
		pss=0
	end
end




-->8
--npcs

npc={
	dad=0,
	persom=1,
	fighter=2}
function createnpc(npcx, npcy, npcd, sex)
	npctraits={
		npcx=npcx,
		npcy=npcy,
		npcd=npcd,
		sex=sex
	}
end

function npcs()

	npc={
	dad=0,
	man=1,
	woman=2,
	fightm=3,
	dad=0,
	man=1,
	woman=2,
	fightm=3,
	fightf=4
	}
end

function unpc()
for p in all(npc) do

end 
end

function talking()
	for n in all(npctraits) do
		if btnp(🅾️)==true then
			sfx(00)
			if px==npx-8 or px==npx+8 or py==npy-8 or py==npy+8 then
			
				
			end
		end
	end
end

-->8
--types & multipliers--

//add aditional types here into this enum list
pokemontype = {
    normal = 0,
    fire = 1,
    water = 2,
    grass = 3,
    electric = 4,
    ice = 5,
    fighting = 6,
    poison = 7,
    ground = 8,
    flying = 9,
    psychic = 10,
    bug = 11,
    rock = 12,
    ghost = 13,
    dragon = 14,
    dark = 15,
    steel = 16,
    fairy = 17
}

//use this to change the types effectiveness
type_effectiveness = {

// normal type multiplier
  [pokemontype.normal]={
  [pokemontype.fire] = 1, 
  [pokemontype.water] = 1,
  },
  
  //fire type multiplier
  [pokemontype.fire] = {
  [pokemontype.water] = 2,
  [pokemontype.normal] = 1,
  },
  
  //water type multiplier
  [pokemontype.water] = {
  [pokemontype.fire] = 0.5,
  [pokemontype.normal] = 1,
  },
  
}
function init()

//place created pokemon into this list
all_pokemon = {}
end 



function createpokemon(name, type, hp, atk, def)

return {
name = name,
type = type,
max_hp = hp,
current_hp = hp,
atk = atk,
def = def,
hasfainted = false
}

end

//call for all pokemon attacks
function attack(attacker,defender)
 local damage = max(1, attacker.atk - defemder.def)
	local multiplier = attack_multiplier(attacker.type,defender.type)
	local total_damage = damage*multiplier
 defender.current_hp = math.max(0, defender.current_hp-total_damage)
end

function attack_muliplier(atk_type,df_type)
local multiplier = 1

if type_effectiveness[atk_type] and type_effectiveness[atk_type][df_type] then  
multiplier = type_effectiveness[atk_type][df_type] 
end
return multiplier

end


-->8
--pokemon ai--

state={
idle,
fighting, 
switching
}

//checks if a pokemon is dead or not
function check_pokemon_health()
for i, p in ipairs(all_pokemon) do
		if p.current_hp <= 0 then
			p.hasfainted = true; 
		end
	end
end


-->8
--gamemanage
-->8
--sfx manager--

current_looping_sound = 0;

function play_sound(clip,loop)

if loop==false then
if current_looping_sound != clip then
sfx(clip,0)
current_looping_sound = clip
end

else
sfx(clip)
end
end

function play_music(clip,loop)
if loop==false then
if current_looping_sound != clip then
sfx(clip,0)
current_looping_sound = clip
end

else
sfx(clip)
end
end

__gfx__
00088000000880000008800000088000000880000008800000088000000880000008800000088000000880000008800066dd6d6d6ddddd66d6dd6d66555a5555
0088880000888800008888000088880000888800008888000088880000888800008888000088880000888800008888006dddddddddddddddddddddd6555a5555
0ff1ff0000ff1ff00f1ff1f00ff88ff00ff1ff0000ff1ff00f1ff1f00ff88ff00ff1ff0000ff1ff00f1ff1f00ff88ff0ddddd555d555555d555ddddd555a5555
00ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff006dd555555555555555555ddd55555555
0cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc0ddd555555555555555555dd65555a555
c0cccc0cc0cccc0cc0cccc0cc0cccc0cc0cccdd00ddccc0c0ddccc0c0dcccc0c0ddccc0cc0cccdd0c0cccdd0c0ccccd0dd55555555555555555555dd5555a555
00cccc0000cccc0000cccc0000cccc0001cccc0000cccc1000ccc11000cccc1000cc1c0000c1cc00011ccc0001cccc006d55555555555555555555d65555a555
011011000011011001100110011001100010110000110100011000000110000001100100001001100000011000000110dd55555555555555555555dd55555555
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd5555555555555555555dd655555555
099990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
0977f9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
097ffa9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006d55555555555555555555dd5555aaa5
009faa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555ddaaa55555
000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006dd5555555555555555555d655555555
6dddddd66dddddd66dddddd66dddddd60000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd66966666
ddd1dddddddd1dddd1ddddd11dddddd100000000000000000000000000000000000000000000000000000000000000006d55555555555555555555d669666666
d11ddaddddadd11ddd11d11ddaddddad0000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd66666669
dcddddaddaddddcddddcdcddddaddadd00000000000000000000000000000000000000000000000000000000000000006dd555555555555555555ddd66666966
dddddd1aa1dddddddddddddddd1aa1dd0000000000000000000000000000000000000000000000000000000000000000ddd555555555555555555dd666669666
11ddddaaaadddd11ddd111ddddaaaadd0000000000000000000000000000000000000000000000000000000000000000ddddd555d555555d555ddddd69666666
dd1ddd8aa8ddd1dddd1ddd1ddd8aa8dd00000000000000000000000000000000000000000000000000000000000000006dddddddddddddddddddddd696666696
6dddddaaaaddddd66dddddd66daaaad6000000000000000000000000000000000000000000000000000000000000000066d6dd6d6ddd6dd6d6d6dd6666666666
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066966644446666664aaafff44aaafff4
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000069666444444666664ffffff44cc4ccc4
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000666644f44f4466694ffffff44cc4ccc4
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066644ff44ff449664aaafff44cc4ccc4
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006644ffa44aff44664fffaaa44ccc4cc4
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000644faaf44faaf4464ffffff44ccc4cc4
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000044faffa44affaf444ffffff44ccc4cc4
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004fafaaf44faafaf44fffaaa44fffaaa4
77777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d57d5675577777d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
575515567d7751550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
65615997767667510000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
719194d6156182750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1741477861d4f2160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
657175e82d5659570000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
51717192565765650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d9141911d7677f760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
71884159f9ff9a950000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77691567942914290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77755d15281811580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777167565567617d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77761516757776150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777765167777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000030303030000000000000000000000000000000000000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2f2f2f2f2f2f2f2f3c3d2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f0c0d0d0d0d0d0d0d0e2f3c3e3e3d2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f1c1d1f1f1f1f1f1d1e2f3e3e3e3e2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f1c0f1d0f1d0f1d0f1e2f3e3f3f3e2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2c1d1f1f1f1f1f1f1e2f3e3e3e3e2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2c1d1d0f1d2d2d2e2f2f222f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2c1d0f1e2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f1c0f1d0d0d0d0e2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f0c1d0f1f1f1f1d1e2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f1c1d0f1f1f1f1d2e2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2c1d1d1d1d1d2e2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2c2d2d2d2e2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00060000020500005001050130501e05005050320503f0500e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010305000000000000136300c6200e610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000611002d71030610325103461037710396103451030410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000601003472030620396203752000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000600001553013530115301153010530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000002a05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000002053020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000000000000000000000001f050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000013050110501105012050120501205000000000001a05019050230501805013050180500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000000000000000000000000000000000000001b0500a05014050000000d0500b0500a050000000505000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000f4500f45000000000000f4500e4500e4500e4500e4500e4500e450114500d4500f4500d450124500f4500c4501245012450124500c4500a4500a450094500d4500945008450134500e450074500f450
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000034500000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010100b080500b050050500b05007050070500705007050060500605006050060500605005050050500505004050040500405004050050500405004050040500405004050040500405000000000000000013050
__music__
03 41424344

