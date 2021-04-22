`include "elevator_dut.v"
module elevator_tb();

// input
reg clock;
reg reset;
reg f1;
reg f2;
reg f3;
reg f4;
reg f5;

// output
wire [2:0] floor_number;
wire dir;
wire move;
wire [4:0] to_go;

initial begin
    clock = 0;
    reset = 1;
    f1 = 0;
    f2 = 0;
    f3 = 0;
    f4 = 0;
    f5 = 1;
    #20
    reset = 0;
    #130
    f1 = 1;
    f5 = 0;
    #130
    f1 = 0;
    f4 = 1;
    f2 = 1;
    #130
    f4 = 0;
    f2 = 0;
    f1 = 1;
    f3 = 1;
    #40
    f1 = 0;
    f3 = 0;
    f4 = 1;
end

initial begin
    $monitor("At time=%d, Elevator is at %d", $time, floor_number);
end

always begin
    #10 clock = ~clock;
end
    
elevator_dut dut(
    clock,
    reset,
    floor_number,
    to_go,
    move,
    f1,
    f2,
    f3,
    f4,
    f5,
    dir
);

endmodule