//------------------------------------------------------------------------------
//
//Module Name:					System_Delay.v
//Department:					Xidian University
//Function Description:	   复位启动时钟延时
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review	Rel data
//V1.0		Verdvana		Verdvana				     2019-7-8
//
//-----------------------------------------------------------------------------------


module System_Delay
#(
	parameter	SYS_DELAY_TOP = 24'd2500000	//50ms system init delay
)(
		input		clk_50m,
		input		rst_n,
		
		output	delay_done
);

reg	[23:0] delay_cnt = 24'd0;

always@(posedge clk_50m or negedge rst_n) begin
	if(!rst_n)
		delay_cnt <= 0;
		
	else if(delay_cnt < SYS_DELAY_TOP - 1'b1)
		delay_cnt <= delay_cnt + 1'b1;
		
	else
		delay_cnt <= SYS_DELAY_TOP - 1'b1;
end
assign	delay_done = (delay_cnt == SYS_DELAY_TOP - 1'b1)? 1'b1 : 1'b0;
	
endmodule	
