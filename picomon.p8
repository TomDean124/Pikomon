pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--a not-ripoff of pokemon by leo, anton, and tom

function _init()
	
	inpc()
	
	px=0
	py=0
	pxm=0
	pym=0
	pm=8
	ps=0
	pss=0
	psc=0
	psm=4
	
end

function _update()
	moving()
end

function _draw()
	cls()
	map()
	spr(ps+4*pss, px, py)
	camera(px-64, py-64)
end
-->8
--movement & talking
function moving()
	if btn(⬅️)==true and pxm==0 and pym==0 then
		ps=0
		pxm-=8
	end
	if btn(➡️)==true and pxm==0 and pym==0 then
		ps=1
		pxm+=8
	end
	if btn(⬇️)==true and pym==0 and pxm==0 then
		ps=2
		pym+=8
	end
	if btn(⬆️)==true and pym==0 and pxm==0 then
		ps=3
		pym-=8
	end
	if pym>0 then
		pym-=2
		py+=2
		if psc==psm then
			if pss==2 then
				pss=0
			elseif pss==1 then
				pss=2
			elseif pss==0 then
				pss=1
			end
			psc=0
		elseif psc<psm then
			psc+=1
		end
	end
	if pym<0 then
		pym+=2
		py-=2
		if psc==psm then
			if pss==2 then
				pss=0
			elseif pss==1 then
				pss=2
			elseif pss==0 then
				pss=1
			end
			psc=0
		elseif psc<psm then
			psc+=1
		end
	end
	if pxm>0 then
		pxm-=2
		px+=2
		if psc==psm then
			if pss==2 then
				pss=0
			elseif pss==1 then
				pss=2
			elseif pss==0 then
				pss=1
			end
			psc=0
		elseif psc<psm then
			psc+=1
		end
	end
	if pxm<0 then
		pxm+=2
		px-=2
		if psc==psm then
			if pss==2 then
				pss=0
			elseif pss==1 then
				pss=2
			elseif pss==0 then
				pss=1
			end
			psc=0
		elseif psc<psm then
			psc+=1
		end
	end
end

function talking()
	for all in npc() do
	
	end
end
-->8
--npcs

function inpc()
	npc={}
end

function unpc()
	for p in all(npc) do
		
	end
end
__gfx__
00088000000880000008800000088000000880000008800000088000000880000008800000088000000880000008800066dd6d6d6ddddd66d6dd6d66555a5555
0088880000888800008888000088880000888800008888000088880000888800008888000088880000888800008888006dddddddddddddddddddddd6555a5555
0ff1ff0000ff1ff00f1ff1f00ff88ff00ff1ff0000ff1ff00f1ff1f00ff88ff00ff1ff0000ff1ff00f1ff1f00ff88ff0ddddd555d555555d555ddddd555a5555
00ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff006dd555555555555555555ddd55555555
0cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc00cccccc0ddd555555555555555555dd65555a555
c0cccc0cc0cccc0cc0cccc0cc0cccc0cc0cccdd00ddccc0c0ddccc0c0dcccc0c0ddccc0cc0cccdd0c0cccdd0c0ccccd0dd55555555555555555555dd5555a555
00cccc0000cccc0000cccc0000cccc0001cccc0000cccc1000ccc10000cccc1000cc1c0000c1cc00001ccc0001cccc006d55555555555555555555d65555a555
011011000011011001100110011001100010110000110100011001000110000001100100001001100010011000000110dd55555555555555555555dd55555555
777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000dd5555555555555555555dd655555555
777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
d57d5675577777d100000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
575515567d775155000000000000000000000000000000000000000000000000000000000000000000000000000000006d55555555555555555555dd5555aaa5
656159977676675100000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555ddaaa55555
719194d61561827500000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
1741477861d4f21600000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd55555555
657175e82d565957000000000000000000000000000000000000000000000000000000000000000000000000000000006dd5555555555555555555d655555555
517171925657656500000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd66966666
d9141911d7677f76000000000000000000000000000000000000000000000000000000000000000000000000000000006d55555555555555555555d669666666
71884159f9ff9a9500000000000000000000000000000000000000000000000000000000000000000000000000000000dd55555555555555555555dd66666669
7769156794291429000000000000000000000000000000000000000000000000000000000000000000000000000000006dd555555555555555555ddd66666966
77755d152818115800000000000000000000000000000000000000000000000000000000000000000000000000000000ddd555555555555555555dd666669666
777167565567617d00000000000000000000000000000000000000000000000000000000000000000000000000000000ddddd555d555555d555ddddd69666666
7776151675777615000000000000000000000000000000000000000000000000000000000000000000000000000000006dddddddddddddddddddddd696666696
77777765167777770000000000000000000000000000000000000000000000000000000000000000000000000000000066d6dd6d6ddd6dd6d6d6dd6666666666
__map__
2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f0c0e2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f1c1d0d0d0d0d0d0e2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f1c1d1e2f2f2f2f1e2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2c1d1d0d0e2f0c2e2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2c1d1d1d0d2e2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2c1d1d1e2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f1c1d1d0d0d0d0e2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f0c1d1d1d1d1d1d1e2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f1c1d1d1d1d1d1d2e2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2c1d1d1d1d1d2e2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2c2d2d2d2e2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
