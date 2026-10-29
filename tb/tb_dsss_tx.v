`timescale 1ns/1ps
module tb_dsss_tx;
reg clk=0;always #5 clk=~clk;
reg rst_n=0,start=0;reg [7:0] payload=8'hA5;reg [6:0] pn_seed=7'h01;
wire chip_valid,chip,busy,done;
dsss_tx dut(clk,rst_n,start,payload,pn_seed,chip_valid,chip,busy,done);
integer n=0;reg [6:0] refpn=7'h01;reg [6:0] prevpn;reg expected;
initial begin
 repeat(3) @(negedge clk);rst_n=1;
 @(negedge clk);start=1;
 @(negedge clk);start=0;
 wait(done); @(negedge clk);
 if(n!==1016) $fatal(1,"Expected 1016 chips, got %0d",n);
 $display("PASS DSSS 1016 chips");$finish;
end
always @(negedge clk) if(chip_valid) begin
 expected=payload[7-(n/127)] ^ refpn[0];
 if(chip!==expected) $fatal(1,"DSSS mismatch n=%0d",n);
 prevpn=refpn;
 refpn={prevpn[5:0],prevpn[6]^prevpn[5]};
 n=n+1;
end
initial begin #20000;$fatal(1,"timeout");end
endmodule
