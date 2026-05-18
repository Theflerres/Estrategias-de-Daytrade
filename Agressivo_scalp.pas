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
  
  // O cruzamento precisa ser no candle atual, com o corpo do candle confirmando a força
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
    PaintBar(clCyan); // Azul claro para scalp de compra
    Alert(clCyan);
  end
  else if gatilhoVenda and cenarioVenda then
  begin
    PaintBar(clMagenta); // Magenta para scalp de venda
    Alert(clMagenta);
  end;

end;