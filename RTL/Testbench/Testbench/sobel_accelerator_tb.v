`timescale 1ns/1ps

module sobel_accelerator_tb;
  reg clk;
  reg rst;
  reg pixel_in_valid;
  reg [7:0] pixel_in;
  wire pixel_out_valid;
  wire [7:0] pixel_out;

  // Instantiate the DUT
  sobel_accelerator uut (
    .clk(clk),
    .rst(rst),
    .pixel_in_valid(pixel_in_valid),
    .pixel_in(pixel_in),
    .pixel_out_valid(pixel_out_valid),
    .pixel_out(pixel_out)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    $display("Starting simulation...");
    clk = 0;
    rst = 1;
    pixel_in = 0;
    pixel_in_valid = 0;
    
    #20 rst = 0;

    // Send a stream of pixel values
    repeat (150) begin
      @(posedge clk);
      pixel_in_valid = 1;
      pixel_in = $random % 256; // Random grayscale value
    end

    // Hold inputs inactive
    @(posedge clk);
    pixel_in_valid = 0;

    // Wait for output to complete
    repeat (20) @(posedge clk);

    $display("Simulation finished.");
    $finish;
  end
endmodule
