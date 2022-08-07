module iiitb_rc(clk, ori, count);
	input clk;
	input ori;
    output[3:0] count;
    reg[3:0] temp;
	always @(posedge clk or posedge ori)
	begin
		if(ori == 1)
		begin 
			temp <= 4'b1000;
		end
		else
            temp <= {temp[0], temp[3:1]};
	end
	assign count = temp;
endmodule
