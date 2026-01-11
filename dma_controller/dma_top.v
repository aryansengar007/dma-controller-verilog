module dma_top (
    input wire clk,
    input wire rst,
    
    input wire [4:0] reg_addr,
    input wire [31:0] reg_wdata,
    output wire [31:0] reg_rdata,
    input wire reg_we,
    input wire reg_re,
    output wire reg_ready,
    
    output wire [31:0] bus_addr,
    output wire [31:0] bus_wdata,
    input wire [31:0] bus_rdata,
    output wire bus_we,
    output wire bus_re,
    input wire bus_ready
);

    wire [31:0] src_addr_reg;
    wire [31:0] dst_addr_reg;
    wire [31:0] length_reg;
    wire [31:0] control_reg;
    wire [31:0] status_reg;
    
    wire start_transfer;
    wire transfer_done;
    wire transfer_active;
    
    wire [31:0] current_src_addr;
    wire [31:0] current_dst_addr;
    wire bus_read_req;
    wire bus_write_req;
    wire bus_op_done;
    wire [31:0] read_data_buffer;

    dma_regs u_dma_regs (
        .clk(clk),
        .rst(rst),
        .reg_addr(reg_addr),
        .reg_wdata(reg_wdata),
        .reg_rdata(reg_rdata),
        .reg_we(reg_we),
        .reg_re(reg_re),
        .reg_ready(reg_ready),
        .src_addr(src_addr_reg),
        .dst_addr(dst_addr_reg),
        .length(length_reg),
        .control(control_reg),
        .status(status_reg),
        .transfer_done(transfer_done),
        .transfer_active(transfer_active)
    );
    
    dma_fsm u_dma_fsm (
        .clk(clk),
        .rst(rst),
        .start_transfer(start_transfer),
        .src_addr_init(src_addr_reg),
        .dst_addr_init(dst_addr_reg),
        .length_init(length_reg),
        .bus_op_done(bus_op_done),
        .current_src_addr(current_src_addr),
        .current_dst_addr(current_dst_addr),
        .bus_read_req(bus_read_req),
        .bus_write_req(bus_write_req),
        .transfer_done(transfer_done),
        .transfer_active(transfer_active),
        .read_data_buffer(read_data_buffer)
    );
    
    dma_bus_master u_dma_bus_master (
        .clk(clk),
        .rst(rst),
        .bus_read_req(bus_read_req),
        .bus_write_req(bus_write_req),
        .read_addr(current_src_addr),
        .write_addr(current_dst_addr),
        .write_data(read_data_buffer),
        .bus_addr(bus_addr),
        .bus_wdata(bus_wdata),
        .bus_rdata(bus_rdata),
        .bus_we(bus_we),
        .bus_re(bus_re),
        .bus_ready(bus_ready),
        .bus_op_done(bus_op_done),
        .read_data_out(read_data_buffer)
    );
    
    assign start_transfer = control_reg[0];

endmodule

