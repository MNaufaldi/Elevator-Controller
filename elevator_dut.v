module elevator_dut(
    clock,
    reset,
    floor,
    up,
    down,
    floor_number,
    to_go,
    dir
);

// Input
input clock;
input reset;
input [4:0] floor;
input [4:0] up;
input [4:0] down;

// Output
output floor_number;
output dir;
output to_go;

// Datatype
reg [2:0] floor_number;
reg [1:0] dir;
reg [2:0] current_state;
reg [2:0] next_state;
reg [4:0] to_go;

// Constant
parameter[2:0] S0 = 3'b000;
parameter[2:0] S1 = 3'b010;
parameter[2:0] S2 = 3'b100;
parameter[2:0] S3 = 3'b110;
parameter[2:0] S4 = 3'b111;

// ?
integer i;

initial begin
    to_go = 5'b00000;
end

always @(posedge clock) begin
    if (reset) begin
        current_state = S0;
    end
    else begin
        current_state = next_state;
    end
end

// Copy Input
always @(floor or up or down) begin
    for (i = 0; i < 5; i = i + 1) begin
        if (floor[i] == 1 || up[i] == 1 || down[i]) begin
            to_go[i] = 1;
        end
    end
end

// // Dir change
// always @(dir) begin
    
// end


always @(current_state or to_go or posedge clock) begin
    case (current_state)
        S0:
            // Idle
            if (to_go[0] == 1) begin
                next_state = S0;
                dir = 2'b00;
                to_go[0] = 0;
            end
            // Up
            else if (to_go > 5'b00001) begin
                next_state = S1;
                dir = 2'b10;           
            end
        S1:
            // Idle
            if (to_go[1] == 1) begin
                next_state = S1;
                dir = 2'b00;
                to_go[1] = 0;
            end
            // Up
            else if (to_go > 5'b00010 ) begin
                next_state = S2;
                dir = 2'b10;           
            end
            // Down
            else if (to_go < 5'b00010 ) begin
                next_state = S0;
                dir = 2'b01;
            end
        S2:
            // Idle
            if (to_go[2] == 1) begin
                next_state = S2;
                dir = 2'b00;
                to_go[2] = 0;
            end
            // Up
            else if (to_go > 5'b00100 ) begin
                next_state = S3;
                dir = 2'b10;           
            end
            // Down
            else if (to_go < 5'b00100 ) begin
                next_state = S1;
                dir = 2'b01;
            end
        S3:
            // Idle
            if (to_go[3] == 1) begin
                next_state = S3;
                dir = 2'b00;
                to_go[3] = 0;
            end
            // Up
            else if (to_go > 5'b01000 ) begin
                next_state = S4;
                dir = 2'b10;
            end
            // Down
            else if (to_go < 5'b01000 ) begin
                next_state = S2;
                dir = 2'b01;
            end
        S4:
            // Idle
            if (to_go[4] == 1) begin
                next_state = S4;
                dir = 2'b00;
                to_go[4] = 0;
            end
            // Down
            else if (to_go < 5'b10000 ) begin
                next_state = S3;
                dir = 2'b01;
            end

    endcase
end

always @(current_state) begin
    case (current_state)
        S0:
        begin
            floor_number <= 3'b001;
        end
        S1:
        begin
            floor_number <= 3'b010;
        end
        S2:
        begin 
            floor_number <= 3'b011;
        end
        S3:
        begin 
            floor_number <= 3'b100;
        end
        S4:
        begin 
            floor_number <= 3'b101;
        end 

    endcase
end

endmodule