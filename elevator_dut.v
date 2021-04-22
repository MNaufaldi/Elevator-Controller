module elevator_dut(
    input clock,
    input reset,
    input f1,
    input f2,
    input f3,
    input f4,
    input f5,
    output reg [2:0] floor_number,
  	output reg dir,
  	output reg move,
    output reg [4:0] to_go
);

reg [2:0] current_state;
reg [2:0] next_state;

// Constant
parameter[2:0] S0 = 3'b000;
parameter[2:0] S1 = 3'b010;
parameter[2:0] S2 = 3'b100;
parameter[2:0] S3 = 3'b110;
parameter[2:0] S4 = 3'b111;


initial begin
    to_go = 5'b00000;
    move = 0;
    dir = 1;
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
always @(f1) begin
    if (f1 == 1) begin
        to_go[0] = 1;
    end
end
always @(f2) begin
    if (f2 == 1) begin
        to_go[1] = 1;
    end
end
always @(f3) begin
    if (f3 == 1) begin
        to_go[2] = 1;
    end
end
always @(f4) begin
    if (f4 == 1) begin
        to_go[3] = 1;
    end
end
always @(f5) begin
    if (f5 == 1) begin
        to_go[4] = 1;
    end
end


always @(current_state or to_go or posedge clock) begin
    case (current_state)
        S0:
            // Idle
            if (to_go == 5'b00000) begin
                move = 0;
                next_state = S0;
            end 
            // Idle and serving a request
            else if (to_go[0] == 1 && move == 1) begin
                next_state = S0;
                move = 0;
                to_go[0] = 0;
            end
            // Up
            else if (to_go > 5'b00001 && dir == 1) begin
                next_state = S1;
                dir = 1;
                move = 1;           
            end
            // Next direction
            else begin
                if (dir == 1) begin
                    dir = 0;
                    move = 1;
                end
                else begin
                    dir = 1;
                    move = 1;
                end
            end
        S1:
            // Idle
            if (to_go == 5'b00000) begin
                move = 0;
                next_state = S1;
            end 
            // Idle and serving a request
            else if (to_go[1] == 1 && move == 1) begin
                next_state = S1;
                move = 0;
                to_go[1] = 0;
            end
            // Up
            else if (to_go > 5'b00010 && dir == 1) begin
                next_state = S2;
                dir = 1;
                move = 1;           
            end
            // Down
            else if (to_go[1:0] < 10 && dir == 0) begin
                next_state = S0;
                dir = 0;
                move = 1;
            end
            // Next direction
            else begin
                if (dir == 1) begin
                    dir = 0;
                    move = 1;
                end
                else begin
                    dir = 1;
                    move = 1;
                end
            end
        S2:
            // Idle
            if (to_go == 5'b00000) begin
                move = 0;
                next_state = S2;
            end 
            // Idle and serving a request
            else if (to_go[2] == 1 && move == 1) begin
                next_state = S2;
                move = 0;
                to_go[2] = 0;
            end
            // Up
            else if (to_go > 5'b00100 && dir == 1) begin
                next_state = S3;
                dir = 1;
                move = 1;           
            end
            // Down
            else if (to_go[2:0] < 100 && dir == 0) begin
                next_state = S1;
                dir = 0;
                move = 1;
            end
            // Next direction
            else begin
                if (dir == 1) begin
                    dir = 0;
                    move = 1;
                end
                else begin
                    dir = 1;
                    move = 1;
                end
            end
        S3:
            // Idle
            if (to_go == 5'b00000) begin
                move = 0;
                next_state = S3;
            end 
            // Idle and serving a request
            else if (to_go[3] == 1 && move == 1) begin
                next_state = S3;
                move = 0;
                to_go[3] = 0;
            // Up
            end
            else if (to_go > 5'b01000 && dir == 1) begin
                next_state = S4;
                dir = 1;
                move = 1;
            end
            // Down
            else if (to_go[3:0] < 1000 && dir == 0) begin
                next_state = S2;
                dir = 0;
                move = 1;
            end
            // Next direction
            else begin
                if (dir == 1) begin
                    dir = 0;
                    move = 1;
                end
                else begin
                    dir = 1;
                    move = 1;
                end
            end
        S4:
            // Idle
            if (to_go == 5'b00000) begin
                move = 0;
                next_state = S4;
            end 
            // Idle and serving a request
            else if (to_go[4] == 1 && move == 1) begin
                next_state = S4;
                move = 0;
                to_go[4] = 0;
            // Down
            end
            else if (to_go[4:0] < 10000 && dir == 0) begin
                next_state = S3;
                dir = 0;
                move = 1;
            end
            // Next direction
            else begin
                if (dir == 1) begin
                    dir = 0;
                    move = 1;
                end
                else begin
                    dir = 1;
                    move = 1;
                end
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