`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2019 11:29:20 AM
// Design Name: 
// Module Name: tlast_gen_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tlast_gen_tb(

    );
    
    parameter TDATA_WIDTH    = 32;
    parameter MAX_PKT_LENGTH = 32;
    reg                            aclk;
    reg                            resetn;
    reg [$clog2(MAX_PKT_LENGTH):0] pkt_length;
    reg                            force_tlast;
    reg                            s_axis_tvalid;
    reg                            m_axis_tready;
    reg  [TDATA_WIDTH-1:0]         s_axis_tdata;
    wire                           m_axis_tvalid;
    wire                           m_axis_tlast;
    wire [TDATA_WIDTH-1:0]         m_axis_tdata;
    wire [$clog2(MAX_PKT_LENGTH):0]o_cnt;
    
//    // For the non functional implementation
//    tlast_gen_NONFUNCTIONAL #(
//    .TDATA_WIDTH(TDATA_WIDTH),
//    .MAX_PKT_LENGTH(MAX_PKT_LENGTH)
//    ) u0 (
//    // Clocks and resets
//    .aclk(aclk),
//    .resetn(resetn),
//    .pkt_length(pkt_length),
//    .s_axis_tvalid(s_axis_tvalid),
//    .s_axis_tdata(s_axis_tdata),
//    .m_axis_tvalid(m_axis_tvalid),
//    .m_axis_tlast(m_axis_tlast),
//    .m_axis_tdata(m_axis_tdata),
//    .m_axis_tready(m_axis_tready),
//    .o_cnt(o_cnt)
//    );
    
    // For the functional implementation
    tlast_gen #(
    .TDATA_WIDTH(TDATA_WIDTH),
    .MAX_PKT_LENGTH(MAX_PKT_LENGTH)
    ) u0 (
    // Clocks and resets
    .aclk(aclk),
    .resetn(resetn),
    .pkt_length(pkt_length),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tdata(s_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tlast(m_axis_tlast),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tready(m_axis_tready),
    .o_cnt(o_cnt)
    );


    initial begin
        aclk = 1;
        resetn = 1;
        force_tlast = 0;
        s_axis_tvalid = 0;
        s_axis_tdata = 6;
        pkt_length = 8;
        m_axis_tready = 1;
    end
    
    always @ (*) begin
        #1 aclk <= ~aclk;
    end
    
    
    initial begin
        #4  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #2  s_axis_tvalid = 0;
        #10  s_axis_tvalid = 1;
        #100  s_axis_tvalid = 0;
        #20 $finish;
    end
    
    

endmodule
