`include "elevator_dut.v"
module elevator_tb();

// input
reg clock;
reg reset;
reg [4:0] floor;
reg [4:0] up;
reg [4:0] down;

// output
wire [2:0] floor_number;
wire [1:0] dir;
wire [4:0] to_go;

initial begin
    clock = 0;
    reset = 1;
    floor = 5'b10000;
    up = 5'b00000;
    down = 5'b00000;
    #20
    reset = 0;
    #130
    floor = 5'b00001;
    #200
    floor = 5'b01010;
end

always begin
    #10 clock = ~clock;
end
    
elevator_dut dut(
    clock,
    reset,
    floor,
    up,
    down,
    floor_number,
    to_go,
    dir
);

endmodule