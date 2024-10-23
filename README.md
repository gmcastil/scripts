Shell scripts for commonly used operations, mostly targeting ECAD tools and FPGA
development.

# Files
`setup_questasim.sh` - Sets up the current interactive bash session for
QuestaSim

`setup_quartus.sh` - Sets up the current interactive bash session for Intel
Quartus

`setup_modelsim.sh` - Sets up the current interactive bash session to use the
32-bit FPGA Starter Edition of ModelSim. This tool is notorious for requiring
some hacks to get to work, so it is unlikely to work out of the box without
modification.

`run_vivado` - Sets up the current interactive bash session for the Xilinx
Vivado Design Suite and then launches Vivado in GUI mode as a background process
with useful debugging information dumped out to the console.

`vsim_ila` - Convert a VCD file from a Vivado ILA capture to a WLF file and then
opens it in `vsim` for viewing.

`start_hw_server` - Starts the Vivado hardware manager in daemon mode as a
background process so that locally connected devices are visible to other Vivado
instances on the network. Highly useful for working with development boards
connected to remote machines.

`compile_simlibs` - Builds Xilinx simulation libraries for several versions of
Vivado using various versions of QuestaSim or ModelSim. Quite a detailed
procedure, so make sure to read the descriptions. In particular, note how it
determines which version of tools and source code to use.

`create_gstreamer_ctags` - Creates GStreamer `tags` files for use with tools
like `Vim` and `universal-ctags`.

`common.sh` - Common shell functions.

`fix_pprdir` - Fixes the project file path value that gets constantly hard-coded
by Vivado after opening projects.

