

1000 rem init
1010 gosub 10000:rem data init
1020 gosub 11000:rem registers

1099 cc$="@{left}{right}{up}{down}p86tidmwreBPf"

1100 gosub 12000:rem print menu

1106 cl=len(cc$)
1110 get c$:if c$="" then 1110
1120 for c=1 to cl:if c$=mid$(cc$,c,1) then 1200
1130 next c
1140 goto 1100
1200 on c gosub 1900,2000,2100,2200,2300,2400,2600,2700,2800,2900,3000,3400,3600,3700,3800,4000,2850,3900
1210 goto 1100

1900 rem reset via @
1910 m$=""
1920 goto 10100

2000 rem left
2010 if m$="p" then poke r,38:v=peek(d)-1:poke d,(v+abs(v))/2:return
2050 if m$="m" then poke r,25:v=(peek(d)and15)-1:poke d,(peek(d)and16)or((v+abs(v))/2):return
2090 return
2100 rem right
2110 if m$="p" then poke r,38:poke d,peek(d)+1:return
2150 if m$="m" then poke r,25:poke d,peek(d)+1:return
2190 return
2200 rem up
2210 if m$="p" then poke r,39:v=peek(d)-1:poke d,(v+abs(v))/2:return
2250 if m$="m" then poke r,24:v=(peek(d)and15)-1:poke d,(peek(d)and16)or((v+abs(v))/2):return
2290 return
2300 rem down
2310 if m$="p" then poke r,39:poke d,peek(d)+1:return
2350 if m$="m" then poke r,24:poke d,peek(d)+1:return
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

3000 rem "d"
3010 poke r,8:v=peek(d):v=(v or 1) - (v and 1):poke d,v
3020 return

3400 rem "m"
3410 m$=c$
3420 return

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

3900 rem "f" sprite fine/80col mode
3910 for i=0 to 6:poke r,51+i*4
3920 v=peek(d):v=(v or 64) - (v and 64):poke d,v
3930 next
3940 return

4000 rem "B" border colour
4010 poke r, 34
4020 poke d, (peek(d) + 1) and 15
4030 return


9999 end

10000 rem viccy registers
10001 r=59520:rem index
10002 d=59521:rem register value
10003 p=59523:rem register value w/ index auto increment

10010 rem sprites
10015 poke 59398,128+10:rem $8axxx in $9xxx window, i.e. block 10 in vid bank
10020 poke 59393, peek(59393) and (255-16): rem write enable $9xxx
10022 for i=0 to 62
10023 read a:poke 36864+i,a
10024 next
10026 for i=0 to 62
10027 read a:poke 36864+64+i,a
10028 next
10050 return

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
11120 poke r,48: poke p,27+24:poke p,30:poke p,0:poke p,1
11130 poke r,80: poke d,1:rem white
11150 poke 10*4096-7, 129
11160 poke r,52: poke p,91:poke p,30:poke p,1:poke p,1
11170 poke r,80: poke d,1:rem white

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

12200 if m$="m" then print"{rvon}";
12202 print "m: h/v smooth scroll(24/25):";
12205 poke r,24:print peek(p);",";peek(p);"{rvof}"

12220 poke r,51:v=peek(d):if v and 6 then print"{rvon}";
12222 print "w: toggle sprite width/height{rvof}"

12230 poke r,51:v=peek(d):if v and 16 then print"{rvon}";
12232 print "r: toggle sprite raster priority{rvof}"

12240 poke r,51:v=peek(d):if v and 32 then print"{rvon}";
12242 print "e: toggle sprite border prio{rvof}"

12250 poke r,51:v=peek(d):if v and 64 then print"{rvon}";
12252 print "f: toggle sprite fine/80col coords{rvof}"

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


