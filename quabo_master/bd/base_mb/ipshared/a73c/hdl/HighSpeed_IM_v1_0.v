
`timescale 1 ns / 1 ps

	module HighSpeed_IM_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_AXI_IM_Config
		parameter integer C_S_AXI_IM_Config_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_IM_Config_ADDR_WIDTH	= 32,

		// Parameters of Axi Slave Bus Interface S_AXI_PacketHeader
		parameter integer C_S_AXI_PacketHeader_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_PacketHeader_ADDR_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M_AXI_IM_Config
		parameter  C_M_AXI_IM_Config_START_DATA_VALUE	= 32'hAA000000,
		parameter  C_M_AXI_IM_Config_TARGET_SLAVE_BASE_ADDR	= 32'h44A00000,
		parameter integer C_M_AXI_IM_Config_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_IM_Config_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_IM_Config_TRANSACTIONS_NUM	= 4,
		parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
		//this signal is used to select the configure interface from MB
		//if it's 0, we select master interface from MB, which is used to configure the IM_fifo;
		//if it's 1, we select master interface from hardware, which is used to read data from IM_fifo at high speed.
        //input wire port_sel,
        input wire [28:0] elapsed_time,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S_AXI_IM_Config
		input wire  aclk,
		input wire  aresetn,
		input wire [C_S_AXI_IM_Config_ADDR_WIDTH-1 : 0] s_axi_im_config_awaddr,
		input wire [2 : 0] s_axi_im_config_awprot,
		input wire  s_axi_im_config_awvalid,
		output wire  s_axi_im_config_awready,
		input wire [C_S_AXI_IM_Config_DATA_WIDTH-1 : 0] s_axi_im_config_wdata,
		input wire [(C_S_AXI_IM_Config_DATA_WIDTH/8)-1 : 0] s_axi_im_config_wstrb,
		input wire  s_axi_im_config_wvalid,
		output wire  s_axi_im_config_wready,
		output wire [1 : 0] s_axi_im_config_bresp,
		output wire  s_axi_im_config_bvalid,
		input wire  s_axi_im_config_bready,
		input wire [C_S_AXI_IM_Config_ADDR_WIDTH-1 : 0] s_axi_im_config_araddr,
		input wire [2 : 0] s_axi_im_config_arprot,
		input wire  s_axi_im_config_arvalid,
		output wire  s_axi_im_config_arready,
		output wire [C_S_AXI_IM_Config_DATA_WIDTH-1 : 0] s_axi_im_config_rdata,
		output wire [1 : 0] s_axi_im_config_rresp,
		output wire  s_axi_im_config_rvalid,
		input wire  s_axi_im_config_rready,

		// Ports of Axi Slave Bus Interface S_AXI_PacketHeader
		input wire [C_S_AXI_PacketHeader_ADDR_WIDTH-1 : 0] s_axi_packetheader_awaddr,
		input wire [2 : 0] s_axi_packetheader_awprot,
		input wire  s_axi_packetheader_awvalid,
		output wire  s_axi_packetheader_awready,
		input wire [C_S_AXI_PacketHeader_DATA_WIDTH-1 : 0] s_axi_packetheader_wdata,
		input wire [(C_S_AXI_PacketHeader_DATA_WIDTH/8)-1 : 0] s_axi_packetheader_wstrb,
		input wire  s_axi_packetheader_wvalid,
		output wire  s_axi_packetheader_wready,
		output wire [1 : 0] s_axi_packetheader_bresp,
		output wire  s_axi_packetheader_bvalid,
		input wire  s_axi_packetheader_bready,
		input wire [C_S_AXI_PacketHeader_ADDR_WIDTH-1 : 0] s_axi_packetheader_araddr,
		input wire [2 : 0] s_axi_packetheader_arprot,
		input wire  s_axi_packetheader_arvalid,
		output wire  s_axi_packetheader_arready,
		output wire [C_S_AXI_PacketHeader_DATA_WIDTH-1 : 0] s_axi_packetheader_rdata,
		output wire [1 : 0] s_axi_packetheader_rresp,
		output wire  s_axi_packetheader_rvalid,
		input wire  s_axi_packetheader_rready,

		// Ports of Axi Master Bus Interface M_AXI_IM_Config
		output wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] m_axi_im_config_awaddr,
		output wire [2 : 0] m_axi_im_config_awprot,
		output wire  m_axi_im_config_awvalid,
		input wire  m_axi_im_config_awready,
		output wire [C_M_AXI_IM_Config_DATA_WIDTH-1 : 0] m_axi_im_config_wdata,
		output wire [C_M_AXI_IM_Config_DATA_WIDTH/8-1 : 0] m_axi_im_config_wstrb,
		output wire  m_axi_im_config_wvalid,
		input wire  m_axi_im_config_wready,
		input wire [1 : 0] m_axi_im_config_bresp,
		input wire  m_axi_im_config_bvalid,
		output wire  m_axi_im_config_bready,
		output wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] m_axi_im_config_araddr,
		output wire [2 : 0] m_axi_im_config_arprot,
		output wire  m_axi_im_config_arvalid,
		input wire  m_axi_im_config_arready,
		input wire [C_M_AXI_IM_Config_DATA_WIDTH-1 : 0] m_axi_im_config_rdata,
		input wire [1 : 0] m_axi_im_config_rresp,
		input wire  m_axi_im_config_rvalid,
		output wire  m_axi_im_config_rready,
		
        //Ports of Axi Stream Master Bus INterface M_AXIS
		output wire  m_axis_tvalid,
		output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tkeep,
		output wire  m_axis_tlast,
		input wire  m_axis_tready
	);
// Instantiation of Axi Bus Interface S_AXI_IM_Config
// Instantiation of Axi Bus Interface M_AXI_IM_Config
wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] m_axi_im_config_awaddr_gw;
wire [2 : 0] m_axi_im_config_awprot_gw;
wire  m_axi_im_config_awvalid_gw;
wire  m_axi_im_config_awready_gw;
wire [C_M_AXI_IM_Config_DATA_WIDTH-1 : 0] m_axi_im_config_wdata_gw;
wire [C_M_AXI_IM_Config_DATA_WIDTH/8-1 : 0] m_axi_im_config_wstrb_gw;
wire  m_axi_im_config_wvalid_gw;
wire  m_axi_im_config_wready_gw;
wire [1 : 0] m_axi_im_config_bresp_gw;
wire  m_axi_im_config_bvalid_gw;
wire  m_axi_im_config_bready_gw;
wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] m_axi_im_config_araddr_gw;
wire [2 : 0] m_axi_im_config_arprot_gw;
wire  m_axi_im_config_arvalid_gw;
wire  m_axi_im_config_arready_gw;
wire [C_M_AXI_IM_Config_DATA_WIDTH-1 : 0] m_axi_im_config_rdata_gw;
wire [1 : 0] m_axi_im_config_rresp_gw;
wire  m_axi_im_config_rvalid_gw;
wire  m_axi_im_config_rready_gw;
//the master starts to read, when a risging edge of start_to_read is detected.
wire start_to_read;
//the ready_to_read signal only occurs one clock, when the data is ready to read.
(* keep = "true" *)wire ready_to_read;

wire [1:0]port_sel;
wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] araddr_from_user;
(* keep = "true" *)wire [C_M_AXI_IM_Config_DATA_WIDTH-1 : 0] rdata_to_user;
	HighSpeed_IM_v1_0_M_AXI_IM_ReadData # ( 
		.C_M_START_DATA_VALUE(C_M_AXI_IM_Config_START_DATA_VALUE),
		.C_M_TARGET_SLAVE_BASE_ADDR(C_M_AXI_IM_Config_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_ADDR_WIDTH(C_M_AXI_IM_Config_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_M_AXI_IM_Config_DATA_WIDTH),
		.C_M_TRANSACTIONS_NUM(C_M_AXI_IM_Config_TRANSACTIONS_NUM)
	) HighSpeed_IM_v1_0_M_AXI_IM_ReadData_inst (
		.M_AXI_ACLK(aclk),
		.M_AXI_ARESETN(aresetn),
		.M_AXI_AWADDR(m_axi_im_config_awaddr_gw),
		.M_AXI_AWPROT(m_axi_im_config_awprot_gw),
		.M_AXI_AWVALID(m_axi_im_config_awvalid_gw),
		.M_AXI_AWREADY(m_axi_im_config_awready_gw),
		.M_AXI_WDATA(m_axi_im_config_wdata_gw),
		.M_AXI_WSTRB(m_axi_im_config_wstrb_gw),
		.M_AXI_WVALID(m_axi_im_config_wvalid_gw),
		.M_AXI_WREADY(m_axi_im_config_wready_gw),
		.M_AXI_BRESP(m_axi_im_config_bresp_gw),
		.M_AXI_BVALID(m_axi_im_config_bvalid_gw),
		.M_AXI_BREADY(m_axi_im_config_bready_gw),
		.M_AXI_ARADDR(m_axi_im_config_araddr_gw),
		.M_AXI_ARPROT(m_axi_im_config_arprot_gw),
		.M_AXI_ARVALID(m_axi_im_config_arvalid_gw),
		.M_AXI_ARREADY(m_axi_im_config_arready_gw),
		.M_AXI_RDATA(m_axi_im_config_rdata_gw),
		.M_AXI_RRESP(m_axi_im_config_rresp_gw),
		.M_AXI_RVALID(m_axi_im_config_rvalid_gw),
		.M_AXI_RREADY(m_axi_im_config_rready_gw),
		//user port
		.start_to_read(start_to_read),
		.ready_to_read(ready_to_read),
		.araddr_from_user(araddr_from_user),
		.rdata_to_user(rdata_to_user)
	);

//the axi interface connect to IM_fifo is selected by port_sel 
assign m_axi_im_config_awaddr       = port_sel? m_axi_im_config_awaddr_gw   : s_axi_im_config_awaddr;       //input
assign m_axi_im_config_awprot       = port_sel? m_axi_im_config_awprot_gw   : s_axi_im_config_awprot;       //input   
assign m_axi_im_config_awvalid      = port_sel? m_axi_im_config_awvalid_gw  : s_axi_im_config_awvalid;      //input 
assign m_axi_im_config_wdata        = port_sel? m_axi_im_config_wdata_gw    : s_axi_im_config_wdata;        //input 
assign m_axi_im_config_wstrb        = port_sel? m_axi_im_config_wstrb_gw    : s_axi_im_config_wstrb;        //input
assign m_axi_im_config_wvalid       = port_sel? m_axi_im_config_wvalid_gw   : s_axi_im_config_wvalid;       //input
assign m_axi_im_config_bready       = port_sel? m_axi_im_config_bready_gw   : s_axi_im_config_bready;       //input
assign m_axi_im_config_araddr       = port_sel? m_axi_im_config_araddr_gw   : s_axi_im_config_araddr;       //input
assign m_axi_im_config_arprot       = port_sel? m_axi_im_config_arprot_gw   : s_axi_im_config_arprot;       //input
assign m_axi_im_config_arvalid      = port_sel? m_axi_im_config_arvalid_gw  : s_axi_im_config_arvalid;      //input   
assign m_axi_im_config_rready       = port_sel? m_axi_im_config_rready_gw   : s_axi_im_config_rready;       //input
  
assign s_axi_im_config_awready      = m_axi_im_config_awready;                                              //output
assign m_axi_im_config_awready_gw   = m_axi_im_config_awready;

assign s_axi_im_config_wready       = m_axi_im_config_wready;                                               //output
assign m_axi_im_config_wready_gw    = m_axi_im_config_wready;

assign s_axi_im_config_bresp        = m_axi_im_config_bresp;                                                //output
assign m_axi_im_config_bresp_gw     = m_axi_im_config_bresp;

assign s_axi_im_config_bvalid       = m_axi_im_config_bvalid;                                               //output
assign m_axi_im_config_bvalid_gw    = m_axi_im_config_bvalid;

assign s_axi_im_config_arready      = m_axi_im_config_arready;                                              //output
assign m_axi_im_config_arready_gw   = m_axi_im_config_arready;

assign s_axi_im_config_rdata        = m_axi_im_config_rdata;                                                //output
assign m_axi_im_config_rdata_gw     = m_axi_im_config_rdata;

assign s_axi_im_config_rresp        = m_axi_im_config_rresp;                                                //output
assign m_axi_im_config_rresp_gw     = m_axi_im_config_rresp;

assign s_axi_im_config_rvalid       = m_axi_im_config_rvalid;                                               //output
assign m_axi_im_config_rvalid_gw    = m_axi_im_config_rvalid;

// Instantiation of Axi Bus Interface S_AXI_PacketHeader
//The register map is as follow:
//reg0: config reg, bit0--we;
//                  bit1--port_sel_16;
//                  bit2--port_sel_8;
//                  bit31-bit3--reserved;
//reg1: waddr reg,  bit4-bit0--waddr;
//                  bit31-bit5--reserved;
//reg2: wdata;
//reg3: rdata,which is used for checking we write data correctly.
//reg4: hs_im_state, bit27-bit0--hs_im_state for 16-bit mode or 8-bit mode;
//                   it depends on port_sel;
//                  bit31-bit28--reserved
wire ram_we;
wire [4:0]  ram_waddr;
wire [31:0] ram_wdata;
wire [31:0] ram_rdata;
wire [27:0] hs_im_state;
wire [7:0]  acq_mode;
	HighSpeed_IM_v1_0_S_AXI_PacketHeader # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_PacketHeader_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_PacketHeader_ADDR_WIDTH)
	) HighSpeed_IM_v1_0_S_AXI_PacketHeader_inst (
		.S_AXI_ACLK(aclk),
		.S_AXI_ARESETN(aresetn),
		.S_AXI_AWADDR(s_axi_packetheader_awaddr),
		.S_AXI_AWPROT(s_axi_packetheader_awprot),
		.S_AXI_AWVALID(s_axi_packetheader_awvalid),
		.S_AXI_AWREADY(s_axi_packetheader_awready),
		.S_AXI_WDATA(s_axi_packetheader_wdata),
		.S_AXI_WSTRB(s_axi_packetheader_wstrb),
		.S_AXI_WVALID(s_axi_packetheader_wvalid),
		.S_AXI_WREADY(s_axi_packetheader_wready),
		.S_AXI_BRESP(s_axi_packetheader_bresp),
		.S_AXI_BVALID(s_axi_packetheader_bvalid),
		.S_AXI_BREADY(s_axi_packetheader_bready),
		.S_AXI_ARADDR(s_axi_packetheader_araddr),
		.S_AXI_ARPROT(s_axi_packetheader_arprot),
		.S_AXI_ARVALID(s_axi_packetheader_arvalid),
		.S_AXI_ARREADY(s_axi_packetheader_arready),
		.S_AXI_RDATA(s_axi_packetheader_rdata),
		.S_AXI_RRESP(s_axi_packetheader_rresp),
		.S_AXI_RVALID(s_axi_packetheader_rvalid),
		.S_AXI_RREADY(s_axi_packetheader_rready),
		.ram_we(ram_we),
		.ram_waddr(ram_waddr),
		.ram_wdata(ram_wdata),
		.ram_rdata(ram_rdata),
		.hs_im_state({4'b0,hs_im_state}),
		.port_sel(port_sel),
		.acq_mode(acq_mode)
	);
	
//ram_dpra is generated by state machine, for getting packets header from the ram
//ram_qdpo is stored at the address location specified by ram_dpra[4:0] appears at this port
wire [4:0] ram_dpra;
wire [31:0] ram_qdpo;
dist_mem_gen_0 ram (
  .a(ram_waddr),                // input wire [4 : 0] a
  .d(ram_wdata),                // input wire [31 : 0] d
  .dpra(ram_dpra),              // input wire [4 : 0] dpra
  .clk(aclk),                   // input wire clk
  .we(ram_we),                  // input wire we
  .spo(ram_rdata),              // output wire [31 : 0] qspo
  .dpo(ram_qdpo)                // output wire [31 : 0] qdpo
);
	
// User logic ends
//16 bit mode
//these signals are for 16bit mode
wire [31:0] m_axis_tdata_16;
wire m_axis_tvalid_16;
wire [3:0] m_axis_tkeep_16;
wire m_axis_tlast_16;
wire start_to_read_16;
wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] araddr_from_user_16;
wire [27:0] hs_im_state_16;
wire [4:0] ram_dpra_16;
wire port_sel_16;
assign port_sel_16 = port_sel[0:0];
StateMachine_16#(
    .C_M_AXI_IM_Config_ADDR_WIDTH(C_M_AXI_IM_Config_ADDR_WIDTH),
    .C_M_AXI_IM_Config_DATA_WIDTH(C_M_AXI_IM_Config_DATA_WIDTH)
)StateMachine0(
    .aclk(aclk),                            //input wire 
    .aresetn(aresetn),                      //input wire 
    //elapsed_time
    .elapsed_time(elapsed_time),            //input wire 
    //port_sel
    .port_sel(port_sel_16),                    //input wire 
    //hs_state
    .hs_im_state(hs_im_state_16),           //output wire 
    //ram
    .ram_qdpo(ram_qdpo),                    //input wire
    .ram_dpra(ram_dpra_16),                 //output wire
    //acq_mode
    .acq_mode(acq_mode),                    //input wire
    //axis interface
    .m_axis_tvalid(m_axis_tvalid_16),       //output reg 
    .m_axis_tdata(m_axis_tdata_16),         //output reg
    .m_axis_tkeep(m_axis_tkeep_16),         //output reg
    .m_axis_tlast(m_axis_tlast_16),         //output reg 
    .m_axis_tready(m_axis_tready),          //input wire
    //read from IM_fifo
    .start_to_read(start_to_read_16),       //output reg 
    .ready_to_read(ready_to_read),          //input wire 
    .araddr_from_user(araddr_from_user_16), //output reg  
    .rdata_to_user(rdata_to_user)           //input wire   
);

//8 bit mode
//these signals are for 8 bit mode
wire [31:0] m_axis_tdata_8;
wire m_axis_tvalid_8;
wire [3:0] m_axis_tkeep_8;
wire m_axis_tlast_8;
wire start_to_read_8;
wire [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] araddr_from_user_8;
wire [27:0] hs_im_state_8;
wire [4:0] ram_dpra_8;
wire port_sel_8;
assign port_sel_8 = port_sel[1:1];
StateMachine_8#(
    .C_M_AXI_IM_Config_ADDR_WIDTH(C_M_AXI_IM_Config_ADDR_WIDTH),
    .C_M_AXI_IM_Config_DATA_WIDTH(C_M_AXI_IM_Config_DATA_WIDTH)
)StateMachine1(
    .aclk(aclk),                             //input wire 
    .aresetn(aresetn),                       //input wire 
    //elapsed_time
    .elapsed_time(elapsed_time),             //input wire 
    //port_sel
    .port_sel(port_sel_8),                   //input wire 
    //hs_state
    .hs_im_state(hs_im_state_8),             //output wire 
    //ram
    .ram_qdpo(ram_qdpo),                     //input wire
    .ram_dpra(ram_dpra_8),                   //output wire
    //acq_mode
    .acq_mode(acq_mode),                     //input wire
    //axis interface
    .m_axis_tvalid(m_axis_tvalid_8),         //output reg 
    .m_axis_tdata(m_axis_tdata_8),           //output reg
    .m_axis_tkeep(m_axis_tkeep_8),           //output reg
    .m_axis_tlast(m_axis_tlast_8),           //output reg 
    .m_axis_tready(m_axis_tready),           //input wire
    //read from IM_fifo
    .start_to_read(start_to_read_8),         //output reg 
    .ready_to_read(ready_to_read),           //input wire 
    .araddr_from_user(araddr_from_user_8),   //output reg  
    .rdata_to_user(rdata_to_user)            //input wire   
);

//using 16-bit mode or 8-bit mode depends on port_sel
SignalSwitch#(
    .C_M_AXI_IM_Config_ADDR_WIDTH(C_M_AXI_IM_Config_ADDR_WIDTH),
    .C_M_AXI_IM_Config_DATA_WIDTH(C_M_AXI_IM_Config_DATA_WIDTH)
)SignalSwitch0(
    //port_sel for the selection of 16-bit mode or 8-bit mode
    .port_sel(port_sel),
//16-bit mode signals
    .m_axis_tdata_8(m_axis_tdata_8),
    .m_axis_tvalid_8(m_axis_tvalid_8),
    .m_axis_tkeep_8(m_axis_tkeep_8),
    .m_axis_tlast_8(m_axis_tlast_8),
    .start_to_read_8(start_to_read_8),
    .araddr_from_user_8(araddr_from_user_8),
    .hs_im_state_8(hs_im_state_8),
    .ram_dpra_8(ram_dpra_8),
    .port_sel_8(port_sel_8),
//8-bit mode signals
    .m_axis_tdata_16(m_axis_tdata_16),
    .m_axis_tvalid_16(m_axis_tvalid_16),
    .m_axis_tkeep_16(m_axis_tkeep_16),
    .m_axis_tlast_16(m_axis_tlast_16),
    .start_to_read_16(start_to_read_16),
    .araddr_from_user_16(araddr_from_user_16),
    .hs_im_state_16(hs_im_state_16),
    .ram_dpra_16(ram_dpra_16),
    .port_sel_16(port_sel_16),
//output signals     
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tkeep(m_axis_tkeep),
    .m_axis_tlast(m_axis_tlast),
    .start_to_read(start_to_read),
    .araddr_from_user(araddr_from_user),
    .hs_im_state(hs_im_state),
    .ram_dpra(ram_dpra)
);
	endmodule
