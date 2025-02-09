
1000 gosub 10000:rem init
1010 gosub 10100:rem reset registers
1020 gosub 10100:rem reset registers
1100 gosub 11000:rem print menu

1105 cc$="@{left}{right}{up}{down}ps86tidcovmbwre"
1106 cl=len(cc$)
1110 get c$:if c$="" then 1110
1120 for c=1 to cl:if c$=mid$(cc$,c,1) then 1200
1130 next c
1140 goto 1100
1200 on c gosub 1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000,3100,3200,3300,3400,3500,3600,3700,3800
1210 goto 1100

1900 rem reset via @
1910 m$=""
1920 goto 10100
2000 rem left
2010 if m$="p" then poke r,38:v=peek(d)-1:poke d,(v+abs(v))/2:return
2020 if m$="s" then poke r,1:v=peek(d)-1:poke d,(v+abs(v))/2:return
2030 if m$="o" then poke r,27:v=peek(d)-1:poke d,(v+abs(v))/2:return
2040 if m$="v" then poke r,22:v=peek(d)-1:poke d,(v+abs(v))/2:return
2050 if m$="m" then poke r,25:v=(peek(d)and15)-1:poke d,(peek(d)and16)or((v+abs(v))/2):return
2060 if m$="b" then poke r,25:v=peek(d):poke d,v and(255-16):return
2090 return
2100 rem right
2110 if m$="p" then poke r,38:poke d,peek(d)+1:return
2120 if m$="s" then poke r,1:poke d,peek(d)+1:return
2130 if m$="o" then poke r,27:poke d,peek(d)+1:return
2140 if m$="v" then poke r,22:poke d,peek(d)+1:return
2150 if m$="m" then poke r,25:poke d,peek(d)+1:return
2160 if m$="b" then poke r,25:v=peek(d):poke d,v or 16:return
2190 return
2200 rem up
2210 if m$="p" then poke r,39:v=peek(d)-1:poke d,(v+abs(v))/2:return
2220 if m$="s" then poke r,6:v=peek(d)-1:poke d,(v+abs(v))/2:return
2230 if m$="c" then poke r,9:v=peek(d)-1:poke d,(v+abs(v))/2:return
2240 if m$="v" then poke r,23:v=peek(d)-1:poke d,(v+abs(v))/2:return
2250 if m$="m" then poke r,24:v=(peek(d)and15)-1:poke d,(peek(d)and16)or((v+abs(v))/2):return
2260 if m$="b" then poke r,24:v=peek(d):poke d,v and(255-16):return
2290 return
2300 rem down
2310 if m$="p" then poke r,39:poke d,peek(d)+1:return
2320 if m$="s" then poke r,6:poke d,peek(d)+1:return
2330 if m$="c" then poke r,9:poke d,peek(d)+1:return
2340 if m$="v" then poke r,23:poke d,peek(d)+1:return
2350 if m$="m" then poke r,24:poke d,peek(d)+1:return
2360 if m$="b" then poke r,24:v=peek(d):poke d,v or 16:return
2390 return
2400 rem "p"
2405 m$=c$
2410 return
2500 rem "s"
2505 m$=c$
2510 return
2600 rem "8"
2610 poke r,8:v=peek(d):v=(v or 128) - (v and 128):poke d,v
2620 return
2700 rem "6"
2710 poke r,8:v=peek(d):v=(v or 64) - (v and 64):poke d,v
2720 return
2800 rem "t"
2810 poke r,8:v=peek(d):v=(v or 32) - (v and 32):poke d,v
2820 return
2900 rem "i"
2910 poke r,8:v=peek(d):v=(v or 2) - (v and 2):poke d,v
2920 return
3000 rem "d"
3010 poke r,8:v=peek(d):v=(v or 1) - (v and 1):poke d,v
3020 return
3100 rem "c"
3110 m$=c$
3120 return
3200 rem "o"
3210 m$=c$
3220 return
3300 rem "v"
3310 m$=c$
3320 return
3400 rem "m"
3410 m$=c$
3420 return
3500 rem "b"
3510 m$=c$
3520 return

3600 rem "w" sprite width
3610 for i=0 to 6:poke r,51+i*4
3620 v=peek(d):v=(v or 6) - (v and 6):poke d,v
3630 next
3640 return

3700 rem "r" sprite raster prio
3710 for i=0 to 6:poke r,51+i*4
3720 v=peek(d):v=(v or 16) - (v and 16):poke d,v
3730 next
3740 return

3800 rem "e" sprite border prio
3810 for i=0 to 6:poke r,51+i*4
3820 v=peek(d):v=(v or 32) - (v and 32):poke d,v
3830 next
3840 return

9990 get a$:ifa$=""then 9990
9991 return
9999 end
10000 rem init
10010 r=59520
10015 d=59521
10020 p=59523
10025 dim r(40)
10030 for i=1 to 40
10040 read r(i)
10050 next

10051 rem sprite
10052 for i=0 to 62
10053 read a:poke 8*4096+4*256+i,a
10054 next

10059 return

