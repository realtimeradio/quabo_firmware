
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
		output reg  m_axis_tvalid,
		output reg [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
		output reg [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tkeep,
		output reg  m_axis_tlast,
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
reg start_to_read;
//the ready_to_read signal only occurs one clock, when the data is ready to read.
(* keep = "true" *)wire ready_to_read;

wire port_sel;
reg [C_M_AXI_IM_Config_ADDR_WIDTH-1 : 0] araddr_from_user;
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
//                  bit31-bit1--reserved;
//reg1: waddr reg,  bit4-bit0--waddr;
//                  bit31-bit5--reserved;
//reg2: wdata;
//reg3: rdata,which is used for checking we write data correctly.
wire ram_we;
wire [4:0]  ram_waddr;
wire [31:0] ram_wdata;
wire [31:0] ram_rdata;
reg [27:0]  hs_im_state;
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
reg [4:0] ram_dpra;
wire [31:0] ram_qdpo;
dist_mem_gen_0 ram (
  .a(ram_waddr),                // input wire [4 : 0] a
  .d(ram_wdata),                // input wire [31 : 0] d
  .dpra(ram_dpra),          // input wire [4 : 0] dpra
  .clk(aclk),            // input wire clk
  .we(ram_we),              // input wire we
  //.qdpo_clk(aclk),  // input wire qdpo_clk
  //.qspo(ram_rdata),          // output wire [31 : 0] qspo
  //.qdpo(ram_qdpo)          // output wire [31 : 0] qdpo
  .spo(ram_rdata),          // output wire [31 : 0] qspo
  .dpo(ram_qdpo)          // output wire [31 : 0] qdpo
);
	

//This fifo is for storing data for checksum
reg checksum_fifo_rd_en;
reg checksum_fifo_wr_en;
reg [31:0]checksum_fifo_din;
wire checksum_fifo_empty;
wire [31:0] pixel_data;
fifo_for_checksum checkfifo_fifo (
  .clk(aclk),      // input wire clk
  .srst(~aresetn),    // input wire srst
  .din(checksum_fifo_din),      // input wire [31 : 0] din
  .wr_en(checksum_fifo_wr_en),  // input wire wr_en
  .rd_en(checksum_fifo_rd_en),  // input wire rd_en
  .dout(pixel_data),    // output wire [31 : 0] dout
  .full(),    // output wire full
  .empty(checksum_fifo_empty)  // output wire empty
);

// Add user logic here
//state machine is here
parameter [27:0] IDLE                   =   28'h0000000,
                CHECK_FIFO_OCCUPANCY    =   28'h0000001,
                CHECK_FIFO_LEN          =   28'h0000002,
                INCORRECT_LEN           =   28'h0000004,
                CORRECT_LEN             =   28'h0000008,
                GET_CHECKSUM_PART       =   28'h0000010,
                GET_ELAPSED_TIME        =   28'h0000020,
                CAL_UDP_CHECKSUM1       =   28'h0000040,
                CAL_UDP_CHECKSUM2       =   28'h0000080,
                CAL_UDP_CHECKSUM3       =   28'h0000100,
                CAL_UDP_CHECKSUM        =   28'h0000200,
                CAL_IP_CHECKSUM         =   28'h0000400,
                PUT_MAC0                =   28'h0000800,
                PUT_MAC1                =   28'h0001000,
                PUT_MAC2                =   28'h0002000,
                PUT_TYPE_VER_SERVICE    =   28'h0004000,
                PUT_TOTAL_LEN_ID        =   28'h0008000,
                PUT_FLAGS_TTL_PROTOCOL  =   28'h0010000,
                PUT_CHECKSUM_SRC_IP0    =   28'h0020000,
                PUT_SRC_IP1_DST_IP0     =   28'h0040000,
                PUT_DST_IP1_SRC_PORT    =   28'h0080000,
                PUT_DST_PORT_LENGTH     =   28'h0100000,
                PUT_CHECKSUM_ACQMODE    =   28'h0200000,
                PUT_PACKET_NO_BOARD_LOC =   28'h0400000,
                PUT_UTC                 =   28'h0800000,
                PUT_NANOSEC             =   28'h1000000,
                PUT_UNUSED_PIXEL_DATA   =   28'h2000000,
                PUT_PIXEL_DATA          =   28'h4000000,
                PUT_LAST                =   28'h8000000;

//IM_FIFO register offset
parameter [31: 0] RDFO_OFFSET   = 32'h0000001C,     //Receive Data FIFO Occupancy
                  RLR_OFFSET    = 32'h00000024,     //Receive Length Register
                  RDFD_OFFSET   = 32'h00000020;     //Receive Data FIFO 32-bit Wide Data Read Port

//Receive data length from im_fifo
parameter [31:0]  FIFO_RECV_TOTAL = 32'd1024;
parameter [31:0]  FIFO_RECV_LEN = 32'd256;
parameter [31:0]  FIFO_RECV_LEN_32BIT = 32'd128;

//ACQ_MODE here is a fixed value--0x02
//parameter [7:0]   ACQ_MODE_HS_IM   = 8'h02;

//The length of packet header is 42 bytes in ram
//The data width is 32bits, so we need to read data from the ram 11 times                
parameter [3:0] PACKET_HEADER_LEN = 4'd11;

//we use capital letter to show it's a input signal 
wire M_AXIS_TREADY;
assign M_AXIS_TREADY = m_axis_tready;

//this is packet_no, and will increase every packet 
reg [15:0] packet_no;
reg [15:0] packet_no_reg0,
           packet_no_reg1;

//delay of the data from im_fifo
reg [31:0] pixel_d0;

//this is a reg for storing the received length of im_fifo 
reg [31:0] fifo_recv_len;

reg [31:0] elapsed_time_reg;
reg [15:0] elapsed_time_reg0,
           elapsed_time_reg1,
           elapsed_time_reg2,
           elapsed_time_reg3;
//This is for udp check sum, and it will be added to the sum of fake udp header part,
//then we can get the whole 
reg [31:0] udp_checksum;
reg [31:0] ip_checksum;

reg [27:0]  next_state;

always @(posedge aclk)
    begin
        if (aresetn == 1'b0) 
            hs_im_state <= IDLE;
        else
            hs_im_state <= next_state;
    end

always @(hs_im_state or port_sel or ready_to_read or fifo_recv_len or udp_checksum)
    begin
        if (aresetn == 1'b0) 
            next_state = IDLE;
        else
            begin
                case(hs_im_state)
                    IDLE:
                        begin
                            if(port_sel == 1'b1)
                                next_state = CHECK_FIFO_OCCUPANCY;
                            else
                                next_state = IDLE;
                        end
                     CHECK_FIFO_OCCUPANCY:
                        begin
                            if((ready_to_read == 1'b1) && (rdata_to_user > 0))
                                next_state = CHECK_FIFO_LEN;
                            else
                                next_state = CHECK_FIFO_OCCUPANCY;
                        end
                     CHECK_FIFO_LEN:
                        begin
                            if((ready_to_read == 1'b1) && (rdata_to_user == (FIFO_RECV_TOTAL)))
                                next_state = CORRECT_LEN;
                            else if((ready_to_read == 1'b1) && (rdata_to_user != (FIFO_RECV_TOTAL)))
                                next_state = INCORRECT_LEN;
                            else
                                next_state = CHECK_FIFO_LEN;
                        end
                     INCORRECT_LEN:
                        begin
                            if((fifo_recv_len == 32'b0) && (port_sel == 1'b1))
                                next_state = CHECK_FIFO_OCCUPANCY;
                            else if((fifo_recv_len == 32'b0) && (port_sel == 1'b0))
                                next_state = IDLE;
                            else
                                next_state = INCORRECT_LEN;
                        end
                     CORRECT_LEN:
                        begin
                            if(fifo_recv_len == 32'b0)
                                next_state = GET_CHECKSUM_PART;
                            else
                                next_state = CORRECT_LEN;
                        end
                     GET_CHECKSUM_PART:
                        begin
                            next_state = GET_ELAPSED_TIME;
                        end
                     GET_ELAPSED_TIME:
                        begin
                            next_state = CAL_UDP_CHECKSUM1;
                        end
                     CAL_UDP_CHECKSUM1:
                        begin
                            next_state = CAL_UDP_CHECKSUM2;
                        end
                     CAL_UDP_CHECKSUM2:
                        begin
                            next_state = CAL_UDP_CHECKSUM3;
                        end
                     CAL_UDP_CHECKSUM3:
                        begin
                            next_state = CAL_UDP_CHECKSUM;
                        end
                     CAL_UDP_CHECKSUM:
                        begin
                            if(udp_checksum[31:16] == 16'b0)
                                next_state = CAL_IP_CHECKSUM;
                            else
                                next_state = CAL_UDP_CHECKSUM;
                        end
                     CAL_IP_CHECKSUM:
                        begin
                                next_state = PUT_MAC0;
                        end
                     PUT_MAC0:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_MAC1;
                            else
                                next_state = PUT_MAC0;
                        end
                     PUT_MAC1:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_MAC2;
                            else
                                next_state = PUT_MAC1;
                        end
                     PUT_MAC2:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_TYPE_VER_SERVICE;
                            else
                                next_state = PUT_MAC2;
                        end
                     PUT_TYPE_VER_SERVICE:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_TOTAL_LEN_ID;
                            else
                                next_state = PUT_TYPE_VER_SERVICE;
                        end
                     PUT_TOTAL_LEN_ID:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_FLAGS_TTL_PROTOCOL;
                            else
                                next_state = PUT_TOTAL_LEN_ID;
                        end
                     PUT_FLAGS_TTL_PROTOCOL:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_CHECKSUM_SRC_IP0;
                            else
                                next_state = PUT_FLAGS_TTL_PROTOCOL;
                        end
                     PUT_CHECKSUM_SRC_IP0:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_SRC_IP1_DST_IP0;
                            else
                                next_state = PUT_CHECKSUM_SRC_IP0;
                        end
                     PUT_SRC_IP1_DST_IP0:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_DST_IP1_SRC_PORT;
                            else
                                next_state = PUT_SRC_IP1_DST_IP0;
                        end
                     PUT_DST_IP1_SRC_PORT:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_DST_PORT_LENGTH;
                            else
                                next_state = PUT_DST_IP1_SRC_PORT;
                        end
                     PUT_DST_PORT_LENGTH:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_CHECKSUM_ACQMODE;
                            else
                                next_state = PUT_DST_PORT_LENGTH;
                        end
                     PUT_CHECKSUM_ACQMODE:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_PACKET_NO_BOARD_LOC;
                            else
                                next_state = PUT_CHECKSUM_ACQMODE;
                        end
                     PUT_PACKET_NO_BOARD_LOC:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_UTC;
                            else
                                next_state = PUT_PACKET_NO_BOARD_LOC;
                        end
                     PUT_UTC:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_NANOSEC;
                            else
                                next_state = PUT_UTC;
                        end
                     PUT_NANOSEC:
                        begin
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_UNUSED_PIXEL_DATA;
                            else
                                next_state = PUT_NANOSEC;
                        end
                     PUT_UNUSED_PIXEL_DATA:
                            if(M_AXIS_TREADY == 1'b1)
                                next_state = PUT_PIXEL_DATA;
                            else
                                next_state = PUT_UNUSED_PIXEL_DATA;
                     PUT_PIXEL_DATA:
                        begin
                            if((M_AXIS_TREADY == 1'b1) && (fifo_recv_len == 32'd1))
                                next_state = PUT_LAST;
                            else
                                next_state = PUT_PIXEL_DATA;  
                        end
                     PUT_LAST:
                        begin
                            if((M_AXIS_TREADY == 1'b1) && (port_sel == 1'b1))
                                next_state = CHECK_FIFO_OCCUPANCY;
                            else if((M_AXIS_TREADY == 1'b1) && (port_sel == 1'b0))
                                next_state = IDLE;
                            else
                                next_state = PUT_LAST;
                        end
                     default:
                        begin
                            next_state = IDLE;
                        end
                endcase
            end
    end
    
always @(posedge aclk)                                                    
    begin                                                                             
        if (aresetn == 1'b0)                                                     
	       begin                                                                         
	           // reset condition                                                                   
	           start_to_read       <= 1'b0;
	           araddr_from_user    <= 32'b0; 
	           fifo_recv_len       <= 32'b0;
	           //we dont care about the following signals until the hs_im_state goes to CORRECT_LEN 
	           ram_dpra            <= 5'b0;
	           m_axis_tvalid       <= 1'b0;
               m_axis_tdata        <= 32'b0;
               m_axis_tkeep        <= 4'b0;
               m_axis_tlast        <= 1'b0;
               packet_no           <= 16'b0;
               packet_no_reg0      <= 16'b0;
               packet_no_reg1      <= 16'b0;
               elapsed_time_reg    <= 32'b0;
               elapsed_time_reg0   <= 16'b0;
               elapsed_time_reg1   <= 16'b0;
               elapsed_time_reg2   <= 16'b0;
               elapsed_time_reg3   <= 16'b0;
               pixel_d0            <= 32'b0;
               udp_checksum        <= 32'b0;
               ip_checksum         <= 32'b0;
               checksum_fifo_rd_en <= 1'b0;  
               checksum_fifo_wr_en <= 1'b0;
               checksum_fifo_din   <= 32'b0;                                                                                         
	       end                                                                           
	    else                                                                            
	       begin                                                                         
	           // state transition                                                          
	           case (hs_im_state)                                                                                                                                                                                                                                                          
	               IDLE:
	                   begin
	                        start_to_read       <= 1'b0;
	                        araddr_from_user    <= 32'b0; 
	                        fifo_recv_len       <= 32'b0;
	                        //we dont care about the following signals until the hs_im_state goes to CORRECT_LEN
	                        ram_dpra            <= 5'b0;
	                        m_axis_tvalid       <= 1'b0;
                            m_axis_tdata        <= 32'b0;
                            m_axis_tkeep        <= 4'b0;
                            m_axis_tlast        <= 1'b0;
                            packet_no           <= 16'b0;
                            packet_no_reg0      <= 16'b0;
                            packet_no_reg1      <= 16'b0;
                            pixel_d0            <= 32'b0;
                            elapsed_time_reg    <= 32'b0;
                            elapsed_time_reg0   <= 16'b0;
                            elapsed_time_reg1   <= 16'b0;
                            elapsed_time_reg2   <= 16'b0;
                            elapsed_time_reg3   <= 16'b0;
                            udp_checksum        <= 32'b0;
                            ip_checksum         <= 32'b0;
                            checksum_fifo_rd_en <= 1'b0;
                            checksum_fifo_wr_en <= 1'b0;
                            checksum_fifo_din   <= 32'b0; 
	                   end
	               CHECK_FIFO_OCCUPANCY:
	                   begin
	                       start_to_read       <= 1'b1;
	                       araddr_from_user    <= RDFO_OFFSET;
	                       fifo_recv_len       <= 32'b0;
	                       //we dont care about the following signals until the hs_im_state goes to CORRECT_LEN
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= 32'b0;
                           elapsed_time_reg0   <= 16'b0;
                           elapsed_time_reg1   <= 16'b0;
                           elapsed_time_reg2   <= 16'b0;
                           elapsed_time_reg3   <= 16'b0;
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                    end
	               CHECK_FIFO_LEN:
	                   begin
	                       start_to_read       <= 1'b1;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       araddr_from_user    <= RLR_OFFSET;             
	                       fifo_recv_len       <=(rdata_to_user>>2);                      //im_fifo receive 256*4 bytes
	                       //we dont care about the following signals until the hs_im_state goes to CORRECT_LEN
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= 32'b0;
                           elapsed_time_reg0   <= 16'b0;
                           elapsed_time_reg1   <= 16'b0;
                           elapsed_time_reg2   <= 16'b0;
                           elapsed_time_reg3   <= 16'b0;
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 1'b0;      
	                   end  
	               INCORRECT_LEN:
	                   begin
	                       if(ready_to_read == 1'b1)
	                           begin
	                               fifo_recv_len       <= fifo_recv_len - 1; 
	                           end
	                       else
	                           begin
	                               fifo_recv_len       <= fifo_recv_len;
	                           end
	                       start_to_read       <= 1'b1;
	                       araddr_from_user    <= RDFD_OFFSET;
	                       //we dont care about the following signals until the hs_im_state goes to CORRECT_LEN
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= 32'b0;
                           elapsed_time_reg0   <= 16'b0;
                           elapsed_time_reg1   <= 16'b0;
                           elapsed_time_reg2   <= 16'b0;
                           elapsed_time_reg3   <= 16'b0;
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               CORRECT_LEN:
	                   begin        
	                       if(ready_to_read == 1'b1)
	                           begin
	                               fifo_recv_len       <= fifo_recv_len - 1;
	                               udp_checksum        <= udp_checksum + (rdata_to_user[7:0]<<8) + rdata_to_user[15:8];
	                               pixel_d0            <= rdata_to_user; 
	                           end                                               //put data from im_fifo in a tmp fifo here, we need to use the data fro checksum
	                       else
	                           begin
	                               fifo_recv_len       <= fifo_recv_len;
	                               udp_checksum        <= udp_checksum;
	                               pixel_d0            <= pixel_d0;
	                           end
	                       start_to_read       <= 1'b1;                          //put data to tmp fifo, and calculate checksum_part(sum data)
	                       araddr_from_user    <= RDFD_OFFSET;             
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           ip_checksum         <= 32'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= 32'b0;
                           elapsed_time_reg0   <= 16'b0;
                           elapsed_time_reg1   <= 16'b0;
                           elapsed_time_reg2   <= 16'b0;
                           elapsed_time_reg3   <= 16'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= ready_to_read & fifo_recv_len[0:0];
                           checksum_fifo_din   <= {rdata_to_user[15:0], pixel_d0[15:0]}; 
	                   end
	               GET_CHECKSUM_PART:
	                   begin
	                       fifo_recv_len       <= fifo_recv_len;
	                       udp_checksum        <= udp_checksum + ram_qdpo;            //put data from im_fifo in a tmp fifo here, we need to use the data fro checksum
	                       start_to_read       <= 1'b1;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           ip_checksum         <= 32'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= {1'b0, (elapsed_time<<2)};
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               GET_ELAPSED_TIME:
	                   begin
	                       fifo_recv_len       <= fifo_recv_len;
	                       udp_checksum        <= udp_checksum;            //put data from im_fifo in a tmp fifo here, we need to use the data fro checksum
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           ip_checksum         <= 32'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               CAL_UDP_CHECKSUM1:
	                   begin
	                       fifo_recv_len       <= fifo_recv_len;
	                       udp_checksum        <= udp_checksum + packet_no_reg0 + packet_no_reg1;            //put data from im_fifo in a tmp fifo here, we need to use the data fro checksum
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           ip_checksum         <= 32'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               CAL_UDP_CHECKSUM2:
	                   begin
	                       fifo_recv_len       <= fifo_recv_len;
	                       udp_checksum        <= udp_checksum + elapsed_time_reg0 + elapsed_time_reg1;            //put data from im_fifo in a tmp fifo here, we need to use the data fro checksum
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           ip_checksum         <= 32'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               CAL_UDP_CHECKSUM3:
	                   begin
	                       fifo_recv_len       <= fifo_recv_len;
	                       udp_checksum        <= udp_checksum + elapsed_time_reg2 + elapsed_time_reg3;            //put data from im_fifo in a tmp fifo here, we need to use the data fro checksum
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                               //put data to tmp fifo, and calculate checksum_part(sum data)
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;  
                           ip_checksum         <= 32'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               CAL_UDP_CHECKSUM:
	                   begin
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= FIFO_RECV_LEN_32BIT;           //im_fifo receive 256*4 bytes
	                       ram_dpra            <= 5'b1;                //keep the address, we need the third and forth byte read from the ram later
	                       // data here is special, two bytes are from the ram, and the other two bytes are acq_mode and unused
	                       m_axis_tdata        <= 32'h00; 
	                       m_axis_tvalid       <= 1'b0;                    // the data is valid now
                           m_axis_tkeep        <= 4'h0;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum[31:16] + udp_checksum[15:0];//if we don't get the correct checksum, keep calculating
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               CAL_IP_CHECKSUM:
	                   begin
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       ram_dpra            <= 5'd2;                //keep the address, we need the third and forth byte read from the ram later
	                       // data here is special, two bytes are from the ram, and the other two bytes are acq_mode and unused
	                       m_axis_tdata        <= 32'h00; 
	                       m_axis_tvalid       <= 1'b0;                    // the data is valid now
                           m_axis_tkeep        <= 4'h0;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;            //if we don't get the correct checksum, keep calculating
                           ip_checksum         <= ram_qdpo-packet_no;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                       end
	               PUT_MAC0:
	                   begin
	                       if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                               m_axis_tvalid       <= 1'b0;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                               m_axis_tvalid       <= 1'b1;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               PUT_MAC1:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
                   PUT_MAC2:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
	               PUT_TYPE_VER_SERVICE:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
                   PUT_TOTAL_LEN_ID:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= {packet_no[7:0], packet_no[15:8], ram_qdpo[15:0]};
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
                   PUT_FLAGS_TTL_PROTOCOL:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0; 
                        end
                   PUT_CHECKSUM_SRC_IP0:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= {ram_qdpo[31:16], ip_checksum[7:0],ip_checksum[15:8]};
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0; 
                        end
                   PUT_SRC_IP1_DST_IP0:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0; 
                        end
                   PUT_DST_IP1_SRC_PORT:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
                   PUT_DST_PORT_LENGTH:
                        begin
                           if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               ram_dpra            <= ram_dpra + 1;
	                           end
	                       else
	                           begin
	                               ram_dpra            <= ram_dpra;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           m_axis_tdata        <= ram_qdpo;
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
                   PUT_CHECKSUM_ACQMODE:
                        begin
	                       ram_dpra            <= ram_dpra;
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       m_axis_tvalid       <= 1'b1;
                           //m_axis_tdata        <= {8'h00, ACQ_MODE_HS_IM, ~udp_checksum[7:0], ~udp_checksum[15:8]};
                           m_axis_tdata        <= {8'h00, acq_mode, ~udp_checksum[7:0], ~udp_checksum[15:8]};
                           m_axis_tkeep        <= 4'hf;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= packet_no;
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= udp_checksum;
                           ip_checksum         <= ip_checksum;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
                        end
	               PUT_PACKET_NO_BOARD_LOC:                                        //board loc is from the ram, which is written by sdk,                                                          
	                   begin        
	                       if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               packet_no           <= packet_no + 1;               // packet_no plus 1 
	                           end
	                       else
	                           begin
	                               packet_no           <= packet_no;
	                           end                                              //so we don't need hardware connection here
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       ram_dpra            <= ram_dpra;                //keep the address, we need the third and forth byte read from the ram later
	                       m_axis_tdata        <= {ram_qdpo[15:0], packet_no}; 
	                       m_axis_tvalid       <= 1'b1;                    
                           m_axis_tkeep        <= 4'hf;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           pixel_d0            <= 32'b0; 
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               PUT_UTC:
	                   begin
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       ram_dpra            <= 5'b0;                    // reset the ram_dpra for next cycle
	                       m_axis_tdata        <= {32'b0}; 
	                       m_axis_tvalid       <= 1'b1;                    
                           m_axis_tkeep        <= 4'hf;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;               // packet_no plus 1
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0;
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0; 
	                   end
	               PUT_NANOSEC:
	                   begin
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       ram_dpra            <= 5'b0;                    // reset the ram_dpra for next cycle
	                       m_axis_tdata        <= elapsed_time_reg; //time resolution here is 1ns
	                       m_axis_tvalid       <= 1'b1;                    
                           m_axis_tkeep        <= 4'hf;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;               // packet_no plus 1
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= M_AXIS_TREADY;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               PUT_UNUSED_PIXEL_DATA:
	                   begin
	                       if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               fifo_recv_len       <= fifo_recv_len-1;           //im_fifo receive 256*4 bytes
	                           end
	                       else
	                           begin
	                               fifo_recv_len       <= fifo_recv_len;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;                    // reset the ram_dpra for next cycle
	                       m_axis_tdata        <= {pixel_data[15:0], 16'b0}; 
	                       m_axis_tvalid       <= 1'b1;                    
                           m_axis_tkeep        <= 4'hf;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;               // packet_no plus 1
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= pixel_data; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= M_AXIS_TREADY;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               PUT_PIXEL_DATA:
	                   begin
	                       if(M_AXIS_TREADY == 1'b1)
	                           begin
	                               fifo_recv_len       <= fifo_recv_len-1;           //im_fifo receive 256*4 bytes
	                           end
	                       else
	                           begin
	                               fifo_recv_len       <= fifo_recv_len;
	                           end
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       ram_dpra            <= 5'b0;                    // reset the ram_dpra for next cycle
	                       m_axis_tdata        <= {pixel_data[15:0],pixel_d0[31:16]}; 
	                       m_axis_tvalid       <= 1'b1;                    
                           m_axis_tkeep        <= 4'hf;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b0;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;               // packet_no plus 1
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= pixel_data; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= M_AXIS_TREADY;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               PUT_LAST:
	                   begin
	                       start_to_read       <= 1'b1;                               
	                       araddr_from_user    <= RDFO_OFFSET;
	                       //start_to_read       <= 1'b0;                    //no hurry to read, we need to get packets header from ram first
	                       //araddr_from_user    <= 32'b0;             
	                       fifo_recv_len       <= fifo_recv_len;           //im_fifo receive 256*4 bytes
	                       ram_dpra            <= 5'b0;                    // reset the ram_dpra for next cycle
	                       m_axis_tdata        <= {16'b0, pixel_d0[31:16]}; 
	                       m_axis_tvalid       <= 1'b1;                    
                           m_axis_tkeep        <= 4'h3;                    // all the four byes are valid
                           m_axis_tlast        <= 1'b1;                    // it's not the last byte transfer to the axis interface
                           packet_no           <= packet_no;               // packet_no plus 1
                           packet_no_reg0      <= {packet_no[7:0], 8'b0};
                           packet_no_reg1      <= {8'b0, packet_no[15:8]};
                           elapsed_time_reg    <= elapsed_time_reg;
                           elapsed_time_reg0   <= {elapsed_time_reg[7:0], 8'b0};
                           elapsed_time_reg1   <= {8'b0, elapsed_time_reg[15:8]};
                           elapsed_time_reg2   <= {elapsed_time_reg[23:16],8'b0};
                           elapsed_time_reg3   <= {8'b0,elapsed_time_reg[31:24]};
                           pixel_d0            <= pixel_data; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= M_AXIS_TREADY;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
	               default:
	                   begin
	                       start_to_read       <= 1'b0;
	                       araddr_from_user    <= 32'b0; 
	                       fifo_recv_len       <= 32'b0;
	                       //we dont care about the following signals until the hs_im_state goes to CORRECT_LEN 
	                       ram_dpra            <= 5'b0;
	                       m_axis_tvalid       <= 1'b0;
                           m_axis_tdata        <= 32'b0;
                           m_axis_tkeep        <= 4'b0;
                           m_axis_tlast        <= 1'b0;
                           packet_no           <= 16'b0;
                           packet_no_reg0      <= 16'b0;
                           packet_no_reg1      <= 16'b0;
                           elapsed_time_reg    <= 32'b0;
                           elapsed_time_reg0   <= 16'b0;
                           elapsed_time_reg1   <= 16'b0;
                           elapsed_time_reg2   <= 16'b0;
                           elapsed_time_reg3   <= 16'b0;
                           pixel_d0            <= 32'b0; 
                           udp_checksum        <= 32'b0;
                           ip_checksum         <= 32'b0;
                           checksum_fifo_rd_en <= 1'b0;
                           checksum_fifo_wr_en <= 1'b0;
                           checksum_fifo_din   <= 32'b0;
	                   end
            endcase   
        end   
    end         
// User logic ends

	endmodule
