module co_sim_ram_true_dp_dc_32768x4;

    reg clkA, clkB, weA, weB;
    reg [14:0] addrA, addrB;
    reg [3:0] dinA, dinB;
    wire [3:0] doutA, doutB, doutA_netlist, doutB_netlist;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_true_dp_dc_32768x4 golden(.*);
    `ifdef PNR
        ram_true_dp_dc_32768x4_post_route netlist(.*, .doutA(doutA_netlist), .doutB(doutB_netlist));
    `else
        ram_true_dp_dc_32768x4_post_synth netlist(.*, .doutA(doutA_netlist), .doutB(doutB_netlist));
    `endif


    
    //clock//
    initial begin
        clkA = 1'b0;
        forever #10 clkA = ~clkA;
    end
    initial begin
        clkB = 1'b0;
        forever #5 clkB = ~clkB;
    end

    initial begin
        for(integer i = 0; i<32768; i=i+1) begin 
            golden.ram[i] ='b0;
        end 
    end
    initial begin
        
    {weA,weB, addrA,addrB, dinA, dinB, cycle, i} = 0;
 
 
    repeat (1) @ (negedge clkA);
    addrA <= 'd1; addrB <= 'd2; weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
    compare(cycle);
    repeat (1) @ (negedge clkA);
    addrA <= 'd1; addrB <= 'd2; weA <=1'b0; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
    compare(cycle);

    for (integer i=0; i<32768; i=i+1)begin
        repeat (1) @ (negedge clkA)

        addrA <= $urandom_range(0,16383); addrB <= $urandom_range(16384,32767); weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<32768; i=i+1)begin
        repeat (1) @ (negedge clkA)

        addrA <= $urandom_range(0,16383); addrB <= $urandom_range(16384,32767); weA <=1'b0; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<32768; i=i+1)begin
        repeat (1) @ (negedge clkB)

        addrA <= $urandom_range(0,16383); addrB <= $urandom_range(16384,32767); weA <=1'b0; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<32768; i=i+1)begin
        repeat (1) @ (negedge clkA)

        addrA <= $urandom_range(0,16383); addrB <= $urandom_range(16384,32767); weA <=1'b1; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end
        //random
    for (integer i=0; i<32768; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addrA <= $urandom_range(0,16383); addrB <= $urandom_range(16384,32767); weA <={$random}; weB <={$random}; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
       
        compare(cycle);
    end
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clkA); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(doutA !== doutA_netlist) begin
        $display("doutA mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutA, doutA_netlist,$time);
        mismatch = mismatch+1;
    end

     if(doutB !== doutB_netlist) begin
        $display("doutB mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutB, doutB_netlist,$time);
        mismatch = mismatch+1;
    end
    
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
