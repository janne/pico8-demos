pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
-- 15 puzzle

scrambling=0
selected=0
done=true
empty_tile={label={},bg=0}
tiles={
	{label={1},bg=1,fg=12},
	{label={2},bg=2,fg=14},
	{label={3},bg=3,fg=11},
	{label={4},bg=4,fg=15},
	{label={5},bg=5,fg=7},
	{label={6},bg=6,fg=5},
	{label={7},bg=7,fg=5},
	{label={8},bg=8,fg=15},
	{label={9},bg=9,fg=4},
	{label={1,0},bg=10,fg=4},
	{label={1,1},bg=11,fg=3},
	{label={1,2},bg=12,fg=1},
	{label={1,3},bg=13,fg=6},
	{label={1,4},bg=14,fg=8},
	{label={1,5},bg=15,fg=4},
	empty_tile,
}

function index_to_colrow(i)
	local col=i%4
	local row=flr(i/4)
	return col,row
end

function index_to_coords(i)
	local col,row=index_to_colrow(i)
	local x=col*24+16
	local y=row*24+16
	return x,y
end

function find_empty()
	for i,tile in pairs(tiles) do
		if (#tile.label==0) return i-1
	end
end

function move_col(empty,selected)
	local temp1={}
	for i,tile in pairs(tiles) do
		if(empty!=i-1) add(temp1,tile)
	end
	local temp2={}
	for i,tile in pairs(temp1) do
		if(selected==i-1) add(temp2,empty_tile)
		add(temp2,tile)
	end
	-- add to last pos
	if(selected==#temp1) add(temp2,empty_tile)
	tiles=temp2
end

function move_row(empty,selected)
	local temp={}
	local col,fr=index_to_colrow(empty)
	local _,tr=index_to_colrow(selected)
	local upwards = empty < selected
	if upwards then
		local move=empty
		for i,tile in pairs(tiles) do
			if selected==i-1 then
				add(temp,empty_tile)
			elseif move==i-1 then
				add(temp,tiles[i+4])
				move+=4
			else
				add(temp,tile)
			end
		end
	else
		local move=selected
		local move_tile=empty_tile
		for i,tile in pairs(tiles) do
			if move==i-1 and empty>=i-1 then
				add(temp,move_tile)
				move_tile=tile
				move+=4
			else
				add(temp,tile)
			end
		end
	end
	tiles=temp
end

function shift(selected)
	local empty=find_empty()
	
	-- empty tile
	if (empty==selected)	return

	local sc,sr=index_to_colrow(selected)
	local ec,er=index_to_colrow(empty)

	-- different row and col
	if (sc!=ec and sr!=er) return
	
	if sr==er then
		move_col(empty,selected)
	end
	
	if sc==ec then
		move_row(empty,selected)
	end
end

function scramble()
	scrambling-=1
	local c,r=index_to_colrow(find_empty())
	if rnd(1)<.5 then
		shift(flr(rnd(4))*4+c)
	else
		shift(r*4+flr(rnd(4)))
	end
end

function check_finish()
	for i=1,15 do
		if i<10 then
			if (tiles[i].label[1]!=i) return
		else
			if (tiles[i].label[1]!=1) return
			if (tiles[i].label[2]!=i-10) return
		end
	end
	sfx(0)
end

function _update()
	if (btnp(⬅️)) selected=(selected-1)%16
	if (btnp(➡️)) selected=(selected+1)%16
	if (btnp(⬆️)) selected=(selected-4)%16
	if (btnp(⬇️)) selected=(selected+4)%16
	if (btnp(❎)) shift(selected)
	if (btnp(🅾️)) scrambling=100

	if(btnp(❎)) check_finish()
	
	if scrambling>0 then
		scramble()
	end
end

function _draw()
	cls()
	
	-- tiles
	for i,tile in pairs(tiles) do
		local x,y=index_to_coords(i-1)
		rectfill(x,y,x+22,y+22,tile.bg)
		if #tile.label>0 then
			if (tile.fg) pal(7,tile.fg)
			for j,l in pairs(tile.label) do
				spr(l+1,x+(j-1)*8+(2-#tile.label)*4+3,y+8)
			end
			pal()
		end
	end
	
	-- selected
	local x,y=index_to_coords(selected)
	rect(x-1,y-1,x+23,y+23,7)
	
	print("❎ to move, 🅾️ to scramble",12,120)
end
__gfx__
00000000007777000007700000777700077777700000077007777700007777000777777000777700007777000000000000000000000000000000000000000000
00000000077007700077700007700770000007700000770007700000077000000000077007700770077007700000000000000000000000000000000000000000
00700700077007700007700007000770000007700007700007700000077000000000770007700770077007700000000000000000000000000000000000000000
00077000077077700007700000000770000070000077000007777700077777000007700000777700077007700000000000000000000000000000000000000000
00077000077707700007700000077700000777000770077000000770077007700007700007700770007777700000000000000000000000000000000000000000
00700700077007700007700000770000070007700777777000000770077007700007700007700770000007700000000000000000000000000000000000000000
00000000077007700007700007700000070007700000077007700770077007700007700007700770077007700000000000000000000000000000000000000000
00000000007777000077770007777770007777000000077000777700007777000007700000777700007777000000000000000000000000000000000000000000
__sfx__
01090000277722777227772277722777227772277722e7722e7722e7722e7722e7722e7722e7722f7022f7022f7022f7022f7022e702007020070200702007020070200702007020070200702007020070200702
01230000003531c3031c3031c3031a3031a3031a3031a303183031830318303183031830318303183030030300303003030030300303003030030300303003030030300303003030030300303003030030300303
