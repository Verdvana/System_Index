//------------------------------------------------------------------------------
//
//Module Name:					System_Index.v
//Department:					Xidian University
//Function Description:	   系统时钟和复位信号的初始化
//
//------------------------------------------------------------------------------
//
//Version 	Design		Coding		Simulata	  Review	Rel data
//V1.0		Verdvana		Verdvana				     2019-7-8
//
//-----------------------------------------------------------------------------------

module System_Index
#(
	parameter	SYS_DELAY_TOP = 24'd2500000	//延时50ms
)
(
		input				clk_50m,
		input				rst_n,
		
		output			clk_c0,
		
		output			sys_rst_n	
				
);



//------------------------
//延时模块例化
wire	delay_done;	//system init delay has done
System_Delay
#(
	.SYS_DELAY_TOP	(SYS_DELAY_TOP)
)
u_System_Delay(

	.clk_50m		(clk_50m),
	.rst_n		(1'b1),					//只有上电会延时，上电之后的复位不会延时

	.delay_done	(delay_done)
);

wire	pll_rst = ~delay_done;


//------------------------------------------------
//PLL例化
wire locked;

PLL_0002 pll_inst (
	.refclk   (clk_50m),   //  refclk.clk
	.rst      (pll_rst),      //   reset.reset
	
	.outclk_0 (clk_c0), // outclk0.clk
	.locked   (locked)    //  locked.export
	);
	
	
	

//----------------------------------------------
//异步复位同步释放模块例化
wire asy_rst_n;

Asy_Rst_Syn u_Asy_Rst_Syn(

	.clk_50m(clk_50m),
	.rst_n(rst_n),
	
	.asy_rst_n(asy_rst_n)
);

//----------------------------------------------
//系统复位信号

assign sys_rst_n = asy_rst_n & locked;



endmodule
