module sr #(
    parameter   BIT     = 1,
                SHIFT   = 1
) (
    input               CLK,
    input               RST,
    input   [BIT-1:0]   din,
    output  [BIT-1:0]   dout
);

reg [BIT*SHIFT-1:0] mem;


always @(posedge CLK or posedge RST) begin
    if (RST) begin
        mem <= 0;
    end
    else begin
        mem <= {mem, din};
    end
end

assign dout = mem[BIT*SHIFT-1-:BIT];

endmodule
