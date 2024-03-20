//===========================================================================
// accel.v
//
// Template module to get the DE10-Lite's accelerator working very quickly.
//
//
//===========================================================================

module accel (
   //////////// CLOCK //////////
   input 		          		MAX10_CLK1_50,

   //////////// SEG7 //////////
   output		     [7:0]		HEX0,
   output		     [7:0]		HEX1,
   output		     [7:0]		HEX2,
   output		     [7:0]		HEX3,
   output		     [7:0]		HEX4,
   output		     [7:0]		HEX5,

   //////////// KEY //////////
   input 		     [1:0]		KEY,

   //////////// LED //////////
   output		     [9:0]		LEDR,

   //////////// SW //////////
   input 		     [9:0]		SW,

   //////////// Accelerometer ports //////////
   inout 		          		GSENSOR_SDI,
   inout 		          		GSENSOR_SDO,
   output		          		GSENSOR_CS_N,
   output		          		GSENSOR_SCLK,
   input 		     [2:1]		GSENSOR_INT
);

//===== Declarations
   localparam SPI_CLK_FREQ  = 200;  // SPI Clock (Hz)
   localparam UPDATE_FREQ   = 1;    // Sampling frequency (Hz)
   localparam SAMPLE_SPEED = 5000;

   // clks and reset
   wire reset_n;
   wire clk, spi_clk, spi_clk_out;
   wire clk_div, spi_clk_div, spi_clk_out_div;

   // output data
   wire data_update;
   wire [15:0] data_x, data_y;

   // Pressing KEY0 freezes the accelerometer's output
   assign reset_n = KEY[0];

   //===== Phase-locked Loop (PLL) instantiation. Code was copied from a module
   //      produced by Quartus' IP Catalog tool.
   PLL ip_inst (
      .inclk0        ( MAX10_CLK1_50 ),
      .c0            ( clk ),                 // 25 MHz, phase   0 degrees
      .c1            ( spi_clk ),             //  2 MHz, phase   0 degrees
      .c2            ( spi_clk_out )          //  2 MHz, phase 270 degrees
   );

   clk_divider #(
      .CLK_FREQ      (25_000_000),
      .COUNT         (SAMPLE_SPEED)
   ) CLK_DIV_PLL (
      .clk           (clk),
      .rst_n_a       (reset_n),
      .clk_div       (clk_div),
      .ctrl_signal   ()
   );

   clk_divider #(
      .CLK_FREQ      (2_000_000),
      .COUNT         (SAMPLE_SPEED)
   ) CLK_DIV_SPI (
      .clk           (spi_clk),
      .rst_n_a       (reset_n),
      .clk_div       (spi_clk_div),
      .ctrl_signal   ()
   );

   clk_divider #(
      .CLK_FREQ      (2_000_000),
      .COUNT         (SAMPLE_SPEED)
   ) CLK_DIV_SPI_OUT (
      .clk           (spi_clk_out),
      .rst_n_a       (reset_n),
      .clk_div       (spi_clk_out_div),
      .ctrl_signal   ()
   );

   //===== Instantiation of the spi_control module which provides the logic to 
   //      interface to the accelerometer.
   spi_control #(     // parameters
      .SPI_CLK_FREQ  (SPI_CLK_FREQ),
      .UPDATE_FREQ   (UPDATE_FREQ)
   ) spi_ctrl (      // port connections
      .reset_n       (reset_n),
      .clk           (clk_div),
      .spi_clk       (spi_clk_div),
      .spi_clk_out   (spi_clk_out_div),
      .data_update   (data_update),
      .data_x        (data_x),
      .data_y        (data_y),
      .SPI_SDI       (GSENSOR_SDI),
      .SPI_SDO       (GSENSOR_SDO),
      .SPI_CSN       (GSENSOR_CS_N),
      .SPI_CLK       (GSENSOR_SCLK),
      .interrupt     (GSENSOR_INT)
   );

   //===== Main block
   //      To make the module do something visible, the 16-bit data_x is 
   //      displayed on four of the HEX displays in hexadecimal format.

   wire [3:0] signed_data_x;
   wire [3:0] signed_data_y;

   //=========== Raw outputs of the module ===========//
   assign signed_data_x = data_x < 0 ? -data_x : data_x;
   assign signed_data_y = data_y < 0 ? -data_y : data_y;
   //=================================================//

   wire [3:0] unidades_x = signed_data_x % 10;
   wire [3:0] decenas_x = (signed_data_x / 10) % 10;
   wire [3:0] centenas_x = signed_data_x / 100;

   wire [3:0] unidades_y = signed_data_y % 10;
   wire [3:0] decenas_y = (signed_data_y / 10) % 10;
   wire [3:0] centenas_y = signed_data_y / 100;

   // 7-segment displays HEX0-3 show data_x in hexadecimal
   seg7 s0 (
      .in      (unidades_x),
      .display (HEX0)
   );

   seg7 s1 (
      .in      (decenas_x),
      .display (HEX1)
   );

   seg7 s2 (
      .in      (centenas_x),
      .display (HEX2)
   );

   seg7 s3 (
      .in      (unidades_y),
      .display (HEX3)
   );

   seg7 s4 (
      .in      (decenas_y),
      .display (HEX4)
      );

   seg7 s5 (
      .in      (centenas_y),
      .display (HEX5)
   );

   // A few statements just to light some LEDs
   // assign LEDR = {SW[9:8], data_x[7:0]};

endmodule