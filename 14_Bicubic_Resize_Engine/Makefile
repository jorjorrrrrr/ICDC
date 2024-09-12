


run_all:
	vcs -full64 -kdb -R -sverilog ./rtl/tb.sv ./rtl/Bicubic.v ./rtl/multi_div.v ./rtl/interpolation1d.v ./rtl/sr.v -v ./rtl/ImgROM.v -v ./rtl/ResultSRAM.v +access+r +vcs+fsdbon +fsdb+mda +fsdbfile+Bicubic.fsdb +notimingcheck

run:
	vcs -full64 -kdb -R -sverilog ./rtl/tb.sv ./rtl/Bicubic.v ./rtl/multi_div.v ./rtl/interpolation1d.v ./rtl/sr.v -v ./rtl/ImgROM.v -v ./rtl/ResultSRAM.v +define+P1 +access+r +vcs+fsdbon +fsdb+mda +fsdbfile+Bicubic.fsdb +notimingcheck
	#vcs -full64 -kdb -R -sverilog ./rtl/tb.sv ./rtl/Bicubic.v ./rtl/multi_div.v ./rtl/interpolation1d.v ./rtl/sr.v -v ./rtl/ImgROM.v -v ./rtl/ResultSRAM.v +define+P2 +access+r +vcs+fsdbon +fsdb+mda +fsdbfile+Bicubic.fsdb +notimingcheck
	#vcs -full64 -kdb -R -sverilog ./rtl/tb.sv ./rtl/Bicubic.v ./rtl/multi_div.v ./rtl/interpolation1d.v ./rtl/sr.v -v ./rtl/ImgROM.v -v ./rtl/ResultSRAM.v +define+P3 +access+r +vcs+fsdbon +fsdb+mda +fsdbfile+Bicubic.fsdb +notimingcheck

all: run_all dc post pt clean

post:
	vcs -full64 -kdb -R -sverilog ./rtl/tb.sv ./syn/Bicubic_syn.v +define+SDF +access+r +vcs+fsdbon +fsdb+mda +fsdbfile+Bicubic.fsdb -v ./rtl/ImgROM.v -v ./rtl/ResultSRAM.v -v /cad/process/CBDK_IC_Contest_v2.5/Verilog/tsmc13_neg.v +maxdelays +neg_tchk

dc:
	dc_shell -f ./scripts/dc_syn.tcl

pt:
	pt_shell -f ./scripts/pt_script.tcl

verdi:
	verdi -ssf Bicubic.fsdb &

clean:
	rm -rf Bicubic.fsdb Bicubic.vcd csrc novas_dump.log 	\
			simv simv.daidir ucli.key verdi_config_file		\
			alib-52 *.mr *.pvl *.syn cksum_dir command.log	\
			default.svf parasitics_command.log novas.conf	\
			primetime_px.fsdb  pt_shell_command.log 		\
			novas.rc verdiLog

clean_all: clean
	rm -rf ./syn/*
