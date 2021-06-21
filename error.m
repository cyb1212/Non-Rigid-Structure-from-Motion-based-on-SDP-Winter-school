Error using cellfun
Non-scalar in Uniform output, at index 14, output 1.
Set 'UniformOutput' to false.

Error in cvx_pop (line 29)
s2 = cellfun( @cvx_id, s2 );

Error in cvx_end (line 15)
        evalin( 'caller', 'cvx_pop' );

Error in NrSfM_cvx_sdp (line 38)
cvx_end

Error in nsfm_sdp (line 29)
[mu] = NrSfM_cvx_sdp(IDX,x2d,cos_value);

Error in main (line 40)
rec_tlmdh=nsfm_sdp(data,options.tlmdh);
 