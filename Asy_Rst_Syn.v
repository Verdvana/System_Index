//------------------------------------------------------------------------------
//
//Module Name:					Asy_Rst_Syn.v
//Department:					Xidian University
//Function Description:	   异步复位同步释放
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review	Rel data
//V1.0		Verdvana		Verdvana				     2019-7-8
//
//-----------------------------------------------------------------------------------
module Asy_Rst_Syn(
		input			clk_50m,
		input			rst_n,
		
		output		asy_rst_n
				
);

//----------------------------------------------

reg [1:0] rst_shift;

always@(posedge clk_50m or negedge rst_n) begin
	if(!rst_n)
		rst_shift[1:0] <= 2'b00;
	
	else
		rst_shift[1:0] <= {rst_shift[0],1'b1};
end

assign asy_rst_n = rst_shift[1];

endmodule

