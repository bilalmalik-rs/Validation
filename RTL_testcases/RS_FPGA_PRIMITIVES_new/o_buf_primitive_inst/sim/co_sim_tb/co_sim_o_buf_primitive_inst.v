 
module co_sim_o_buf_primitive_inst;
  reg data_input;     // Data input (connect to top-level port)
  wire data_output ;

  wire expected_data_output;
o_buf_primitive_inst DUT (.*);

integer mismatch=0;

initial begin
  {data_input} = 1'b0;
  #5
  compare;
  {data_input} = 1'b1;
  #5
  compare;
  if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end

assign expected_data_output =  data_input;

task compare;
 	
  	if(data_output !== expected_data_output) begin
    	$display("Data Mismatch. Expected : %0b, Actual: %0b, Time: %0t", expected_data_output, data_output, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Expected : %0b, Actual: %0b, Time: %0t", expected_data_output ,data_output, $time);

endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