10060 data   0,  40,   0,   0,   0,   0,  25,   0:rem 0-7
10061 data   0,   7,  32,   7, 144,   0,  16,   0:rem 8-15
10062 data   0,   0,   0,   0, 208,   0,   9,  15:rem 16-23
10063 data   0,   0,   0,   0,   0,   7,   0,   0:rem 24-31
10064 data  20,  15,   5,   0, 127,   0,   8,  79:rem 32-39

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

10100 rem reset registers
10105 poke r,0
10110 for i=1 to 40
10120 poke p,r(i)
10130 next

10150 rem sprite reset
10160 poke r,42:poke d,9*16+7:rem sprite base
10180 rem sprite 0 top left
10181 poke 8*4096+8*256-8,80
10182 poke r,48:poke d,26
10183 poke r,49:poke d,30
10184 poke r,50:poke d,0
10186 poke r,51:poke d,1
10188 poke r,80:poke d,15:rem white
10190 rem sprite 1 top right
10191 poke 8*4096+8*256-7,80
10192 poke r,52:poke d,90
10193 poke r,53:poke d,30
10194 poke r,54:poke d,1
10196 poke r,55:poke d,1
10198 poke r,81:poke d,15:rem white
10200 rem sprite 2 bottom left
10201 poke 8*4096+8*256-6,80
10202 poke r,56:poke d,26
10203 poke r,57:poke d,229
10204 poke r,58:poke d,0
10205 poke r,59:poke d,1
10206 poke r,82:poke d,15:rem white
10210 rem sprite 3 bottom right
10211 poke 8*4096+8*256-5,80
10212 poke r,60:poke d,90
10213 poke r,61:poke d,229
10214 poke r,62:poke d,1
10215 poke r,63:poke d,1
10216 poke r,83:poke d,15:rem white
10220 rem sprite 4 zero middle
10221 poke 8*4096+8*256-4,80
10222 poke r,64:poke d,186
10223 poke r,65:poke d,1
10224 poke r,66:poke d,0
10225 poke r,67:poke d,1
10226 poke r,84:poke d,15:rem white
10230 rem sprite 5 middle v zero h
10231 poke 8*4096+8*256-3,80
10232 poke r,68:poke d,14
10233 poke r,69:poke d,130
10234 poke r,70:poke d,0
10235 poke r,71:poke d,1
10236 poke r,85:poke d,15:rem white
10240 rem sprite 6 last bottom zero
10241 poke 8*4096+8*256-2,80
10242 poke r,72:poke d,186
10243 poke r,73:poke d,0
10244 poke r,74:poke d,16
10245 poke r,75:poke d,1
10246 poke r,86:poke d,15:rem white
10299 return

11000 rem print menu
11100 print "{clr}"
11110 print "micro-pet video geometry explorer"
11120 print
11130 print "use '@' to reset video if messed up"
11140 print

11150 if m$="p" then print"{rvon}";
11152 print "p: hor/vert pos     (38/39):";
11155 poke r,38:print peek(p);",";peek(p)"{rvof}"

11160 if m$="s" then print"{rvon}";
11162 print "s: hor/vert size    ( 1/ 6):";
11165 poke r,1:print peek(p);",";
11166 poke r,6:print peek(p)"{rvof}"

11170 if m$="c" then print"{rvon}";
11172 print "c: char height      ( 9)   :";
11175 poke r,9:print peek(p);"{rvof}"

11180 if m$="o" then print"{rvon}";
11182 print "o: line offset      (27)   :";
11185 poke r,27:print peek(p);"{rvof}"

11190 if m$="v" then print"{rvon}";
11192 print "v: h/v visible char (22/23):";
11195 poke r,22:print peek(p);",";peek(p);"{rvof}"

11200 if m$="m" then print"{rvon}";
11202 print "m: h/v smooth scroll(24/25):";
11205 poke r,24:print peek(p);",";peek(p);"{rvof}"

11210 if m$="b" then print"{rvon}";
11212 print "b: h/v borders      (24/25):";
11215 poke r,24:print peek(p)and16;",";peek(p)and16;"{rvof}"

11220 poke r,51:v=peek(d):if v and 6 then print"{rvon}";
11222 print "w: toggle sprite width/height{rvof}"

11230 poke r,51:v=peek(d):if v and 16 then print"{rvon}";
11232 print "r: toggle sprite raster priority{rvof}"

11240 poke r,51:v=peek(d):if v and 32 then print"{rvon}";
11242 print "e: toggle sprite border prio{rvof}"

11800 poke r,8:v=peek(d)
11801 print:print "mode: "v
11802 print "    ";:if v and 128 then print"{rvon}";
11804 print "[8:80 col]{rvof}      ";
11806 print "    ";:if v and 64 then print"{rvon}";
11808 print "[6:60 hz]{rvof}"
11810 print "    ";:if v and 32 then print"{rvon}";
11812 print "[t:tv mode]{rvof}     ";
11814 print "    ";:if v and 2 then print"{rvon}";
11816 print "[i:interlace]{rvof}"
11818 print "    ";:if v and 1 then print"{rvon}";
11820 print "[d:double (with i only)]{rvof}"
11900 print
11910 if m$="s" or m$="p" or m$="c" or m$="o" or m$="v" or m$="m" then print "use cursor keys to adjust geometry"
11999 return

