module tb_ringcounter;
    reg clk;
    reg reset;
    wire [3:0] out;
    reg [3:0] init;

    RingCounter counter(clk, reset, init, out);

    always #10 clk = ~clk;
    initial
        begin
            $dumpfile("ringcounter.vcd");
			$dumpvars(0, tb_ringcounter);
            $monitor($time," %b", out);
            init[3] = 0;
            init[2] = 0;
            init[1] = 1;
            init[0] = 0;
            reset <= 1;  
            clk <= 0; 
            repeat (1) @ (posedge clk);  
            reset <= 0;  
            repeat (17) @ (posedge clk);  
            $finish;
        end
endmodule
