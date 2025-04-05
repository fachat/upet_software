

1000 rem init
1005 print chr$(14)
1010 gosub 10000:rem data init
1020 gosub 11000:rem registers

1099 cc$="@{left}{right}{up}{down}p86tidserbBPfm"

1100 gosub 12000:rem print menu

1106 cl=len(cc$)
1110 get c$:if c$="" then 1110
1120 for c=1 to cl:if c$=mid$(cc$,c,1) then 1200
1130 next c
1140 goto 1100
1200 on c gosub 1900,2000,2100,2200,2300,2400,2600,2700,2800,2900,3000,3400,3600,3700,3800,4000,2850,3900,4100
1210 goto 1100

1900 rem reset via @
1910 m$=""
1920 goto 10100

2000 rem left
2010 if m$="p" then poke r,38:v=peek(d)-1:poke d,(v+abs(v))/2:return
2050 if m$="s" then poke r,25:v=(peek(d)and15)-1:poke d,(peek(d)and16)or((v+abs(v))/2):return
2060 if m$="m" then poke r,48+s*4:v=peek(p):a=peek(p):v=v+256*(peek(p)and3):v=v-1:v=(v+abs(v))/2:poke r,48+s*4:poke d,v and255:poke r,50+s*4:poke d,(peek(d) and 240) + v/256
2090 return
2100 rem right
2110 if m$="p" then poke r,38:poke d,peek(d)+1:return
2150 if m$="s" then poke r,25:poke d,peek(d)+1:return
2160 if m$="m" then poke r,48+s*4:v=peek(p):a=peek(p):v=v+256*(peek(p)and3):v=v+1:v=v and 1023:poke r,48+s*4:poke d,v and255:poke r,50+s*4:poke d,(peek(d) and 240) + v/256
2190 return
2200 rem up
2210 if m$="p" then poke r,39:v=peek(d)-1:poke d,(v+abs(v))/2:return
2250 if m$="s" then poke r,24:v=(peek(d)and15)-1:poke d,(peek(d)and16)or((v+abs(v))/2):return
2260 if m$="m" then poke r,49+s*4:v=peek(p):v=v+256*int(peek(p)/16):v=v-1:v=(v+abs(v))/2:poke r,49+s*4:poke p,v and255:poke d,(peek(d) and 15) + (int(v/256)*16)
2290 return
2300 rem down
2310 if m$="p" then poke r,39:poke d,peek(d)+1:return
2350 if m$="s" then poke r,24:poke d,peek(d)+1:return
2360 if m$="m" then poke r,49+s*4:v=peek(p):v=v+256*int(peek(p)/16):v=v+1:v=v and 1023:poke r,49+s*4:poke p,v and255:poke d,(peek(d) and 15) + (int(v/256)*16)
2390 return

2400 rem "p"
2405 m$=c$
2410 return

2600 rem "8"
2610 poke r,8:v=peek(d):v=(v or 128) - (v and 128):poke d,v
2620 return
2700 rem "6"
2710 poke r,8:v=peek(d):v=(v or 64) - (v and 64):poke d,v
2720 return
2800 rem "t"
2810 poke r,8:v=peek(d):v=(v or 32) - (v and 32):poke d,v
2820 return
2850 rem "P"
2860 poke r,8:v=peek(d):v=(v or 16) - (v and 16):poke d,v
2870 return
2900 rem "i"
2910 poke r,8:v=peek(d):v=(v or 2) - (v and 2):poke d,v
2920 return
3000 rem "d"
3010 poke r,8:v=peek(d):v=(v or 1) - (v and 1):poke d,v
3020 return

3400 rem "s"
3410 m$=c$
3420 return

3600 rem "e" sprite width
3610 for i=0 to 6:poke r,51+i*4
3620 rem v=peek(d):v=(v or 6) - (v and 6):poke d,v
3625 v=peek(d):v=(v or 6) - (v and 6):poke d,v
3630 next
3640 return

3700 rem "r" sprite raster prio
3710 for i=0 to 6:poke r,51+i*4
3720 v=peek(d):v=(v or 16) - (v and 16):poke d,v
3730 next
3740 return

