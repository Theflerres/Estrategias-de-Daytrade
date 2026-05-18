var
  ema3, ema8 : float;
  linhaVwap : float;
  gatilhoCompra, gatilhoVenda : boolean;
  cenarioCompra, cenarioVenda : boolean;

begin
  // =========================================================================
  // BLOCO 1: INDICADORES SUPER RÁPIDOS (Foco em Aceleração)
  // =========================================================================
  ema3 := MediaExp(3, Close);
  ema8 := MediaExp(8, Close);
  linhaVwap := VWAP(1);

  // =========================================================================
  // BLOCO 2: GATILHOS E FILTROS (O Tiro Rápido)
  // =========================================================================
  
  // O cruzamento precisa ser no candle atual, com o corpo confirmando a força
  gatilhoCompra := (ema3 > ema8) and (ema3[1] <= ema8[1]) and (Close > Open);
  gatilhoVenda  := (ema3 < ema8) and (ema3[1] >= ema8[1]) and (Close < Open);

  // O filtro de cenário é apenas a VWAP. Retiramos o RSI para não atrasar o sinal.
  cenarioCompra := (Close > linhaVwap);
  cenarioVenda  := (Close < linhaVwap);

  // =========================================================================
  // BLOCO 3: EXECUÇÃO VISUAL E SONORA
  // =========================================================================
  
  if gatilhoCompra and cenarioCompra then
  begin
    PaintBar(clAqua); // clAqua é o Ciano/Azul Claro no NTSL
    Alert(clAqua);
  end
  else if gatilhoVenda and cenarioVenda then
  begin
    PaintBar(clFuchsia); // clFuchsia é o Magenta/Rosa no NTSL
    Alert(clFuchsia);
  end;

end;