module spie(
	input logic mosi, cs, sclk, rst,
	output logic miso, output logic [3:0] num1
);
	logic[3:0] num2,oper,ain ;
	logic [10:0] Bits; //mi secuencia de bits, 8 bits para los 4 primeros numeros
	//2 bits para la operacion , 1 bit para el enable o next state.
	logic d;
	assign d = mosi & cs & !rst;
	assign miso= rst == 1 ? 8'b11111111 :d;
	
	flipflop  bit10(
		.d(d), .clk(sclk), .rst(rst),
		.q(Bits[0])
	);
	
	flipflop  bit9(
		.d(Bits[0]), .clk(sclk), .rst(rst),
		.q(Bits[1])
	);
	
	flipflop  bit08(
		.d(Bits[1]), .clk(sclk), .rst(rst),
		.q(Bits[2])
	);
	
	flipflop  bit07(
		.d(Bits[2]), .clk(sclk), .rst(rst),
		.q(Bits[3])
	);
	flipflop  bit06(
		.d(Bits[3]), .clk(sclk), .rst(rst),
		.q(Bits[4])
	);
	flipflop  bit05(
		.d(Bits[4]), .clk(sclk), .rst(rst),
		.q(Bits[5])
	);
	flipflop  bit04(
		.d(Bits[5]), .clk(sclk), .rst(rst),
		.q(Bits[6])
	);
	flipflop  bit03(
		.d(Bits[6]), .clk(sclk), .rst(rst),
		.q(Bits[7])
	);
	flipflop  bit02(
		.d(Bits[7]), .clk(sclk), .rst(rst),
		.q(Bits[8])
	);
	flipflop  bit01(
		.d(Bits[8]), .clk(sclk), .rst(rst),
		.q(Bits[9])
	);
	flipflop  bit00(
		.d(Bits[9]), .clk(sclk), .rst(rst),
		.q(Bits[10])
	);
	assign num1[0] = Bits[10];
	assign num1[1] = Bits[9];
	assign num1[2] = Bits[8];
	assign num1[3] = Bits[7];
	
	
	/*
	decoderSlave midecoder(
    .clk(sclk),
    .rst(rst),
    .enable(1),
    .mosi(mosi),
    .num1(num1),
    .num2(num2),
    .oper(oper),
    .Ain(Ain)
);*/
endmodule