3800 rem "b" sprite border prio
3810 for i=0 to 6:poke r,51+i*4
3820 v=peek(d):v=(v or 32) - (v and 32):poke d,v
3830 next
3840 return

3900 rem "f" sprite fine/80col mode
3910 for i=0 to 6:poke r,51+i*4
3920 v=peek(d):v=(v or 64) - (v and 64):poke d,v
3930 next
3940 return

4000 rem "B" border colour
4010 poke r, 34
4020 poke d, (peek(d) + 1) and 15
4030 return

4100 rem "m" sprite move
4110 if m$="m" then s=s+1:if s>8 then s=0
4110 m$=c$
4120 return
9999 end

10000 rem viccy registers
10001 r=59520:rem index
10002 d=59521:rem register value
10003 p=59523:rem register value w/ index auto increment
10004 s=0:rem sprite number for move

10005 poke r,38:poke p,9:poke p,79: rem screen geo
10006 poke r,9:poke d,7
10007 poke 59395,3:rem full speed

10010 rem sprites
10015 poke 59398,128+10:rem $8axxx in $9xxx window, i.e. block 10 in vid bank
10020 poke 59393, peek(59393) and (255-48): rem write enable $9xxx/$axxx
10021 b=36864:rem sprite data base ($9000)
10022 for i=0 to 62:rem 8 sprites
10023 read a:poke b+i,a:poke b+64+i,a:poke b+128+i,a:poke b+192+i,a:poke b+256+i,a:poke b+320+i,a:poke b+384+i,a:poke b+448+i,a
10024 next
10026 for i=0 to 62
10027 read a:poke b+512+i,a
10028 next

10030 rem copy numbers from charset
10032 poke 59398,128+0:rem page 0 for first charset page
10034 for i=0to9:forj=0to7:poke40960+i*8+j,peek(b+(48+i)*16+j):next:next
10036 rem copy into sprite data into checker sectors
10037 poke 59398,128+10:rem $8axxx in $9xxx window, i.e. block 10 in vid bank
10038 for i=0to7
10040 poke b+3*i,peek(40960+i):rem sprite 0
10041 poke b+64+2+3*i,peek(40960+8+i):rem sprite 1
10042 poke b+128+39+3*i,peek(40960+16+i):rem sprite 2
10043 poke b+192+41+3*i,peek(40960+24+i):rem sprite 3
10044 poke b+256+3*i,peek(40960+32+i):rem sprite 4
10045 poke b+320+2+3*i,peek(40960+40+i):rem sprite 5
10046 poke b+384+39+3*i,peek(40960+48+i):rem sprite 6
10047 poke b+448+41+3*i,peek(40960+56+i):rem sprite 7
10048 next

10050 poke r,34:poke d,1
10059 return

10060 rem checker
10070 data 204,211,51
10071 data 204,203,51
10072 data 51 ,16,204
10073 data 51 ,8,204
10074 data 192,16,3
10075 data 192,8,3
10076 data 48,16,12
10077 data 48,8,12
10078 data 192,16,3
10079 data 192,8,3
10080 data 255,255,255
10081 data 192,16,3
10082 data 192,8,3
10083 data 48,16,12
10084 data 48,8,12
10085 data 192,16,3
10086 data 192,8,3
10087 data 51,16,204
10088 data 51,8,204
10089 data 204,211,51
10090 data 204,203,51

10099 rem outer border
10100 data 255,255,255
10101 data 128,0,1
10102 data 128,0,1
10103 data 128,0,1
10104 data 128,0,1
10105 data 128,0,1
10106 data 128,0,1
10107 data 128,0,1
10108 data 128,0,1
10109 data 128,0,1
10110 data 255,255,255
10111 data 128,0,1
10112 data 128,0,1
10113 data 128,0,1
10114 data 128,0,1
10115 data 128,0,1
10116 data 128,0,1
10117 data 128,0,1
10118 data 128,0,1
10119 data 128,0,1
10120 data 255,255,255

