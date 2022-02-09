
`timescale 1 ns / 1 ps

	module PH_BL_FIFO_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here
		// connection from maroc_dc core
        input wire[31:0]axi_str_rxd_tdata,
        input wire axi_str_rxd_tlast,
        input wire axi_str_rxd_tvalid,
        output wire axi_str_rxd_tready,
        //connection from HS-PH core
        input wire start_to_read,
        output wire [31:0]rdata_to_user,
        output wire ready_to_read,
        input wire arst_for_phfifo,
        //elapsed_time
        output wire [31:0] ph_elapsed_time,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// assign axi clk and rst to our clk and rst
wire clk, rst;
assign clk = s00_axi_aclk;
assign rst = ~ s00_axi_aresetn;

//wires for cache
wire axi_cache_read, axi_cache_sel;
wire [7:0] axi_cache_raddr;
wire [15:0] axi_cache_data;
//wires for bl
wire axi_bl_ena, axi_bl_wea;
wire [7:0] axi_bl_addr;
wire [15:0] axi_bl_data_in, axi_bl_data_out;
wire axi_bl_enable;
//wires for remap
wire axi_remap_ena, axi_remap_wea;
wire [7:0] axi_remap_addr;
wire [7:0] axi_remap_data_in, axi_remap_data_out;
// Instantiation of Axi Bus Interface S00_AXI
	PH_BL_FIFO_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready),
		//cache
		.axi_cache_read(axi_cache_read),
        .axi_cache_sel(axi_cache_sel),
        .axi_cache_raddr(axi_cache_raddr),      //8bits
        .axi_cache_data(axi_cache_data),        //16bits
        //bl
        .axi_bl_ena(axi_bl_ena),
        .axi_bl_wea(axi_bl_wea),
        .axi_bl_addr(axi_bl_addr),              //8bits
        .axi_bl_data_in(axi_bl_data_in),        //16bits
        .axi_bl_data_out(axi_bl_data_out),      //16bits
        .axi_bl_enable(axi_bl_enable),
        //remap
        .axi_remap_ena(axi_remap_ena),
        .axi_remap_wea(axi_remap_wea),
        .axi_remap_addr(axi_remap_addr),        //8bits
        .axi_remap_data_in(axi_remap_data_in),  //8bits
        .axi_remap_data_out(axi_remap_data_out) //8bits
	);

	// Add user logic here
//wires connected to PH_BL
wire ph_cache_valid, ph_cache_enb;
wire [7:0] ph_cache_raddr;
wire [15:0] ph_cache_data;
PH_Cache ph_cache_01(
    .clk(clk),
    .rst(rst),
    // ports connected to maroc_dc core
	.axi_str_rxd_tdata(axi_str_rxd_tdata),      //32bits
    .axi_str_rxd_tlast(axi_str_rxd_tlast),
    .axi_str_rxd_tvalid(axi_str_rxd_tvalid),
    .axi_str_rxd_tready(axi_str_rxd_tready),
    // control sigianl for writing ph data into the bram 
    .axi_cache_read(axi_cache_read),
    .axi_cache_sel(axi_cache_sel),
    .axi_cache_raddr(axi_cache_raddr),          //8bits
    .axi_cache_data(axi_cache_data),            //16bits
    //signal between ph_cache and ph_bl
    .ph_cache_valid(ph_cache_valid),    //it means the last seriel ph_data is stored in the ph_cache
    .ph_cache_enb(ph_cache_enb),
    .ph_cache_raddr(ph_cache_raddr),            //8bits
    .ph_cache_data(ph_cache_data),              //16bits
    .ph_elapsed_time(ph_elapsed_time)           //31bits
    );
    
PH_BL ph_bl0(
    .clk(clk),
    .rst(rst),
    //axi interface for reading/writing BL BRAM
    .axi_bl_ena(axi_bl_ena),
    .axi_bl_wea(axi_bl_wea),
    .axi_bl_addr(axi_bl_addr),                  //8bits
    .axi_bl_data_in(axi_bl_data_in),            //16bits
    .axi_bl_data_out(axi_bl_data_out),          //16bits
    .axi_bl_enable(axi_bl_enable),
    //axi interface for reading/writing Remapping BRAM
    .axi_remap_ena(axi_remap_ena),
    .axi_remap_wea(axi_remap_wea),
    .axi_remap_addr(axi_remap_addr), //8bits
    .axi_remap_data_in(axi_remap_data_in),      //8bits
    .axi_remap_data_out(axi_remap_data_out),    //8bits
    //interface connected to PH_Cache
    .ph_cache_valid(ph_cache_valid),
    .ph_cache_enb(ph_cache_enb),
    .ph_cache_raddr(ph_cache_raddr),            //8bits
    .ph_cache_data(ph_cache_data),              //16bits
    //interface connected to HS-PH core
    .start_to_read(start_to_read),
    .rdata_to_user(rdata_to_user),              //32bits
    .ready_to_read(ready_to_read),
    // rst for ph_fifo
    .arst_for_phfifo(arst_for_phfifo)
    );
	// User logic ends

	endmodule
