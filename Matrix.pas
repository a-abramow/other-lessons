Program Matrix;
Uses TpCrt;
Type
  Screen= array [1..25,1..80] of Record
                                   Ch:Char;
                                   At:Byte;
                                 End;
Var scr:Screen absolute $B800:$0000;
Procedure LoadFont;{� ��㧪  ���� }
Const
  font:array [1..4096] of Byte=(
0,32,96,255,126,64,64,198,159,130,64,112,31,0,0,0,6,6,6,126,
6,6,6,6,6,127,6,12,12,56,224,0,33,97,33,253,25,9,65,97,
32,255,64,65,193,3,2,14,16,24,132,194,99,33,255,16,16,8,8,12,
4,4,0,0,48,220,196,124,0,0,127,1,1,1,6,12,48,0,0,0,
0,0,140,132,197,101,53,29,5,127,5,13,25,96,0,0,0,0,8,15,
60,12,4,68,68,255,36,36,36,0,0,0,0,8,16,50,38,108,72,216,
252,32,96,64,128,252,0,0,0,0,127,17,18,255,18,18,50,32,32,32,
32,0,0,0,1,3,2,6,60,110,80,80,96,96,32,224,128,126,0,0,
0,0,0,0,32,48,124,16,16,12,12,255,14,10,0,0,0,0,124,6,
2,3,49,127,49,1,2,6,140,240,128,0,6,13,11,6,0,127,192,128,
135,192,96,48,24,14,2,0,0,0,0,0,127,1,3,66,100,40,48,88,
12,4,0,0,0,8,8,114,62,102,60,110,75,72,0,64,56,15,0,0,
0,8,62,98,66,6,12,56,56,44,68,64,64,56,4,0,0,48,32,108,
120,192,132,232,56,28,50,38,56,96,64,0,56,64,96,56,60,102,66,126,
66,102,60,48,24,8,24,48,32,124,254,32,32,32,100,68,254,136,128,128,
120,14,0,0,0,0,0,124,198,131,225,63,1,1,1,7,60,0,0,0,
0,96,112,32,34,2,252,4,4,12,8,24,112,0,0,0,32,112,112,4,
4,190,76,96,48,31,0,0,0,0,0,0,0,0,0,0,0,16,17,27,
58,50,34,126,32,1,3,14,0,0,0,0,0,60,98,2,6,28,60,38,
42,27,1,0,0,0,0,0,0,0,0,0,240,138,202,122,30,15,57,224,
0,0,0,0,0,16,32,36,68,126,72,8,12,6,252,0,0,0,0,8,
8,72,106,42,46,24,24,16,16,16,48,0,0,0,16,24,28,86,98,98,
126,64,76,124,8,56,96,0,0,0,0,0,0,16,24,8,12,255,4,4,
4,4,12,120,0,0,0,0,48,36,44,32,48,28,4,12,48,0,0,0,
0,0,4,4,4,38,34,122,32,17,14,112,64,0,0,0,0,0,0,0,
48,35,37,31,8,8,8,200,120,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,14,24,48,32,38,46,44,32,48,24,
15,192,96,0,0,0,0,3,28,22,36,52,28,8,248,48,24,8,56,0,
0,30,64,0,148,20,126,40,40,252,80,82,0,4,120,0,0,0,0,60,
102,66,66,96,48,24,136,249,113,2,12,0,0,0,28,48,56,48,60,198,
134,216,96,0,48,28,247,0,0,0,0,62,2,2,2,2,6,4,12,24,
16,0,0,0,0,112,216,140,96,56,12,4,4,12,24,48,48,62,14,16,
0,0,0,0,0,0,12,24,16,239,0,0,0,0,0,0,0,0,0,0,
16,16,24,40,68,134,131,255,0,0,0,0,0,0,12,4,2,2,6,8,
24,36,66,195,1,0,0,0,0,0,0,0,0,4,4,4,2,2,2,58,
240,30,0,0,0,0,0,0,0,0,0,0,0,0,0,12,12,4,8,0,
0,0,0,0,0,0,0,126,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,12,12,0,0,0,0,0,0,0,15,25,31,1,
3,2,0,0,0,0,0,0,0,0,0,28,38,38,38,38,38,38,38,38,
28,0,0,0,0,0,8,24,44,76,12,12,12,12,13,13,127,0,0,0,
0,0,0,28,54,38,6,6,12,24,48,124,126,0,0,0,0,0,28,38,
6,6,6,28,6,6,6,6,60,0,0,0,0,0,36,36,38,38,38,62,
6,6,6,6,6,0,0,0,0,0,0,30,34,32,32,60,6,2,2,6,
60,0,0,0,0,0,0,30,50,48,48,60,62,34,34,34,28,0,0,0,
0,0,0,62,6,6,6,12,8,24,16,16,16,0,0,0,0,0,0,28,
38,38,38,28,38,38,38,38,28,0,0,0,0,0,0,28,36,38,38,30,
6,6,6,38,28,0,0,0,0,0,0,0,0,24,24,0,0,24,24,0,
0,0,0,0,0,0,0,62,2,2,6,12,8,24,16,16,16,0,0,0,
0,0,0,2,18,18,16,127,16,16,16,19,124,80,0,0,0,0,0,56,
46,35,47,56,96,64,64,192,128,0,0,0,0,0,0,0,0,64,48,12,
6,6,12,48,64,0,0,0,0,0,224,48,12,6,2,2,2,2,4,24,
112,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
0,0,24,56,28,44,44,38,70,126,67,131,199,0,0,0,0,0,252,102,
102,102,124,102,99,99,99,102,252,0,0,0,0,0,62,99,194,192,192,192,
192,192,193,99,62,0,0,0,0,0,248,102,99,99,99,99,99,99,99,102,
248,0,0,0,0,0,255,99,97,100,124,100,96,96,97,99,255,0,0,0,
0,0,255,99,97,96,104,120,104,96,96,96,240,0,0,0,0,0,62,99,
194,192,192,192,207,195,195,101,57,0,0,0,0,0,195,195,195,195,195,255,
195,195,195,195,195,0,0,0,0,0,60,24,24,24,24,24,24,24,24,24,
60,0,0,0,0,0,31,6,6,6,6,6,6,6,70,230,124,0,0,0,
0,0,231,102,108,108,120,108,108,102,102,99,227,0,0,0,0,0,240,96,
96,96,96,96,96,96,97,99,255,0,0,0,0,0,195,195,231,255,255,219,
219,195,195,195,195,0,0,0,0,0,195,195,227,227,243,219,207,199,199,195,
195,0,0,0,0,0,60,102,195,195,195,195,195,195,195,102,60,0,0,0,
0,0,252,102,99,99,99,102,124,96,96,96,240,0,0,0,0,0,60,102,
195,195,195,195,195,195,219,110,60,12,7,0,0,0,252,102,99,99,99,102,
124,102,102,99,227,0,0,0,0,0,126,195,194,96,56,28,6,3,67,195,
126,0,0,0,0,0,255,219,153,24,24,24,24,24,24,24,60,0,0,0,
0,0,195,195,195,195,195,195,195,195,195,102,60,0,0,0,0,0,227,193,
98,98,98,52,52,52,24,24,24,0,0,0,0,0,195,195,195,219,219,219,
219,219,126,102,102,0,0,0,0,0,99,227,54,54,28,28,28,54,54,99,
227,0,0,0,0,0,227,193,98,98,52,60,24,24,24,24,60,0,0,0,
0,0,255,198,134,12,12,24,48,48,97,99,255,0,0,0,0,60,48,48,
48,48,48,48,48,48,48,48,48,48,60,0,0,0,192,96,96,48,48,24,
24,12,12,6,6,3,0,0,0,60,12,12,12,12,12,12,12,12,12,12,
12,12,60,0,0,24,60,102,195,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,255,0,0,0,0,0,62,
65,29,37,37,37,37,37,37,30,0,0,0,0,0,0,0,0,124,6,30,
102,198,198,198,123,0,0,0,0,0,96,224,96,120,102,99,99,99,99,102,
124,0,0,0,0,0,0,0,0,62,99,194,192,192,192,99,62,0,0,0,
0,0,14,6,6,14,54,102,198,198,198,198,123,0,0,0,0,0,0,0,
0,60,98,195,255,192,192,99,62,0,0,0,0,0,60,102,98,96,248,96,
96,96,96,96,240,0,0,0,0,0,0,0,0,59,102,102,102,102,108,56,
96,254,195,126,0,0,96,224,96,110,115,99,99,99,99,99,99,0,0,0,
0,0,24,24,0,24,56,24,24,24,24,24,60,0,0,0,0,0,6,6,
0,6,14,6,6,6,6,6,38,102,102,60,0,0,96,224,96,103,108,108,
120,108,102,102,227,0,0,0,0,0,56,24,24,24,24,24,24,24,24,24,
60,0,0,0,0,0,0,0,0,246,219,219,219,219,219,195,195,0,0,0,
0,0,0,0,0,110,243,99,99,99,99,99,99,0,0,0,0,0,0,0,
0,60,102,195,195,195,195,102,60,0,0,0,0,0,0,0,0,220,102,99,
99,99,99,118,108,96,96,240,0,0,0,0,0,59,102,198,198,198,198,110,
54,6,6,7,0,0,0,0,0,110,243,99,96,96,96,96,240,0,0,0,
0,0,0,0,0,124,198,192,112,28,6,198,124,0,0,0,0,0,16,48,
48,254,48,48,48,48,48,51,30,0,0,0,0,0,0,0,0,102,230,102,
102,102,102,102,59,0,0,0,0,0,0,0,0,227,193,98,98,52,52,24,
24,0,0,0,0,0,0,0,0,195,195,219,219,219,255,102,102,0,0,0,
0,0,0,0,0,195,102,60,24,24,60,102,195,0,0,0,0,0,0,0,
0,103,227,51,51,27,27,14,14,12,24,112,0,0,0,0,0,254,198,12,
24,48,96,198,254,0,0,0,0,14,24,24,24,24,16,112,16,24,24,24,
24,14,0,0,0,0,24,24,24,24,24,0,0,24,24,24,24,24,0,0,
0,112,24,24,24,24,8,14,8,24,24,24,24,112,0,0,0,0,118,220,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,24,60,102,
102,195,195,255,0,0,0,0,0,17,21,37,63,41,2,2,4,12,8,16,
112,128,0,0,0,0,55,97,65,135,193,71,32,24,8,8,16,240,0,0,
0,0,24,24,20,52,38,34,38,164,188,160,64,97,63,0,0,48,80,16,
17,17,122,2,14,242,2,2,2,6,252,0,0,0,32,32,32,96,239,64,
64,255,64,64,64,63,0,0,0,0,0,0,12,4,4,31,4,4,15,4,
12,0,0,0,0,0,28,4,4,8,24,0,8,60,48,32,32,120,0,0,
0,0,0,48,32,32,126,32,32,16,30,0,0,0,0,0,0,0,28,18,
18,20,28,16,48,8,8,24,255,0,0,0,0,0,0,16,126,0,0,0,
1,1,1,3,12,112,0,0,0,0,0,60,102,66,66,96,48,24,136,249,
113,2,12,0,24,124,196,132,196,116,15,4,6,2,2,2,4,8,0,0,
0,0,0,2,18,18,16,127,16,16,16,19,124,80,0,0,0,0,0,0,
0,24,20,16,16,16,124,48,32,32,0,0,0,0,0,56,46,35,47,56,
96,64,64,192,128,0,0,0,0,0,224,48,12,6,2,2,2,2,4,24,
112,0,0,0,0,0,28,34,34,34,34,28,34,34,34,34,34,0,0,0,
0,0,28,32,32,32,32,32,28,34,34,34,28,0,0,0,0,0,24,36,
36,36,24,36,34,34,34,34,28,0,0,0,0,0,30,32,32,32,32,0,
32,32,32,32,32,0,0,0,65,34,28,34,34,34,34,34,34,28,34,34,
34,99,65,65,8,8,28,40,32,32,40,28,40,32,40,40,30,8,0,0,
0,0,28,32,32,167,161,156,160,161,39,32,30,0,0,0,0,0,99,85,
42,42,28,0,28,42,42,62,34,0,0,0,0,0,92,66,66,114,82,124,
82,114,66,66,92,0,0,0,0,0,34,34,38,42,42,0,42,42,42,50,
34,0,0,0,0,0,34,110,36,40,48,255,56,36,34,34,34,0,0,0,
0,0,4,10,18,34,34,0,34,34,34,34,34,0,0,0,0,0,34,34,
54,42,42,8,34,34,34,34,34,0,0,0,0,0,8,42,42,42,42,28,
34,34,34,34,34,0,0,0,0,0,28,34,34,34,34,0,34,34,34,34,
28,0,0,0,0,0,28,34,34,34,34,0,34,34,34,34,34,0,0,0,
0,0,28,34,34,34,34,28,32,32,32,32,32,0,0,0,128,64,62,32,
32,32,33,254,33,32,32,32,62,64,128,0,0,0,62,0,8,8,8,0,
8,8,8,8,8,0,0,0,0,0,62,0,8,8,8,0,8,8,8,8,
8,0,127,8,0,0,28,42,42,42,42,28,8,8,255,8,8,0,0,0,
0,0,34,34,20,28,8,127,8,28,52,34,34,0,0,0,0,0,34,34,
34,34,34,0,34,34,34,29,1,129,127,0,0,0,34,34,34,34,28,2,
2,127,2,2,12,0,0,0,0,0,34,34,34,42,42,127,42,42,42,34,
28,0,0,0,0,0,34,34,34,42,42,0,42,42,42,34,29,1,1,0,
0,255,32,32,32,32,32,28,34,34,34,34,28,0,0,0,0,0,34,34,
34,34,34,24,42,42,42,42,26,0,0,0,0,0,32,32,32,32,32,28,
34,34,34,34,28,0,0,0,0,0,28,2,2,2,2,2,28,50,34,50,
28,0,0,0,0,255,76,82,82,82,82,255,82,82,82,82,255,76,0,0,
0,0,28,2,2,2,30,18,18,18,18,18,34,0,0,0,34,136,34,136,
34,136,34,136,34,136,34,136,34,136,34,136,85,170,85,170,85,170,85,170,
85,170,85,170,85,170,85,170,221,119,221,119,221,119,221,119,221,119,221,119,
221,119,221,119,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,
24,24,24,24,24,24,56,248,56,24,24,24,24,24,24,24,24,24,24,24,
24,56,248,56,248,56,24,24,24,24,24,24,36,36,36,36,36,36,100,196,
100,36,36,36,36,36,36,36,0,0,0,0,0,0,0,252,108,36,36,36,
36,36,36,36,0,0,0,0,0,0,240,56,248,56,24,24,24,24,24,24,
36,36,36,36,36,100,196,4,196,100,36,36,36,36,36,36,36,36,36,36,
36,36,36,36,36,36,36,36,36,36,36,36,0,0,0,0,0,0,248,12,
196,100,36,36,36,36,36,36,36,36,36,36,36,100,196,12,248,0,0,0,
0,0,0,0,36,36,36,36,36,36,108,248,0,0,0,0,0,0,0,0,
24,24,24,24,24,56,248,56,240,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,192,96,48,24,24,24,24,24,24,24,24,24,24,24,12,6,3,
0,0,0,0,0,0,0,0,24,24,24,24,24,24,60,255,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,255,60,24,24,24,24,24,24,24,
24,24,24,24,24,24,28,31,28,24,24,24,24,24,24,24,0,0,0,0,
0,0,0,255,0,0,0,0,0,0,0,0,24,24,24,24,24,24,60,255,
60,24,24,24,24,24,24,24,24,24,24,24,24,28,31,28,31,28,24,24,
24,24,24,24,36,36,36,36,36,36,38,35,38,36,36,36,36,36,36,36,
36,36,36,36,36,38,51,24,15,0,0,0,0,0,0,0,0,0,0,0,
0,0,15,24,51,38,36,36,36,36,36,36,36,36,36,36,36,102,195,0,
255,0,0,0,0,0,0,0,0,0,0,0,0,0,255,0,195,102,36,36,
36,36,36,36,36,36,36,36,36,38,35,32,35,38,36,36,36,36,36,36,
0,0,0,0,0,0,255,0,255,0,0,0,0,0,0,0,36,36,36,36,
36,102,195,24,195,102,36,36,36,36,36,36,24,24,24,24,24,60,231,0,
255,0,0,0,0,0,0,0,36,36,36,36,36,36,126,255,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,255,0,231,60,24,24,24,24,24,24,
0,0,0,0,0,0,0,255,126,36,36,36,36,36,36,36,36,36,36,36,
36,36,54,31,0,0,0,0,0,0,0,0,24,24,24,24,24,28,31,28,
15,0,0,0,0,0,0,0,0,0,0,0,0,0,15,28,31,28,24,24,
24,24,24,24,0,0,0,0,0,0,0,31,54,36,36,36,36,36,36,36,
36,36,36,36,36,36,102,195,102,36,36,36,36,36,36,36,24,24,24,24,
24,60,231,0,231,60,24,24,24,24,24,24,24,24,24,24,24,48,96,192,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,6,12,24,24,
24,24,24,24,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,240,240,240,240,
240,240,240,240,240,240,240,240,240,240,240,240,15,15,15,15,15,15,15,15,
15,15,15,15,15,15,15,15,255,255,255,255,255,255,255,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,92,230,99,99,99,99,118,108,96,96,240,
0,0,0,0,0,63,99,192,192,192,192,99,62,0,0,0,0,0,0,0,
0,255,219,24,24,24,24,24,60,0,0,0,0,0,0,0,0,99,225,50,
50,26,28,12,12,8,104,112,0,0,24,56,24,110,219,219,219,219,219,219,
110,8,24,60,0,0,0,0,0,195,102,60,24,24,60,102,195,0,0,0,
0,0,0,0,0,198,198,198,198,198,198,198,255,3,0,0,0,0,0,0,
0,99,227,99,99,103,59,3,7,0,0,0,0,0,0,0,0,195,219,219,
219,219,219,219,255,0,0,0,0,0,0,0,0,198,198,214,214,214,214,214,
255,3,0,0,0,0,0,0,0,240,176,54,59,51,51,51,126,0,0,0,
0,0,0,0,0,195,195,243,219,219,219,219,243,0,0,0,0,0,0,0,
0,240,96,120,102,102,102,102,248,0,0,0,0,0,0,0,0,252,198,3,
59,15,3,230,60,0,0,0,0,0,0,0,0,206,219,219,251,219,219,219,
206,0,0,0,0,0,0,0,0,123,198,198,198,110,54,102,199,0,0,0,
102,0,255,99,97,100,124,100,96,96,97,99,255,0,0,0,0,0,0,54,
0,60,98,195,255,192,192,99,62,0,0,0,102,0,255,99,97,100,124,100,
96,96,97,99,255,0,0,0,0,0,12,24,48,96,192,96,48,24,12,0,
124,0,0,0,0,14,27,27,24,24,24,24,24,24,24,24,24,24,24,24,
24,24,24,24,24,24,24,24,24,24,216,248,112,0,0,0,0,0,0,0,
0,24,24,0,126,0,24,24,0,0,0,0,0,0,0,0,0,118,220,0,
118,220,0,0,0,0,0,0,0,56,108,108,108,56,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,24,24,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,15,12,12,
12,12,12,12,12,204,108,60,28,12,4,0,216,108,108,108,108,108,108,0,
0,0,0,0,0,0,0,0,112,200,24,48,96,200,184,0,0,0,0,0,
0,0,0,0,0,0,0,124,124,124,124,124,124,124,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
Var
  e:Integer;
  SegScr:Word;
  OfsScr:Word;
  screen:Array [0..4095] of Byte absolute Font;
Begin
      ofsscr:=ofs(screen);
      segscr:=seg(screen);
    Asm
      push bp
      mov ax,segscr
      mov es,ax
      mov bp,ofsscr
      mov bx,1000h
      xor dx,dx
      mov cx,256
      mov ax,1100h
      int 10h
      pop bp
      mov ah,1
      mov cx,1000h
      int 10h
    End;
End;
Procedure Restore;
Begin
  asm
    mov ax,3
    int 10h
  End;
End;
Procedure Cursor(i:Byte);
Var j:Byte;
Begin
  TextAttr:=$0A;
  j:=1;
  While (j<=i) and Not KeyPressed Do
    Begin
      TextAttr:=$0A;
      Write(#64);
      Delay(2300);
      Write(#8);
      TextAttr:=$02;
      Write(#64);
      Delay(2800);
      Write(#8);
      TextAttr:=$00;
      Write(#64);
      Write(#8);
      inc(j);
    End;
End;
Procedure Prints(s:String;Color:Byte);
Var i:Byte;{����� � ��� ��}
Begin
  i:=1;
  While (i<=Length(s)) and Not KeyPressed Do
    Begin
      TextAttr:=Color;
      Write(S[i]);
      Write(#64);
      Delay(900);
      Write(#8);
      inc(i);
    End;
  Write(#32);
End;
Procedure Pr(s:String);
Var i:Byte;{������}
Begin
  i:=1;
  While (i<=Length(s)) and Not KeyPressed Do
    Begin
      TextAttr:=$02;
      Write(S[i]);
      TextAttr:=$0A;
      Write(#64);
      Delay(600);
      Write(#8);
      If (ord (s[i])-ord(s[i+1])>0) and (ord (s[i])-ord(s[i+1])<6) Then
        Cursor(ord(s[i])-ord(s[i+1])-1)
      Else Delay(600+Random(2600));
      inc(i);
    End;
End;
Procedure wr(s:String);
Var i:Byte;{��� ��� � ���᪨� �㪢}
Begin
  For i:=1 To Length(S) Do
    Begin
      TextAttr:=$02;
      If (s[i]=' ') or (s[i]=':') or (s[i]='.') Then Write(s[i])
      Else Write(Chr(ord(s[i])+16));
      TextAttr:=$0A;
      Write(#64);
      Delay(800);
      Write(#8);
    End;
End;
Procedure Line(i:Byte);
Var j:Byte;{1 ����� � ����}
Begin
  For j:=1 To Random(24)+1 Do
    Begin
      scr[j,i].at:=$02;
      scr[j,i].Ch:=Chr(Random(32));
    End;
End;
Procedure ScrollUp(i:Byte);
Var j:Byte;
    Ch:Char;
    at:Byte;
Begin
  For j:=1 To Random(24)+1 Do
    Begin
      at:=scr[j,i].at;
      ch:=scr[j,i].ch;
      scr[j,i].at:=$02;
      scr[j,i]:=scr[j+1,i];
    End;
End;
Procedure ScrollDn(i:Byte);
Var j:Byte;
Begin
  For j:=Random(24)+1 DownTo 1 Do
    Begin
      If j-1>0 Then Begin
        scr[j,i].at:=$02;
        scr[j,i]:=scr[j-1,i];
      End;
    End;
End;
Const
  dig:array [1..10] of Byte=
  (5,5,5,9,7,3,2,2,0,7);
Var j,i,c:Byte;
    s:String;
    Ex:Boolean;
    count:LongInt;
    RealDig:array [1..10] of Byte;
    h:Byte;
Label Start;
Begin
  ClrScr;
  HiddenCursor;
  LoadFont;
Start:
  For count:=1 To 2000 Do
    Begin
      GotoXY(Random(80),Random(25));
      Write(#32);
      Delay(15);
    End;
  Randomize;
  GotoXY(30,12);
  Pr('T h e  M a t r i x ');
  Cursor(8);
  ClrScr;
  TextAttr:=$02;
  GotoXY(25,12);
  Wr('����� ���������: ������� �.�.');
  Cursor(2);
  GotoXY(48,14);
  Pr('2001 ');
  Cursor(3);
  ClrScr;
  While KeyPressed Do ReadKey;
  Cursor(3);
  TextAttr:=$02;
  s:='Call trans opt:';
  Prints(s,$02);
  Write(#8);
  Cursor(1);
  WriteLn;
  textAttr:=$0A;
  Write('> ');
  s:='received.';
  Prints(s,$02);
  Write(#8);
  Cursor(1);
  WriteLn;
  s:='02-19-96  13:25:18  Rec:Log';
  Prints(s,$02);
  Write(#8);
  Cursor(1);
  WriteLn;
  textAttr:=$0A;
  Write('> ');
  s:='Searching...';
  Prints(s,$02);
  Write(#8);
  Cursor(1);
  WriteLn;
  s:='Found: ';
  Prints(s,$0A);
  s:='X X X - X X X - X X X X ';
  Prints(s,$02);
  Ex:=False;
  i:=0;
  j:=1;
  c:=0;
  While not Ex and not KeyPressed Do
    Begin
      Window(1,6,80,25);
      If j>20 Then j:=1;
      GotoXY(2,j);
      TextAttr:=$02;
      Write('Num:.. ');
      For h:=(i-c+1) To 10 Do
        RealDig[h]:=Random(9);
      Write(RealDig[1],' ',RealDig[2],' ',RealDig[3],' - ',RealDig[4],' ',
            RealDig[5],' ',RealDig[6],' - ',RealDig[7],' ',RealDig[8],' ',
            RealDig[9],' ',RealDig[10]);
            Delay(50);
      If Random(975)=4 Then
        Begin
          inc(i);
          Window(1,5,80,25);
          GotoXY(1,1);
          TextAttr:=$0A;
          Write('Found:');
          GotoXY(i*2+7,1);
          If i=12 Then Ex:=True;
          If (i=3) or (i=7) Then inc(i);
          If i=4 Then c:=1
          Else If i=8 Then c:=2;
          TextAttr:=$0A;
          Write(#64);
          Delay(1000);
          Write(#8);
          Write(dig[i-c]);
          RealDig[i-c]:=Dig[i-c];
        End;
       inc(j);
    End;
  TextAttr:=$02;
  For i:=2 To 21 Do
    Begin
      GotoXY(31,i);
      Write(dig[10]);
    End;
  GotoXY(40,1);Cursor(22);
  Window(1,1,80,25);
  ClrScr;
  Cursor(2);
  s:='Wake up..';
  Pr(s);
  Cursor(6);
  ClrScr;
  s:='Hello Neo...';
  Pr(s);
  Cursor(5);
  ClrScr;
  s:='The Matrix has got you...';
  Pr(s);
  Cursor(4);
  ClrScr;
  s:='Follow the white rabbit...';
  Pr(s);
  Cursor(4);
  ClrScr;
  s:='Knock, Knock..';
  Pr(s);
  Pr('   ');
  Cursor(25);
  ClrScr;
  count:=0;
  While not KeyPressed Do
    Begin
      If Random(50)=1 Then Line(Random(79)+1);
      If Random(6)=2 Then ScrollUp(Random(79)+1);
      If Random(14)=3 Then scr[Random(25),Random(79)+1].at:=$0A;
      Delay(20);
      If Random(3)=2 Then ScrollDn(Random(79)+1);
      TextAttr:=$02;
      If Random(4)=1 Then
        Begin
          GotoXY(Random(79),25);
          Write(#32);
          GotoXY(Random(80),Random(25));
          Write(#32);
        End;
      If Random(163)=1 Then
        Begin
          GotoXY(80,Random(25));
          Write(Chr(Random(15)+127));
          GotoXY(80,Random(24)+1);
          Write(#32);
        End;
       If Random(163)=1 Then
        Begin
          GotoXY(Random(79),25);
          Write(Chr(Random(15)+127));
        End;
       If Random(41000)=1 Then
        Begin
          GotoXY(1,25);
          Write('E-Mail: al_abrarov`mail.ru');
        End;
      inc(Count);
      if count=70500 Then Goto Start;
    End;
  ReadKey;
  Restore;
End.
