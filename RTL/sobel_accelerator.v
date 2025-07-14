module sobel_accelerator (
    input clk,
    input rst,
    input pixel_in_valid,
    input [7:0] pixel_in,
    output reg pixel_out_valid,
    output reg [7:0] pixel_out
);
    parameter IMAGE_WIDTH = 128;
    reg [6:0] column_counter;

    reg [7:0] line_buffer1 [0:IMAGE_WIDTH-1];
    reg [7:0] line_buffer2 [0:IMAGE_WIDTH-1];

    reg [7:0] window [0:2][0:2];

    integer gx, gy, mag;

    initial begin
        column_counter = 0;
        pixel_out = 0;
        pixel_out_valid = 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            column_counter <= 0;
            pixel_out_valid <= 0;
        end else if (pixel_in_valid) begin
            if (column_counter == IMAGE_WIDTH - 1)
                column_counter <= 0;
            else
                column_counter <= column_counter + 1;

            // Shift window
            window[0][0] <= window[0][1]; window[0][1] <= window[0][2];
            window[1][0] <= window[1][1]; window[1][1] <= window[1][2];
            window[2][0] <= window[2][1]; window[2][1] <= window[2][2];

            // Insert new pixels
            window[0][2] <= line_buffer2[column_counter];
            window[1][2] <= line_buffer1[column_counter];
            window[2][2] <= pixel_in;

            // Update line buffers
            line_buffer2[column_counter] <= line_buffer1[column_counter];
            line_buffer1[column_counter] <= pixel_in;

            if (column_counter >= 2) begin
                // Compute Gx
                gx = -window[0][0] + window[0][2]
                   - 2*window[1][0] + 2*window[1][2]
                   - window[2][0] + window[2][2];
                // Compute Gy
                gy = -window[0][0] - 2*window[0][1] - window[0][2]
                   + window[2][0] + 2*window[2][1] + window[2][2];
                // Compute magnitude
                if (gx < 0) gx = -gx;
                if (gy < 0) gy = -gy;
                mag = gx + gy;

                pixel_out <= (mag > 255) ? 8'd255 : mag[7:0];
                pixel_out_valid <= 1'b1;
            end else begin
                pixel_out_valid <= 1'b0;
            end
        end else begin
            pixel_out_valid <= 1'b0;
        end
    end
endmodule
