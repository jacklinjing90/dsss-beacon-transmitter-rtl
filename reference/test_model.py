"""Standalone Python model check; does not simulate Verilog RTL."""
def pn_chips(payload=0xA5,seed=1):
    reg=seed or 1
    out=[]
    for bit_idx in range(8):
        bit=(payload>>(7-bit_idx))&1
        for _ in range(127):
            out.append(bit^(reg&1))
            reg=((reg<<1)&127)|(((reg>>6)^(reg>>5))&1)
    return out

def run():
    c=pn_chips()
    assert len(c)==1016 and set(c)=={0,1}
    print('PASS: Python DSSS reference')

if __name__=='__main__':run()
