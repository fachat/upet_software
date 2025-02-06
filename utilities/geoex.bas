
1000 gosub 10000:rem init
1010 gosub 10100:rem reset registers
1020 gosub 10100:rem reset registers
1100 gosub 11000:rem print menu

1110 get c$:if c$="" then 1110
1120 for c=1 to 12:if c$=mid$("@{left}{right}{up}{down}ps86tid",c,1) then 1200
1130 next c
1140 goto 1100
1200 on c gosub 1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000
1210 goto 1100

1900 rem reset via @
1910 m$=""
1920 goto 10100
2000 rem left
2010 if m$="p" then poke r,38:poke d,peek(d)-1:return
2020 if m$="s" then poke r,1:poke d,peek(d)-1:return
2030 return
2100 rem right
2110 if m$="p" then poke r,38:poke d,peek(d)+1:return
2120 if m$="s" then poke r,1:poke d,peek(d)+1:return
2130 return
2200 rem up
2210 if m$="p" then poke r,39:poke d,peek(d)-1:return
2220 if m$="s" then poke r,6:poke d,peek(d)-1:return
2230 return
2300 rem down
2210 if m$="p" then poke r,39:poke d,peek(d)+1:return
2220 if m$="s" then poke r,6:poke d,peek(d)+1:return
2230 return
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
10060 data   0,  40,   0,   0,   0,   0,  25,   0:rem 0-7
10061 data   0,   7,  32,   7, 144,   0,  16,   0:rem 8-15
10062 data   0,   0,   0,   0, 208,   0,   9,  15:rem 16-23
10063 data   0,   0,   0,   0,   0,   7,   0,   0:rem 24-31
10064 data  20,  15,   5,   0, 127,   0,   8, 130:rem 32-39
10090 return

10100 rem reset registers
10105 poke r,0
10110 for i=1 to 40
10120 poke p,r(i)
10130 next
10140 return

11000 rem print menu
11100 print "{clr}"
11110 print "micro-pet video geometry explorer"
11120 print
11130 print "use '@' to reset video if messed up"
11140 print
11150 if m$="p" then print"{rvon}";
11152 print "p: horizontal/vertical pos  :";
11155 poke r,38:print peek(p)","peek(p)"{rvof}"
11160 if m$="s" then print"{rvon}";
11162 print "s: horizontal/vertical size :";
11165 poke r,1:print peek(p)",";
11166 poke r,6:print peek(p)"{rvof}"
11200 poke r,8:v=peek(d)
11201 print:print "mode: "v
11202 print "    ";:if v and 128 then print"{rvon}";
11204 print "[8:80 col]{rvof}"
11206 print "    ";:if v and 64 then print"{rvon}";
11208 print "[6:60 Hz]{rvof}"
11210 print "    ";:if v and 32 then print"{rvon}";
11212 print "[t:tv mode]{rvof}"
11214 print "    ";:if v and 2 then print"{rvon}";
11216 print "[i:interlace]{rvof}"
11218 print "    ";:if v and 1 then print"{rvon}";
11220 print "[d:double (with i only)]{rvof}"
11900 print
11910 if m$="s" or m$="p" then print "use cursor keys to adjust geometry"
11999 return

