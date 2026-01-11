module dma_regs (
    input wire clk,
    input wire rst,
    
    input wire [4:0] reg_addr,
    input wire [31:0] reg_wdata,
    output reg [31:0] reg_rdata,
    input wire reg_we,
    input wire reg_re,
    output reg reg_ready,
    
    output reg [31:0] src_addr,
    output reg [31:0] dst_addr,
    output reg [31:0] length,
    output reg [31:0] control,
    output wire [31:0] status,
    
    input wire transfer_done,
    input wire transfer_active
);

    localparam ADDR_SRC_ADDR  = 5'h00;
    localparam ADDR_DST_ADDR  = 5'h04;
    localparam ADDR_LENGTH    = 5'h08;
    localparam ADDR_CONTROL   = 5'h0C;
    localparam ADDR_STATUS    = 5'h10;
    
    assign status = {30'b0, transfer_active, transfer_done};
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            src_addr <= 32'h0;
            dst_addr <= 32'h0;
            length   <= 32'h0;
            control  <= 32'h0;
        end else begin
            if (transfer_active && control[0]) begin
                control[0] <= 1'b0;
            end
            
            if (reg_we) begin
                case (reg_addr)
                    ADDR_SRC_ADDR: src_addr <= reg_wdata;
                    ADDR_DST_ADDR: dst_addr <= reg_wdata;
                    ADDR_LENGTH:   length   <= reg_wdata;
                    ADDR_CONTROL:  control  <= reg_wdata;
                    default: ;
                endcase
            end
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            reg_rdata <= 32'h0;
        end else begin
            if (reg_re) begin
                case (reg_addr)
                    ADDR_SRC_ADDR:  reg_rdata <= src_addr;
                    ADDR_DST_ADDR:  reg_rdata <= dst_addr;
                    ADDR_LENGTH:    reg_rdata <= length;
                    ADDR_CONTROL:   reg_rdata <= control;
                    ADDR_STATUS:    reg_rdata <= status;
                    default:        reg_rdata <= 32'h0;
                endcase
            end
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            reg_ready <= 1'b0;
        end else begin
            reg_ready <= reg_we | reg_re;
        end
    end

endmodule

