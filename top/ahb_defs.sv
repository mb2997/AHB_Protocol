`define HADDR_W 32
`define HDATA_W 32
`define BYTE_W 8
`define HBURST_W 3
`define HSIZE_W 3
`define HTRANS_W 2

typedef enum bit [`HBURST_W-1:0] {SINGLE, INCR, WRAP4, INCR4, WRAP8, INCR8, WRAP16, INCR16} burst_type_et;
typedef enum bit [`HSIZE_W-1:0] {BYTE, HALFWORD, WORD, DOUBLEWORD, FOURWORD, EIGHTWORD, RESERVED1, RESERVED2} transfer_size_et;
typedef enum bit [`HTRANS_W-1:0] {IDLE, BUSY, NONSEQ, SEQ} transfer_type_et;