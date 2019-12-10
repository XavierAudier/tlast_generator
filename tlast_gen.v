`timescale 1ns / 1ps

module tlast_gen
#(
    parameter TDATA_WIDTH    = 8,
    parameter MAX_PKT_LENGTH = 256
)
(
    // Clocks and resets
    input                            aclk,
    input                            resetn,
    
    // Control signals
    input [$clog2(MAX_PKT_LENGTH):0] pkt_length,
    
    // Slave interface
    input                            s_axis_tvalid,
    output                           s_axis_tready,
    input  [TDATA_WIDTH-1:0]         s_axis_tdata,
    
    // Master interface
    output                           m_axis_tvalid,
    input                            m_axis_tready,
    output                           m_axis_tlast,
    output [TDATA_WIDTH-1:0]         m_axis_tdata,
    output [$clog2(MAX_PKT_LENGTH):0] o_cnt
);

    // Internal signals
    wire new_sample;
    reg [$clog2(MAX_PKT_LENGTH):0] cnt;
    
    initial begin
        cnt = 0;
    end

    // Pass through control signals
    assign s_axis_tready = m_axis_tready;
    assign m_axis_tvalid = s_axis_tvalid;
    assign m_axis_tdata  = s_axis_tdata;

    // Count samples
    assign new_sample = s_axis_tvalid & s_axis_tready;
    
    always @ (posedge aclk) begin
        if (~resetn)
            cnt <= 0;
        else begin
            if (new_sample) begin
                if (m_axis_tlast) begin
                    cnt <= 1'b1;
                end
                else begin
                cnt <= cnt + 1'b1;
                end
            end        
        end
    end
    
    // Generate tlast
    assign m_axis_tlast = (cnt == pkt_length) & new_sample;
    assign o_cnt = cnt;

endmodule
