

1000 rem init
1010 gosub 10000:rem data init
1020 gosub 11000:rem registers

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

