// Project 1: programmable DSSS/BPSK chip generator. Input data is one 8-bit payload.
// chip is a logical BPSK symbol (0 => +1, 1 => -1), not an analog RF waveform.
module dsss_tx (
 input wire clk, rst_n, start,
 input wire [7:0] payload,
 input wire [6:0] pn_seed,
 output reg chip_valid, output reg chip,
 output reg busy, output reg done
);
 reg [7:0] data_latched;
 reg [6:0] pn;
 reg [6:0] chip_index;
 reg [2:0] bit_index;
 wire feedback = pn[6] ^ pn[5]; // x^7+x^6+1, implementation convention noted in README
 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
   data_latched<=0; pn<=7'h01; chip_index<=0; bit_index<=0;
   chip_valid<=0; chip<=0; busy<=0; done<=0;
  end else begin
   chip_valid<=0; done<=0;
   if (!busy) begin
    if (start) begin
     data_latched<=payload; pn<= (pn_seed==0) ? 7'h01 : pn_seed;
     chip_index<=0; bit_index<=0; busy<=1;
    end
   end else begin
    chip <= data_latched[7-bit_index] ^ pn[0];
    chip_valid<=1;
    pn <= {pn[5:0],feedback};
    if (chip_index == 7'd126) begin
     chip_index<=0;
     if (bit_index==3'd7) begin busy<=0; done<=1; end
     else bit_index<=bit_index+1'b1;
    end else chip_index<=chip_index+1'b1;
   end
  end
 end
endmodule
