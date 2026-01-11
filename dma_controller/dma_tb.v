`timescale 1ns/1ps

module dma_tb;

    parameter CLK_PERIOD = 10;
    parameter SRC_ADDR = 32'h0000_0000;
    parameter DST_ADDR = 32'h0000_0100;
    parameter XFER_LENGTH = 16;
    
    reg clk;
    reg rst;
    
    reg [4:0] reg_addr;
    reg [31:0] reg_wdata;
    wire [31:0] reg_rdata;
    reg reg_we;
    reg reg_re;
    wire reg_ready;
    
    wire [31:0] bus_addr;
    wire [31:0] bus_wdata;
    wire [31:0] bus_rdata;
    wire bus_we;
    wire bus_re;
    wire bus_ready;
    
    integer i;
    reg [31:0] read_data;
    reg test_passed;
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    dma_top u_dma_top (
        .clk(clk),
        .rst(rst),
        .reg_addr(reg_addr),
        .reg_wdata(reg_wdata),
        .reg_rdata(reg_rdata),
        .reg_we(reg_we),
        .reg_re(reg_re),
        .reg_ready(reg_ready),
        .bus_addr(bus_addr),
        .bus_wdata(bus_wdata),
        .bus_rdata(bus_rdata),
        .bus_we(bus_we),
        .bus_re(bus_re),
        .bus_ready(bus_ready)
    );
    
    dma_memory #(
        .ADDR_WIDTH(32),
        .DATA_WIDTH(32),
        .MEM_SIZE(1024)
    ) u_memory (
        .clk(clk),
        .rst(rst),
        .bus_addr(bus_addr),
        .bus_wdata(bus_wdata),
        .bus_rdata(bus_rdata),
        .bus_we(bus_we),
        .bus_re(bus_re),
        .bus_ready(bus_ready)
    );
    
    task write_register;
        input [4:0] addr;
        input [31:0] data;
        begin
            @(posedge clk);
            reg_addr <= addr;
            reg_wdata <= data;
            reg_we <= 1'b1;
            reg_re <= 1'b0;
            @(posedge clk);
            while (!reg_ready) @(posedge clk);
            reg_we <= 1'b0;
            @(posedge clk);
        end
    endtask
    
    task read_register;
        input [4:0] addr;
        output [31:0] data;
        begin
            @(posedge clk);
            reg_addr <= addr;
            reg_we <= 1'b0;
            reg_re <= 1'b1;
            @(posedge clk);
            while (!reg_ready) @(posedge clk);
            data = reg_rdata;
            reg_re <= 1'b0;
            @(posedge clk);
        end
    endtask
    
    task wait_dma_done;
        reg [31:0] status;
        begin
            status = 32'h0;
            while (status[0] == 1'b0) begin
                read_register(5'h10, status);
                #(CLK_PERIOD*10);
            end
        end
    endtask
    
    initial begin
        rst = 0;
        reg_addr = 5'h0;
        reg_wdata = 32'h0;
        reg_we = 1'b0;
        reg_re = 1'b0;
        test_passed = 1'b1;
        
        $display("========================================");
        $display("DMA Controller Testbench");
        $display("========================================");
        $display("Time: %0t - Starting test", $time);
        
        #(CLK_PERIOD*2);
        rst = 1;
        #(CLK_PERIOD*5);
        
        $display("Time: %0t - Initializing source memory", $time);
        for (i = 0; i < XFER_LENGTH; i = i + 1) begin
            u_memory.write_mem(SRC_ADDR + (i*4), 32'hA0000000 + i);
        end
        
        $display("Time: %0t - Clearing destination memory", $time);
        for (i = 0; i < XFER_LENGTH; i = i + 1) begin
            u_memory.write_mem(DST_ADDR + (i*4), 32'h00000000);
        end
        
        $display("Time: %0t - Configuring DMA registers", $time);
        $display("  SRC_ADDR  = 0x%08h", SRC_ADDR);
        $display("  DST_ADDR  = 0x%08h", DST_ADDR);
        $display("  LENGTH    = %0d words", XFER_LENGTH);
        
        write_register(5'h00, SRC_ADDR);
        write_register(5'h04, DST_ADDR);
        write_register(5'h08, XFER_LENGTH);
    end

endmodule

