v10.5A:
(1) We get IM packets(ACQ_MODE=2) from hardware instead of software, so we can get high speed packets;
(2) We can set ACQ_MODE to 0, so that no packets will be sent out except HK packets.

v10.5:
(1) finish high speed IM mode(ACQ_MODE = 3).
	We can get PH packets and IM packets at the same time:
	when it's PH packet, its ACQ_MODE = 1;
	when it's IM packet, its ACQ_MODE = 3;
(2) I just finished function test,including UDP packets checksum, timing difference,
	but I'm not sure whether the scientific data is correct;
	We need more tests on it;

v10.4:
(1) replace set_focus function with rick's new code to solve issue of stage stops when it reacges tge upper optical switch;
(2) fix the system crashed issue(a fifo in eth_core_ctrl core was full...);
(3) fix the issue of losing connection to the last quabo on mobo;
    The second eth port on the last quabo is open, so it can't finish the auto-negotiation. I configure the second eth port to fixed 1000Mbps, not auto-negotiation;
(4) fix mac address issue;
    some mac addresses are illegal, and it's related to the first byte;
    I set the first byte of mac address to 0x00 to solve the issue;
(5) fix the issue about stage didn't work with more than 2 quabo on mobo;
    focus_limits_on(output) port is connected to bus, so I change is to three state, if it's quabo1/2/3; 
	

