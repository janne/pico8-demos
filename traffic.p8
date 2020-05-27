pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
-- traffic

x=24
y=24
s=1

function chk(x,y,flg)
 return fget(mget(x/8,y/8),flg)
end

function _draw()
 cls()
 map()
 spr(s,x,y)

 xo=x
 yo=y

 if(btn(⬆️)) then
  y-=1
  s=1
 elseif(btn(➡️)) then
  x+=1
  s=2
 elseif(btn(⬇️)) then
  y+=1
  s=3
 elseif(btn(⬅️)) then
  x-=1
  s=4
 end
 
 
 grass=chk(x+3,y+3,1)
 if(grass) then
  sfx(1)
  camera(flr(rnd(2))-1,flr(rnd(2))-1)
 else
  camera()
 end

 if(chk(x,y) or chk(x+5,y) or chk(x,y+5) or chk(x+5,y+5)) then
  x=xo
  y=yo
  sfx(0)
 end
 
 spr(36,32,72,1,1)
 spr(36,32,80,1,1)
end
__gfx__
000000000cccc000550550005cccc500055055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000005c66c500c6c6cc0056666500cc6c6c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070070056666500c6c66c000cccc000c66c6c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000cccc000c6c66c0056666500c66c6c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700056666500c6c6cc005c66c500cc6c6c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007005cccc500550550000cccc000055055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666776666666666666677666666666bbbb6666666667766666677666bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb88bbbbbbb00000000000000000000000000000000
6666666666666666666666666666666bb66666666666666666666666bbbbbbbbbbbbbb8bbbbbbbbbbbbbb888888bbbbb00000000000000000000000000000000
66666666666666666666666666666666666666666666666666666666bbbbb3bbbb8bbbbbbbbbbbbbbbb8888888888bbb00000000000000000000000000000000
66677666766776677667766776676666666676676667766776677666bbbbbbbbbbbbbbbbbbbbbbbbb88888888888888b00000000000000000000000000000000
66677666766776677667766776677666666776676666766776676666bbbbbbbbbbbbbbbbbbbbbbbbb88888888888888b00000000000000000000000000000000
66666666666666666666666666666666666666666666666666666666bbb3bbbbbbabbbbbbbbbbbbbb88888888888888b00000000000000000000000000000000
6666666666666666666666666666666666666666b66666666666666bbbbbbbbbbbbbbb3bbbbbbbbbb88888888888888b00000000000000000000000000000000
6667766666666666666776666667766666677666bb666666666666bbbbbbbbbbbbbbbbbbbbbbbbbbb88888888888888b00000000000000000000000000000000
66666666666776666667766666677666dddddddd0000000000000000000000000000000000000000b88888888888888b00000000000000000000000000000000
66666666666666666666666666666666dddddddd0000000000000000000000000000000000000000b88888888888888b00000000000000000000000000000000
66666666666666666666666666666666dddddddd0000000000000000000000000000000000000000b88888888888888b00000000000000000000000000000000
76677667766776677667766666677667dddddddd0000000000000000000000000000000000000000b888888dd888888b00000000000000000000000000000000
76677667766776677667766666677667dddddddd0000000000000000000000000000000000000000b8888dddddd8888b00000000000000000000000000000000
66666666666666666666666666666666dddddddd0000000000000000000000000000000000000000b88dddddddddd88b00000000000000000000000000000000
66666666666666666666666666666666dddddddd0000000000000000000000000000000000000000bdddddd55ddddddb00000000000000000000000000000000
66677666666666666667766666677666dddddddd0000000000000000000000000000000000000000bdddddd55ddddddb00000000000000000000000000000000
__label__
99999994999999949999999499999994999999949999999499999994999999949999999499999994999999949999999499999994999999949999999499999994
9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a9449994a
4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a
4a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a9444944a944494
944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49
994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949
994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949994a9949
99944499999444999994449999944499999444999994449999944499999444999994449999944499999444999994449999944499999444999994449999944499
99999994999999949999999400000000000000000000000000000000000000000000000000000000000000000000000000000000000000009999999499999994
9449994a9449994a9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a9449994a
4aa4994a4aa4994a4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a4aa4994a
4a9444944a9444944a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a9444944a944494
944aaa49944aaa49944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49944aaa49
994a9949994a9949994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949994a9949
994a9949994a9949994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949994a9949
99944499999444999994449900000000000000000000000000000000000000000000000000000000000000000000000000000000000000009994449999944499
99999994999999940000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a9449994a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a4aa4994a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a9444944a944494000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa49944aaa4900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a9949994a994900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a9949994a994900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499999444990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
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
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000060600000000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000000000000000000060600000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000060006000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000060006000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000060006000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000060000060000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000060000060000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000600666006000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000066600066600000000000000000000000000000000000000000000000000099944499
99999994000000000000000000000000000000000000000099999994999999949999999499999994000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000009449994a9449994a9449994a9449994a00000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000004aa4994a4aa4994a4aa4994a4aa4994a00000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000004a9444944a9444944a9444944a94449400000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000944aaa49944aaa49944aaa49944aaa490000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000994a9949994a9949994a9949994a99490000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000994a9949994a9949994a9949994a99490000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000099944499999444999994449999944499000000000000000000000000000000000000000099944499
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
99999994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999994
9449994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009449994a
4aa4994a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004aa4994a
4a94449400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004a944494
944aaa490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000944aaa49
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
994a99490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994a9949
99944499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000099944499
99999994999999949999999499999994999999949999999499999990000000000000000009999994999999949999999499999994999999949999999499999994
9449994a9449994a9449994a9449994a9449994a9449994a9449999000000000000000000449994a9449994a9449994a9449994a9449994a9449994a9449994a
4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4999000000000000000000aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a4aa4994a
4a9444944a9444944a9444944a9444944a9444944a9444944a94449666666666666666666a9444944a9444944a9444944a9444944a9444944a9444944a944494
944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa466666666666666666644aaa49944aaa49944aaa49944aaa49944aaa49944aaa49944aaa49
994a9949994a9949994a9949994a9949994a9949994a9949994a99400000000000000000094a9949994a9949994a9949994a9949994a9949994a9949994a9949
994a9949994a9949994a9949994a9949994a9949994a9949994a99400000000000000000094a9949994a9949994a9949994a9949994a9949994a9949994a9949
99944499999444999994449999944499999444999994449999944490000000000000000009944499999444999994449999944499999444999994449999944499

__gff__
0000000000000000000000000000000000000000000000020202010100000000000000000100000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1919191919191919191918191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1914111111112011111317191917191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1910181919191018171019191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1710191111111211112219191719181900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191019181919101a1b1017191919171900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191019191819102a2b1019191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1915111120112111111618191819181900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191910191917191917191919171900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1918171910191919191919191819191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191919241024181919191a1b1919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
191817241024191917192a2b1917191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1719191910191919171911111319171900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191910191919191919191019171900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191915111111111111111619191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919191919181919191919181900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191919181919191917191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1919191719191919191919191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1918191919191919191919191919191900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010400001c65000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
010400000e05000000100500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000