module dma_memory #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter MEM_SIZE = 1024
) (
    input wire clk,
    input wire rst,
    input wire [ADDR_WIDTH-1:0] bus_addr,
    input wire [DATA_WIDTH-1:0] bus_wdata,
    output reg [DATA_WIDTH-1:0] bus_rdata,
    input wire bus_we,
    input wire bus_re,
    output reg bus_ready
);

    reg [DATA_WIDTH-1:0] memory [0:MEM_SIZE-1];
    
    wire [$clog2(MEM_SIZE)-1:0] word_addr;
    assign word_addr = bus_addr[2 +: $clog2(MEM_SIZE)];
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            bus_rdata <= 32'h0;
        end else begin
            if (bus_re) begin
                bus_rdata <= memory[word_addr];
            end
        end
    end
    
    always @(posedge clk) begin
        if (bus_we) begin
            memory[word_addr] <= bus_wdata;
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            bus_ready <= 1'b0;
        end else begin
            bus_ready <= bus_we | bus_re;
        end
    end
    
    task write_mem;
        input [ADDR_WIDTH-1:0] addr;
        input [DATA_WIDTH-1:0] data;
        begin
            memory[addr[2 +: $clog2(MEM_SIZE)]] = data;
        end
    endtask
    
    task read_mem;
        input [ADDR_WIDTH-1:0] addr;
        output [DATA_WIDTH-1:0] data;
        begin
            data = memory[addr[2 +: $clog2(MEM_SIZE)]]; 
        end
    endtask

endmodule

