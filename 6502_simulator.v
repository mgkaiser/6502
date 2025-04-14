
`include "hvsync_generator.v"
`include "ALU.v"
`include "cpu_65c02.v"
`include "ram.v"

module top(clk, reset, hsync, vsync, rgb);

  input clk, reset;
  output hsync, vsync;
  output [2:0] rgb;
  wire display_on;
  wire [8:0] hpos;
  wire [8:0] vpos;
  
  wire write_enable = 0;
  wire [15:0] addr_bus = 0;
  wire [7:0] data_bus_in = 0;
  wire [7:0] data_bus_out;

  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(reset),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(display_on),
    .hpos(hpos),
    .vpos(vpos)
  );
  
  RAM_sync ram(
    .clk(clk), 
    .addr(addr_bus), 
    .din(data_bus_in), 
    .dout(data_bus_out), 
    .we(write_enable)
  );

  wire r = display_on && hpos[4];
  wire g = display_on && vpos[4];
  wire b = display_on && hpos[0];
  assign rgb = {b,g,r};

endmodule