11000 rem register init
11010 poke r,42:poke d, 10*16+15:rem sprite base $1afxx (sprite pointer)
11100 rem sprite 0
11110 poke 10*4096-8, 128:rem a15/14 from sprite base, b7 becomes a13 etc
11120 poke r,48: poke p,15
11121            poke p,130
11122            poke p,0
11123            poke p,1
11130 poke r,80: poke d,15:rem white
11190 rem sprite 1 top right
11191 poke 40960-7,128+1
11192 poke r,52:poke d,91
11193 poke r,53:poke d,30
11194 poke r,54:poke d,1
11196 poke r,55:poke d,1
11198 poke r,81:poke d,15:rem white
11200 rem sprite 2 bottom left
11201 poke 40960-6,128+2
11202 poke r,56:poke d,27
11203 poke r,57:poke d,229
11204 poke r,58:poke d,0
11205 poke r,59:poke d,1
11206 poke r,82:poke d,15:rem white
11210 rem sprite 3 bottom right
11211 poke 40960-5,128+3
11212 poke r,60:poke d,91
11213 poke r,61:poke d,229
11214 poke r,62:poke d,1
11215 poke r,63:poke d,1
11216 poke r,83:poke d,15:rem white
11220 rem sprite 4 zero v middle h
11221 poke 40960-4,128+4
11222 poke r,64:poke d,186
11223 poke r,65:poke d,1
11224 poke r,66:poke d,0
11225 poke r,67:poke d,1
11226 poke r,84:poke d,15:rem white
11230 rem sprite 5 middle v zero h
11231 poke 40960-3,128+5
11232 poke r,68:poke d,15  :rem 27
11233 poke r,69:poke d,160 :rem 30
11234 poke r,70:poke d,0
11235 poke r,71:poke d,1
11236 poke r,85:poke d,15:rem white
11240 rem sprite 6 last bottom zero
11241 poke 40960-2,128+6
11242 poke r,72:poke d,186
11243 poke r,73:poke d,0
11244 poke r,74:poke d,16
11245 poke r,75:poke d,1
11246 poke r,86:poke d,15:rem white

11999 return

12000 rem print menu
12100 print "{clr}"
12110 print "micro-pet sprite geometry explorer"
12120 print
12130 print "use '@' to reset, crsr to adjust"
12140 print

12150 if m$="p" then print"{rvon}";
12152 print "p: hor/vert pos     (38/39):";
12155 poke r,38:print peek(p);",";peek(p)"{rvof}"

12200 if m$="s" then print"{rvon}";
12202 print "s: h/v smooth scroll(24/25):";
12205 poke r,24:print peek(p);",";peek(p);"{rvof}"

12220 poke r,51:v=peek(d):if v and 6 then print"{rvon}";
12222 print "e: toggle sprite width/height{rvof}"

12230 poke r,51:v=peek(d):if v and 16 then print"{rvon}";
12232 print "r: toggle sprite raster priority{rvof}"

12240 poke r,51:v=peek(d):if v and 32 then print"{rvon}";
12242 print "b: toggle sprite border prio{rvof}"

12250 poke r,51:v=peek(d):if v and 64 then print"{rvon}";
12252 print "f: toggle sprite fine/80col coords{rvof}"

12300 rem sprite positions
12305 print "m: ";
12310 for i=0to7:poke r,48+i*4
12320 x=peek(p):y=peek(p):xy=peek(p):x=x+256*(xy and 3):y=y+256*((xy and 48)/16)
12325 if m$="m" and i=s then print"{rvon}";
12330 print i;": "x"/"y"{rvof} ";
12331 if i=1 or i=3 or i=5 then print:print"   ";
12340 next
12800 poke r,8:v=peek(d)
12801 print:print "mode: "v
12802 print "  ";:if v and 128 then print"{rvon}";
12804 print "[8:80 col]{rvof}      ";
12806 print "  ";:if v and 64 then print"{rvon}";
12808 print "[6:60 hz]{rvof}"
12810 print "  ";:if v and 32 then print"{rvon}";
12812 print "[t:tv mode]{rvof}     ";
12814 print "  ";:if v and 16 then print"{rvon}";
12816 print "[P:PET (w/ t)]{rvof}"
12818 print "  ";:if v and 2 then print"{rvon}";
12820 print "[i:interlace]{rvof}   ";
12822 print "  ";:if v and 1 then print"{rvon}";
12824 print "[d:double (w/ i)]{rvof}"
12920 print "<--                                  -->";
12920 print "<--                                  -->";
12999 return


