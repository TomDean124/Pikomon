pico-8 cartridge // http://www.pico-8.com
version 42
__lua__


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
	if btn(⬇️)==true and pym==0 and pxm==0 and canmove(px,py) then
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
all_pokemon = {}
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

//create moves here 
moves={
water={name="squirt",power=30,type="water"}
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

function createpokemon(name,type, hp, atk, def,moves,sprite)

return {
name = name,
type = type,
max_hp = hp,
current_hp = hp,
atk = atk,
def = def,
moves = {moves},
hasfainted = false,
sprite = sprite
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

current_turn = 1

turn = {1,2}
spawned_pokemon = {}


function is_pokemon_spawned(poke) 
for p in all(spawned_pokemon) do 
if p.sprite == poke.sprite and p.x == poke.x and p.y == poke.y then 
return true 
end 
end 
return false 
end 
function spawn_pokemon() 
if btnp(4) then 
local poke = all_pokemon[index] 
if is_pokemon_spawned(poke) then 
return 
end 
add(spawned_pokemon, {sprite = poke.sprite, x = flr(px/8)*8, y = flr(py/8)*8}) 
end 
end



-->8
--gamemanager--

function _init()
	npcs()
	index = 1
	px=48
	py=32
	pxm=0
	pym=0
	pm=8
	ps=0
	pss=0
	anicycle=1
	psc=0
	psm=1
	pss=0//sprite state: for animations
	anicycle=1
	psc=0
	psm=1//timer for walking
	
	wall=0//this is for checking if a sprite has the ability to be walked through (the floor can be walked through, npcs, walls, windows, roofs, cannot).
	
	squirtle = createpokemon(
	"squirtle",
	pokemontype.water,
	100,
	75,
	100,
	moves.water,
	2 // sets the sprite for pokemon
)
	whale = createpokemon(
	"wale",
	pokemontype.water,
	100,
	75,
	100,
	moves.water,
	1
)

//place created pokemon into this list
all_pokemon={
squirtle,
whale
}
	
end

function _update()
 spawn_pokemon()
	moving()
	talking()
	if btnp(🅾️) then
	sfx(00)
	end
end

function _draw()
	cls()
	camera(px - 64, py - 64)
	map()
	spr(ps + 4 * pss, px, py)
		for p in all(spawned_pokemon) do
 spr(p.sprite, p.x, p.y)
 end
	camera(0, 0)
	draw_party_ui()
end

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

-->8
--generateui--


function generate_menu_ui()
local current = 0
if btnp(1) then current = (current-1) %# squirtle.moves end 
if btnp(5) then current = (current+1) %# squirtle.moves end
end

//the part ui contains the pokemon sprite and name and allows player to scroll through them
function draw_party_ui()
 if btnp(5) then
  play_sound(4,true)
  index = (index % #all_pokemon) + 1
end
 local buffer = 2 
 local pxsize = 4
 local spritesize = 8 
 local x = 0
 local y = 0


 local poke = all_pokemon[index]
 local textlength = pxsize * #poke.name
 local boxwidth = flr(textlength + buffer + spritesize)
 local boxheight = flr(spritesize + buffer)

 rectfill(x, y, x + boxwidth, y + boxheight, 2)
 rectfill(x+1, y+1, x+spritesize, y+spritesize, 7)
 print(poke.name, x + spritesize + 3, y + 3, 0)

	spr(poke.sprite, x + 1, y + 1) 
end

__gfx__
00000040040000000000004004000000000000400400000000000040040000000000004004000000000000400400000033333333333333333333336333333353
00444400004444000044440000444400004444000044440000444400004444000044440000444400004444000044440033633333333333333333653333333353
0ff1f400004f1ff00f1ff1f00f4444f00ff1f400004f1ff00f1ff1f00f4444f00ff1f400004f1ff00f1ff1f00f4444f033333333333333333333333333333333
00ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0036666666666666666666666666666663
0d167110011671d00d16711001d111100d167110011671d00d16711001d111100d167110011671d00d16711001d1111036666666666666666666666666666663
f0155d0ff0d5510ff0155d0ff0111d0ff0155fd00df5510ff015510ff0111d0001f55d0ff0d55f10f0155fd000111df036666666666666666666666666666663
005665000056650000566500005665000f566500005665f000166f00005665f00056f500005f650000f665000f56650036655555555555555555555555555663
0f70f700007f07f00f7007f00f7007f00070f700007f07000f7007000f7007000f700700007007f0007007f0007007f036555555555555555555555555555563
00055000000550000005500000055000000550000005500000055000000550000005500000055000000550000005500036555555555555555555555555555563
00555500005555000055550000555500005555000055550000555500005555000055550000555500005555000055550036655555555555555555555555555663
0ff15f5005f51ff0001ff1500a5555a00ff15f5005f51ff0001ff1500a5555a00ff15f5005f51ff0001ff1500a5555a036666666666666666666666666666663
00fffa5005afff000affffa000f55f0000fffa5005afff000affffa000f55f0000fffa5005afff000affffa000f55f0036666666666666666666666666666663
0d778510015877d00d778510017557d00d778510015877d00d778510017557d00d778510015877d00d778510017557d036666666666666666666666666666663
f01d770ff077d10ff01d770ff0d7510ff01d7fd0f077d10ff01d770ff0d7510ff01d770ff077d10ff01d770ff0d7510f36666666666666666666666666666663
01d71d1001d17d1001d7d110011d1d1001d71d1001d17d1001d7d110011d1d1001d71d1001d17d1001d7d110011d1d1036666666666666666666666666666663
011711d11d11711001171d100d111110011711d11d11711001171d100d111110011711d11d11711001171d100d11111036666666666666666666666666666663
33533353363333333333333333333663356333333333333636333335333363333366733633663333333333333944449336555555555555555555555555555663
33336663333566633363333636635663333353363353353333333333366333663666663336666663999999999944449933111111111111111111111111111133
333566633333666533353333566333356333663333633333336666333663666636666673366666634444444444444444331ddd1ddddddddddd1dddddd1ddd133
63333333533333333333333336636333333566335333333333666636355366663666666336666663444444444444444433177717777777777717777771777133
33333336336633363533333335333353533366533333335353556633333366553666666336666653444444444444444463177717777777777717777771777133
36663333336633533333333333336663366333333333363333335533635355533566666336666653444444444444444433177717777777777717777771777133
36663533335333333333353353356663366335333633333333533333333333333566666335555533994444999999999953177717555555557714444441777133
33333363333336333336333336333533333363333333533333333633353333633355555333333335394444933333333333177717588888857717477471777135
39444936394449355944493663944449353333333333333333333333333333333944449339444493394442963363353333177717588888857717477471777133
39444933394449633944493335944449633999999999933399993333333399993922449999424493594244939999999933177717588888857717477471777133
53944493944493333944493333944449339244444444493344449999999944443944444444444493394444932444442235177717588888857717477471777133
63944493944493333944496353944449394444442244249344444444444444443942444242444493392444934444244433177717528888857714444441777133
33944493944493333694449539444493394444224444449344444444444444443944424444244293394244934244444433177717588888857717777771777133
39444493944449333394449339444495394444444444449399994444444499993394244444444933694444934424442433177717588888857717777771777133
39444933394449533394449339444493394244999942449333339999999933333339999999999333394442959999999933177717588888857711111111777133
39444953594449366394449339444493394444933944429333333333333333333333333333333333394424966333356333311151555555555155555555111363
33533333333335333333333333338333333563333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
3353333333333533333383333332a833335556333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33353353353353333332a83333332333335556333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
53353353353353533333233332333333355555633333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
5333353333533353323333332a233833355555633333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
35333533335335332a23383332332a83355555533333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
353333333333353332332a8333333233333493333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
33333333333333333333323333333333333493333333333333333333333333330000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777776d05600000000000777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777775959d0056d056000d57d5675577777d100000000000000000000000000000000000000000000000000000000000000000000000000000000
d57d5675577777d119919d695959d005575515567d77515500000000000000000000000000000000000000000000000000000000000000000000000000000000
575515567d7751559849959619919d69656159977676675100000000000000000000000000000000000000000000000000000000000000000000000000000000
65615997767667519999599598499596719194d61561827500000000000000000000000000000000000000000000000000000000000000000000000000000000
719194d6156182755928898d999959951741477861d4f21600000000000000000000000000000000000000000000000000000000000000000000000000000000
1741477861d4f2165876d2765928898d657175e82d56595700000000000000000000000000000000000000000000000000000000000000000000000000000000
657175e82d565957077007705876d276517171925657656500000000000000000000000000000000000000000000000000000000000000000000000000000000
51717192565765650000000000000000d9141911d7677f7600000000000000000000000000000000000000000000000000000000000000000000000000000000
d9141911d7677f76000000000000000071884159f9ff9a9500000000000000000000000000000000000000000000000000000000000000000000000000000000
71884159f9ff9a950000000000000000776915679429142900000000000000000000000000000000000000000000000000000000000000000000000000000000
7769156794291429000000000000000077755d152818115800000000000000000000000000000000000000000000000000000000000000000000000000000000
77755d15281811580000000000000000777167565567617d00000000000000000000000000000000000000000000000000000000000000000000000000000000
777167565567617d0000000000000000777615167577761500000000000000000000000000000000000000000000000000000000000000000000000000000000
77761516757776150000000000000000777777651677777700000000000000000000000000000000000000000000000000000000000000000000000000000000
77777765167777770000000000000000777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888eeeeee888eeeeee888eeeeee888eeeeee888eeeeee888777777888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee88eee88ee888ee88ee888ee88ee8e8ee88ee888ee88ee8eeee88778887788888888888888888ff888ff888222222888222822888882282888888222888
888eeee8eee8eeeee8ee8eeeee8ee8eee8e8ee8eee8eeee8eee8eeee87777787788888e88888888888ff888ff888282282888222888888228882888888288888
888eeee8eee8eee888ee8eeee88ee8eee888ee8eee888ee8eee888ee8777778778888eee8888888888ff888ff888222222888888222888228882888822288888
888eeee8eee8eee8eeee8eeeee8ee8eeeee8ee8eeeee8ee8eee8e8ee87777787788888e88888888888ff888ff888822228888228222888882282888222288888
888eee888ee8eee888ee8eee888ee8eeeee8ee8eee888ee8eee888ee877777877888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee8eeeeeeee8eeeeeeee8eeeeeeee8eeeeeeee8eeeeeeee877777777888888888888888888888888888888888888888888888888888888888888888
16661111111111111171116616161666166616661661166611111cc1117111111717171711111166116116161666166616661611166611111666116616161666
116111111777111117111611161616161616161116161161111111c1111711111117177711111611161616161161161611611611161111111666161616161611
116111111111111117111611161616611661166116161161177711c1111711111171171711111666161616161161166111611611166111111616161616161661
116111111777111117111611161616161616161116161161111111c1111711111711177711111116166116161161161611611611161111111616161616661611
11611111111111111171116611661616161616661616116111111ccc117111111717171711111661116611661666161611611666166611711616166111611666
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661111111111111171116616161666166616661661166611111cc1117111111717171711111166116116161666166616661611166611111666116616161666
116111111777111117111611161616161616161116161161117111c1111711111117177711111611161616161161161611611611161111111666161616161611
116111111111111117111611161616611661166116161161177711c1111711111171171711111666161616161161166111611611166111111616161616161661
116111111777111117111611161616161616161116161161117111c1111711111711177711111116166116161161161611611611161111111616161616661611
11611111111111111171116611661616161616661616116111111ccc117111111717171711111661116611661666161611611666166611711616166111611666
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11711171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
17111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
17111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
17111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11711171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111188888111111111111111111111111111111111111111
111116661661166116161111111111111171166616611661166616161111111111111cc111711111171786668611161111111666116616161666166611661661
1111116116161616161611111777111117111161161616161611161611111171111111c111171111177786868611161111111616161616161611166616161616
1111116116161616116111111111111117111161161616161661116111111777111111c111171111171786668611161111111666161616611661161616161616
1111116116161616161611111777111117111161161616161611161611111171111111c111171111177786868611161111111611161616161611161616161616
111116661616166616161111111111111171166616161666166616161111111111111ccc11711111171786868666166616661611166116161666161616611616
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111711111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111771111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111777111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111777711111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111771111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111117111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661166166117711666166116611666161611771111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661616161617111161161616161611161611171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16161616161617111161161616161661116111171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16161616161617111161161616161611161611171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16161661161617711666161616661666161611771111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1666166617171bbb11bb1b1b1bbb1111166116661666166611111111111111111111111111111111111111111111111111111111111111111111111111111111
1116161111711b1b1b1b1b1b1b111111161616161666161111111111111111111111111111111111111111111111111111111111111111111111111111111111
1161166117771bbb1b1b1bb11bb11111161616661616166111111111111111111111111111111111111111111111111111111111111111111111111111111111
1611161111711b111b1b1b1b1b111111161616161616161111111111111111111111111111111111111111111111111111111111111111111111111111111111
1666166617171b111bb11b1b1bbb1171161616161616166611111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16161666161116661661116616661616111116661616166616661666166611111166166616661666166616661166166616661666117111111111111111111111
16161161161116111616161111611616117116161616161116111611161611711611161616161161116116111611116111161611111711111111111111111111
11611161161116611616161111611666177716611616166116611661166117771666166616611161116116611666116111611661111711111111111111111111
16161161161116111616161611611616117116161616161116111611161611711116161116161161116116111116116116111611111711111111111111111111
16161161166616661616166611611616111116661166161116111666161611111661161116161666116116661661166616661666117111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661666166616661666116616661666166611111666161616661666166616661171111111111111111111111111111111111111111111111111111111111111
16161616116111611611161111611116161111711616161616111611161116161117111111111111111111111111111111111111111111111111111111111111
16661661116111611661166611611161166117771661161616611661166116611117111111111111111111111111111111111111111111111111111111111111
16111616116111611611111611611611161111711616161616111611161116161117111111111111111111111111111111111111111111111111111111111111
16111616166611611666166116661666166611111666116616111611166616161171111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822882228882822282228888888888888888888888888888888888888888888882288222822282228882822282288222822288866688
82888828828282888888882888828828888282888888888888888888888888888888888888888888888888288282888288828828828288288282888288888888
82888828828282288888882888228828882282228888888888888888888888888888888888888888888888288282822288228828822288288222822288822288
82888828828282888888882888828828888288828888888888888888888888888888888888888888888888288282828888828828828288288882828888888888
82228222828282228888822282228288822282228888888888888888888888888888888888888888888882228222822282228288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0000000000000000000000000101010100000000000000000000000001010101000000000000000001010000010101010000000000000000000000000101010100000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
343b3b3b3b3b3b3b3b2a47474747474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a25214747252520473a470c0d0e0f4747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a47343b3b352525253a471c1d1e1f4747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a473a47473a4725443a472c2d2e2f4747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a203a44473a2347473a283c3d3e3f4747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a473a47473a4729473a25473a47474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
383b3925473a2547203a47473a47474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4744472347383b3b3b2b3b3b3944474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4747474747474747474747474747474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4747474747474747474747474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4747474747474747474747474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4747474747474747474747474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4747474747474747474747474747474700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001f050210501605000000000002305000000240502305015050120500d050000000d050000000d0500d050000000d050000001005000000000000000000000000000000000000160500d0500000000000
0009000000000340500000033050000000000000000000002f05000000000001b05000000000000000026050000002f05000000000000000039050000001f0501f050200501f0501f0501e050000000000000000
001000001805000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000e0500e0500e050150502c0502c0502c0501005028750217502825028250272502b0501f5501e5502765027650256503725035250332501d7501775017750212502025021750000002c6500000000000
__music__
00 06424344
00 41424344
00 41424344
00 60000300
00 41424344
00 60000020
00 30300136
00 611002d7
00 60100347
00 60000150
00 00000000
00 00000020
00 00000000
00 00000000
00 00000000
00 00000000
00 000002d0
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 000000f4
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000
00 00000000

