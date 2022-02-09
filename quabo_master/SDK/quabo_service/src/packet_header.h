#ifndef PACKET_HEADER_H
#define PACKET_HEADER_H

//MicroBlaze core is little-endian, but TCP/IP is big-endian, so we need to change the bytes sequence
//The following two macro definition is used for little-endian to big-endian converting
#define PP_HTONS(x) ((((x) & 0x00ffUL) << 8) | (((x) & 0xff00UL) >> 8))
#define PP_HTONL(x) ((((x) & 0x000000ffUL) << 24) | \
                     (((x) & 0x0000ff00UL) <<  8) | \
                     (((x) & 0x00ff0000UL) >>  8) | \
                     (((x) & 0xff000000UL) >> 24))

#define ACQ_MODE_HS_IM     0x03

//#define AXI_RAM_ADDR	0x44A80000
#define RAM_WE_EN(AXI_RAM_ADDR)					Xil_Out32(AXI_RAM_ADDR+0,1)
#define RAM_WE_DIS(AXI_RAM_ADDR)				Xil_Out32(AXI_RAM_ADDR+0,0)
#define WRITE_TO_RAM(AXI_RAM_ADDR,addr, data) 	Xil_Out32(AXI_RAM_ADDR+4, addr); \
												Xil_Out32(AXI_RAM_ADDR+8, data);
#define READ_FROM_RAM(AXI_RAM_ADDR,addr, data)	Xil_Out32(AXI_RAM_ADDR+4, addr); \
												Xil_Out32(AXI_RAM_ADDR+12,0);	\
												data = Xil_In32(AXI_RAM_ADDR+12);
#define SELF_CHECK(AXI_RAM_ADDR,data)			data = Xil_In32(AXI_RAM_ADDR+8);
#define GET_STATE(AXI_RAM_ADDR,data)			data = Xil_In32(AXI_RAM_ADDR+16);
#define IMFIFO_MB_CTRL(AXI_RAM_ADDR)			Xil_Out32(AXI_RAM_ADDR+0,0);
#define IMFIFO_FPGA_CTRL_16BIT(AXI_RAM_ADDR)	Xil_Out32(AXI_RAM_ADDR+0,2);
#define IMFIFO_FPGA_CTRL_8BIT(AXI_RAM_ADDR)		Xil_Out32(AXI_RAM_ADDR+0,4);
#define SET_ACQ_MODE(AXI_RAM_ADDR,data)			Xil_Out32(AXI_RAM_ADDR+20,((Xil_In32(AXI_RAM_ADDR+20)&0xff00)|data));
#define SET_PACKET_VER(AXI_RAM_ADDR,data)		Xil_Out32(AXI_RAM_ADDR+20, ((Xil_In32(AXI_RAM_ADDR+20)&0xff)|data<<8));
//because the length of the eth packet struct is 48 bytes
#define EthPacketHeader_Word_Len	13

//data in this struct will be sent to RAM in FPGA
typedef struct Panoseti_EthPacketHeader {
	unsigned int udp_checksum_part; 		//for Memory address alignment
	unsigned int ip_checksum_part;
	unsigned char dst_mac[6];					
	unsigned char src_mac[6];
	unsigned short type;
	unsigned char version_headerlen;
	unsigned char servicefield;
	unsigned short total_len;
	unsigned short identification;
	unsigned short flags;
	unsigned char timelive;
	unsigned char protocol;
	unsigned short unused;
	unsigned char src_ip[4];
	unsigned char dst_ip[4];
	unsigned short src_port;
	unsigned short dst_port;
	unsigned short length;
	unsigned char board_loc[4];
	unsigned char acqmode;
} Panoseti_EthPacketHeader;
//data in this struct is different, which is based on each quabo
typedef struct EthPacketHeader_Keys{
	unsigned char dst_mac[6];
	unsigned char src_mac[6];
	unsigned char src_ip[4];
	unsigned char dst_ip[4];
	unsigned short src_port;
	unsigned short dst_port;
	unsigned char board_loc[4];
	unsigned char acqmode;
	unsigned short total_len;
	unsigned short length;
} EthPacketHeader_Keys;
char Panoseti_EthPacketHeader_Init(unsigned int baseaddr,EthPacketHeader_Keys *ethpacketheader_keys, unsigned char packet_ver);
void Panoseti_WriteHeaderToRam(unsigned int baseaddr);
char Panoseti_ReadHeaderFromRam(unsigned int baseaddr);
unsigned int Panoseti_GetStateMachine(unsigned int baseaddr);
void Panoseti_IMFIFO_Reset(unsigned int baseaddr);
#endif
