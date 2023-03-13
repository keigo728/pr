function phs = principalPhase( data )
% ーπ≦θ≦＋πの範囲の位相に直す（主値にする）

phs = angle( exp(i*data) );
