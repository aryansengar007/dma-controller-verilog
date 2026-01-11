module dma_bus_master (
    input wire clk,
    input wire rst,
    
    input wire bus_read_req,
    input wire bus_write_req,
    input wire [31:0] read_addr,
    input wire [31:0] write_addr,
    input wire [31:0] write_data,
    
    output reg [31:0] bus_addr,
    output reg [31:0] bus_wdata,
    input wire [31:0] bus_rdata,
    output reg bus_we,
    output reg bus_re,
    input wire bus_ready,
    
    output reg bus_op_done,
    output reg [31:0] read_data_out
);

    localparam BUS_IDLE  = 2'b00;
    localparam BUS_READ  = 2'b01;
    localparam BUS_WRITE = 2'b10;
    
    reg [1:0] bus_state;
    reg [1:0] next_bus_state;
    
    always @(posedge clk or negedge rst) begin
        if (!rst)
            bus_state <= BUS_IDLE;
        else
            bus_state <= next_bus_state;
    end
    
    always @(*) begin
        next_bus_state = bus_state;
        case (bus_state)
            BUS_IDLE: begin
                if (bus_read_req)
                    next_bus_state = BUS_READ;
                else if (bus_write_req)
                    next_bus_state = BUS_WRITE;
            end
            
            BUS_READ:  if (bus_ready) next_bus_state = BUS_IDLE;
            BUS_WRITE: if (bus_ready) next_bus_state = BUS_IDLE;
            
            default: next_bus_state = BUS_IDLE;
        endcase
    end
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            bus_addr      <= 32'h0;
            bus_wdata     <= 32'h0;
            bus_we        <= 1'b0;
            bus_re        <= 1'b0;
            bus_op_done   <= 1'b0;
            read_data_out <= 32'h0;
        end else begin
            bus_op_done <= 1'b0;
            
            case (bus_state)
                BUS_IDLE: begin
                    bus_we <= 1'b0;
                    bus_re <= 1'b0;
                    
                    if (bus_read_req) begin
                        bus_addr <= read_addr;
                        bus_re   <= 1'b1;
                    end else if (bus_write_req) begin
                        bus_addr  <= write_addr;
                        bus_wdata <= write_data;
                        bus_we    <= 1'b1;
                    end
                end
                
                BUS_READ: begin
                    if (bus_ready) begin
                        read_data_out <= bus_rdata;
                        bus_re <= 1'b0;
                        bus_op_done <= 1'b1;
                    end
                end
                
                BUS_WRITE: begin
                    if (bus_ready) begin
                        bus_we <= 1'b0;
                        bus_op_done <= 1'b1;
                    end
                end
                
                default: begin
                    bus_we <= 1'b0;
                    bus_re <= 1'b0;
                end
            endcase
        end
    end

endmodule

