
>
Refreshing IP repositories
234*coregenZ19-234h px? 
G
"No user IP repositories specified
1154*coregenZ19-1704h px? 
|
"Loaded Vivado IP repository '%s'.
1332*coregen23
D:/Xilinx/Vivado/2020.2/data/ip2default:defaultZ19-2313h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
add_files: 2default:default2
00:00:012default:default2
00:00:092default:default2
642.9222default:default2
33.7302default:defaultZ17-268h px? 
?
Command: %s
53*	vivadotcl2S
?link_design -top system_top_level_wrapper -part xc7z020clg400-12default:defaultZ4-113h px? 
g
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_12default:defaultZ12-437h px? 
j
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_12default:defaultZ12-434h px? 
V
Loading part %s157*device2#
xc7z020clg400-12default:defaultZ21-403h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0092default:default2
1223.2152default:default2
0.0002default:defaultZ17-268h px? 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
352default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px? 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2020.22default:defaultZ1-479h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0_board.xdc2default:default27
!system_top_level_i/clk_wiz_0/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0_board.xdc2default:default27
!system_top_level_i/clk_wiz_0/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0.xdc2default:default27
!system_top_level_i/clk_wiz_0/inst	2default:default8Z20-848h px? 
?
%Done setting XDC timing constraints.
35*timing2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0.xdc2default:default2
572default:default8@Z38-35h px? 
?
Deriving generated clocks
2*timing2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0.xdc2default:default2
572default:default8@Z38-2h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
get_clocks: 2default:default2
00:00:092default:default2
00:00:162default:default2
1283.3442default:default2
60.1292default:defaultZ17-268h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0.xdc2default:default27
!system_top_level_i/clk_wiz_0/inst	2default:default8Z20-847h px? 
}
Parsing XDC File [%s]
179*designutils2<
&D:/Logic_Synthesis/5/E10/xdc/synth.xdc2default:default8Z20-179h px? 
?
Finished Parsing XDC File [%s]
178*designutils2<
&D:/Logic_Synthesis/5/E10/xdc/synth.xdc2default:default8Z20-178h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0_late.xdc2default:default27
!system_top_level_i/clk_wiz_0/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
?d:/Logic_Synthesis/5/E10/syn/synth_top.gen/sources_1/bd/system_top_level/ip/system_top_level_clk_wiz_0_0/system_top_level_clk_wiz_0_0_late.xdc2default:default27
!system_top_level_i/clk_wiz_0/inst	2default:default8Z20-847h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1283.3442default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2k
W  A total of 1 instances were transformed.
  IOBUF => IOBUF (IBUF, OBUFT): 1 instance 
2default:defaultZ1-111h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
122default:default2
02default:default2
02default:default2
02default:defaultZ4-41h px? 
]
%s completed successfully
29*	vivadotcl2
link_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2!
link_design: 2default:default2
00:00:222default:default2
00:01:092default:default2
1283.3442default:default2
640.4222default:defaultZ17-268h px? 


End Record