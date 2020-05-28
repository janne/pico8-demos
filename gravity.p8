pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
-- gRAVITY fORCE

function _init()
	map_width=24
	map_height=32
	shots={}
	turrets={}
	p1={p={64,64},v={0,0},a=.25}
	tick=0
	camera()
 
	-- find turrets
	for x=0,map_width-1 do
		for y=0,map_height-1 do
			if(mget(x,y)==1) then
				add(turrets,{p={x*8+4,y*8+4},a=.25,spd=.05})
			end
		end
	end
end

f={
	map=function(f,t)
		local new={}
		for x in all(t) do
			add(new,f(x))
		end
		return new
	end,
	rot=function(a)
	 return function(p)
	  local x,y=unpack(p)
			local c=cos(a)
			local s=sin(a)
			return {x=x*c-y*s,y=y*c+x*s}
		end
	end
}

ship={
	{4,0},
	{-4,3},
	{-2,0},
	{-4,-3}
}

function draw_poly(pos, ps)
 local x,y=unpack(pos)
	line(x+ps[1].x,y+ps[1].y,x+ps[2].x,y+ps[2].y,7)
	line(x+ps[3].x,y+ps[3].y)
	line(x+ps[4].x,y+ps[4].y)
	line(x+ps[1].x,y+ps[1].y)
end

function is_solid(x,y)
	return fget(mget(flr(x/8),flr(y/8)),0)
end

function col(x,y,a)
	local p=f.map(f.rot(a), ship)
	return is_solid(x+p[1].x,y+p[1].y) or
		is_solid(x+p[2].x,y+p[2].y) or
		is_solid(x+p[4].x,y+p[4].y)
end

function _draw()
	cls(1)
	map()
	draw_poly(p1.p,f.map(f.rot(p1.a), ship))
	for shot in all(shots) do
	 local x,y=unpack(shot.p)
		pset(x, y)	 
	end
	camera()
	local cpu=flr(stat(1)*100)
	print(cpu.."%")
end

function crash()
	_init()
end

function set_camera(p)
 local x,y=unpack(p)
	local cam_x_max=max(0,x-64)
	local cam_x=min(map_width*8-128,cam_x_max)
	local cam_y_max=max(0,y-64)
	local cam_y=min(map_height*8-128,cam_y_max)
	camera(cam_x,cam_y)
end

