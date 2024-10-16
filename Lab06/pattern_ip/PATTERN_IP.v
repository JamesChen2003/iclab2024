`ifdef RTL
    `define CYCLE_TIME 20.0
`endif
`ifdef GATE
    `define CYCLE_TIME 20.0
`endif

module PATTERN #(parameter IP_BIT = 8)(
    //Output Port
    IN_code,
    //Input Port
	OUT_code
);
// ========================================
// Input & Output
// ========================================
output reg [IP_BIT+4-1:0] IN_code;

input [IP_BIT-1:0] OUT_code;

// ========================================
// clock
// ========================================
real CYCLE = `CYCLE_TIME;
// always	#(CYCLE/2.0) clk = ~clk; //clock
// initial	clk = 0;

// ========================================
// integer & parameter
// ========================================
integer PATTERN_NUMBER = 1000;
integer pattern_count, set_count;
integer i, j, k, load, discard;
// file_input
integer fin_incode;

// ========================================
// wire & reg
// ========================================
reg [IP_BIT+4-1:0] pat_in_code;
reg [IP_BIT-1:0] pat_out_code;

//================================================================
// initial
//================================================================
initial begin
    // Open files
    load_file_task;

    // Reset the circuit
    reset_task;

    // Check functionality
    for(pattern_count=0 ; pattern_count<PATTERN_NUMBER ; pattern_count=pattern_count+1) begin
        
		input_task;
		check_ans_task;
        #(CYCLE);
    end

    // Pass all the pattern
    YOU_PASS_task;
	#(CYCLE); $finish;
end

//================================================================
// tasks
//================================================================
task load_file_task; begin

    if(IP_BIT == 5) begin
        fin_incode = $fopen("../00_TESTBED/data_5.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_5.txt !"); $finish;
        end
    end
    else if(IP_BIT == 6) begin
        fin_incode = $fopen("../00_TESTBED/data_6.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_6.txt !"); $finish;
        end
    end
    else if(IP_BIT == 7) begin
        fin_incode = $fopen("../00_TESTBED/data_7.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_7.txt !"); $finish;
        end
    end
    else if(IP_BIT == 8) begin
        fin_incode = $fopen("../00_TESTBED/data_8.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_8.txt !"); $finish;
        end
    end
    else if(IP_BIT == 9) begin
        fin_incode = $fopen("../00_TESTBED/data_9.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_9.txt !"); $finish;
        end
    end
    else if(IP_BIT == 10) begin
        fin_incode = $fopen("../00_TESTBED/data_10.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_10.txt !"); $finish;
        end
    end
    else if(IP_BIT == 11) begin
        fin_incode = $fopen("../00_TESTBED/data_11.txt", "r");
        if(fin_incode == 0) begin
            $display("Error: Failed to open file data_11.txt !"); $finish;
        end
    end
    else begin
        $display("Error: Invalid IP_BIT ! "); $finish;
    end

end endtask


task reset_task; begin
    // Initialize output signals
    IN_code = 'dx;

    #(CYCLE);

end endtask


task input_task; begin
    load = $fscanf(fin_incode, "%b", pat_in_code);
    IN_code = pat_in_code;

end endtask


task check_ans_task; begin
    load = $fscanf(fin_incode, "%b", pat_out_code);
    if(OUT_code != pat_out_code) begin
        fail_task;
		$display ("-------------------------------------------------------");
		$display ("                         FAIL                          ");
		$display ("                    wrong OUT_code                     ");
		$display ("-------------------------------------------------------");
        $display ("                    PATTERN NO.%5d                     ", pattern_count+1);
        $display ("   golden OUT_code : %11b                              ", pat_out_code);
		$display ("     your OUT_code : %11b                              ", OUT_code);
		$display ("-------------------------------------------------------");
        $display ("    Tip : pattern no. = line no. of the input file.    ");
        #(CYCLE); $finish;
    end
end endtask

endmodule