function _update()
	tick=(tick+1)%2^16
	local x,y=unpack(p1.p)
	local vx,vy=unpack(p1.v)
	local a=p1.a

	-- turning
	if(btn(⬅️) and vy!=0) a=(a+10/360)%1
	if(btn(➡️) and vy!=0) a=(a-10/360)%1

	-- camera
	set_camera(p1.p)

	-- gravity
	vy+=.03

	-- boost
	if(btn(🅾️)) then
		vx+=0.1*cos(a)
		vy+=0.1*sin(a)
		sfx(0)
	end

	-- shoot
	if(btnp(❎)) then
		sfx(1)
		local s=f.rot(a)(ship[1])
		local dx=3*cos(a)
		local dy=3*sin(a)
		add(shots,{p={x+s.x,y+s.y},dx=vx+dx,dy=vy+dy})
	end

	-- turrets
	if(tick%15==0) then
		for turret in all(turrets) do
			local dx=2*cos(turret.a)
			local dy=2*sin(turret.a)
			if(turret.a>=.4 or turret.a<=.1) turret.spd=-turret.spd
			turret.a+=turret.spd
			local x,y=unpack(turret.p)
			add(shots,{p={x,y},dx=dx,dy=dy})
		end
	end

	-- animate shots 
	for shot in all(shots) do
		local x,y=unpack(shot.p)
		local dx,dy=unpack(shot.v)
		x+=dx
		y+=dy
		local f=fget(mget(x/8,y/8),0)
		if(f or x<0 or x>=map_width*8 or y<0 or y>=map_height*8) then
			del(shots,shot)
		end
		shot.p={x,y}
	end

	-- crash in wall
	if(col(x+vx,y,a)) then
		crash()
		return
	end

	-- crash in floor/roof
	if(col(x,y+vy,a)) then
		local smooth=vy>0 and vy<2 and a>.15 and a<.35
		if (smooth) then
			vy=0
			vx=0
			a=0.25
		else
			crash()
			return
		end
	end
	
	p1.v={vx,vy}
	p1.p={x+vx,y+vy}
	p1.a=a
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000007d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000006d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006dd5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000006dddd500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999994999999900999999400000000886888888868888800008888886888008868888800000000000000000000000000000000000000000000000000000000
9449994a944999900449994a00000000886888888868888800688888886888888868888800000000000000000000000000000000000000000000000000000000
4aa4994a4aa499900aa4994a00000000886888888868888808688888886888888868888800000000000000000000000000000000000000000000000000000000
4a9444944a9444966a94449466666666666666666666666666666666666666666666666600000000000000000000000000000000000000000000000000000000
944aaa49944aaa46644aaa4966666666888888688888886888888868888888688888886800000000000000000000000000000000000000000000000000000000
994a9949994a9940094a994900000000888888688888886888888868888888688888886000000000000000000000000000000000000000000000000000000000
994a9949994a9940094a994900000000888888680888886888888868888888688888886000000000000000000000000000000000000000000000000000000000
99944499999444900994449900000000666666660006666666666666776666666666660000000000000000000000000000000000000000000000000000000000
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
9449994a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4aa4994a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4a944490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
944aaa40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
994a9940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
994a9940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99944400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
4a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a944494
944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49
994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949
994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949
99944499999444999994449999944499999444999994449999944499999444999994449999944499999444999994449999944499999444999994449999944499
99999994999999940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009999999499999994
9449994a9449994a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a9449994a
4aa4994a4aa4994a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a4aa4994a
4a9444944a9444900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a9444944a944494
944aaa49944aaa40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49944aaa49
994a9949994a9940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949994a9949
994a9949994a9940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949994a9949
99944499999444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009994449999944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868888899999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000068888888688888886888889449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000868888888688888886888884aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666666666664a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000888888688888886888888868944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000888888688888886888888868994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000888888688888886888888868994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666666666666666666699944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088688888886888888868888899999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888886888889449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888886888884aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666666666664a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000888888688888886888888868944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000888888688888886888888868994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888688888886888888868994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000066666666666666666666699944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888899999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000886888889449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000886888884aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000666666664a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888868944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088888868994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888868994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666699944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000006060000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000006060000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000006006000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000006000600000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000006000600000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000060666060000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000006600066000000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000099999994999999949999999499999994000000000000000000000000000000008868888888688888
9449994a00000000000000000000000000000000000000009449994a9449994a9449994a9449994a000000000000000000000000000000008868888888688888
4aa4994a00000000000000000000000000000000000000004aa4994a4aa4994a4aa4994a4aa4994a000000000000000000000000000000008868888888688888
4a94449400000000000000000000000000000000000000004a9444944a9444944a9444944a944490000000000000000000000000000000006666666666666666
944aaa490000000000000000000000000000000000000000944aaa49944aaa49944aaa49944aaa40000000000000000000000000000000008888886888888868
994a99490000000000000000000000000000000000000000994a9949994a9949994a9949994a9940000000000000000000000000000000008888886888888868
994a99490000000000000000000000000000000000000000994a9949994a9949994a9949994a9940000000000000000000000000000000008888886888888868
99944499000000000000000000000000000000000000000099944499999444999994449999944400000000000000000000000000000000006666666666666666
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888
9449994a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888
4aa4994a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888
4a944490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
944aaa40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868
994a9940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868
994a9940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868
99944400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
88688888886888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888
88688888886888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888
88688888886888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008868888888688888
66666666666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
88888868888888680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868
88888868888888680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868
88888868888888680000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888886888888868
66666666666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006666666666666666
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994886888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a88688888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a88688888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449466666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa498888886800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99498888886800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99498888886800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499666666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994999999949999999499999994999999940000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a9449994a9449994a9449994a9449994a000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a9444944a9444944a9444944a9444944a944490000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa49944aaa49944aaa49944aaa49944aaa4000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a9949994a9949994a9949994a9949994a994000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a9949994a9949994a9949994a9949994a994000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499999444999994449999944499999444000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994999999949999999400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a9449994a9449994a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a4aa4994a4aa4994a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a

__gff__
0000000000000000000000000000000001010101010101010100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1020000000000019000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000001614141700000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000001514141400000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000151800000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000001010102000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2000000000000000000000000000002100000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1414000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1014000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101020000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010200000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000100000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000001414141414140000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000001400000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000001400000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000001400000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1014141400000014141400000014140000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000140000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000140000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1000000000000000140000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010600001c61000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
010600001076300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703
011200001105317053170530000310053170531705300003120530f0530f053000030f0530f053000031005310053000030000300003000030000300003000030000300003000030000300003000030000300003
0116000710053000000c6550000310053000030c65500003100030000300003000030400300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300000
__music__
00 03024344

