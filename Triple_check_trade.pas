var
  mm9, mm21 : float;
  linhaVwap : float;
  valorRsi : float;
  cruzouCompra, cruzouVenda : boolean;
  cenarioFavoravelCompra, cenarioFavoravelVenda : boolean;
begin
  // --- 1. INDICADORES BÁSICOS ---
  mm9 := Media(9, Close);
  mm21 := Media(21, Close);
  linhaVwap := VWAP(1); 
  valorRsi := RSI(14, 0);

  // --- 2. GATILHOS (O EVENTO EXATO) ---
  // Verifica se o cruzamento acabou de acontecer no candle fechado [1]
  cruzouCompra := (mm9[1] > mm21[1]) and (mm9[2] <= mm21[2]);
  cruzouVenda  := (mm9[1] < mm21[1]) and (mm9[2] >= mm21[2]);

  // --- 3. FILTROS (O CENÁRIO ESTÁ ALINHADO?) ---
  // Garante que o cruzamento ocorreu do lado certo da VWAP e com momentum (RSI)
  cenarioFavoravelCompra := (Close[1] > linhaVwap[1]) and (valorRsi[1] > 50);
  cenarioFavoravelVenda  := (Close[1] < linhaVwap[1]) and (valorRsi[1] < 50);

  // --- 4. COLORINDO E ALERTANDO ---
  // Só vai disparar 1 única vez por movimento (no candle do cruzamento)
  if cruzouCompra and cenarioFavoravelCompra then
  begin
    PaintBar(clGreen);
    Alert(clGreen); 
  end
  else if cruzouVenda and cenarioFavoravelVenda then
  begin
    PaintBar(clRed);
    Alert(clRed); 
  end
  // Alerta de exaustão dinâmico (Mantido para avisar se o preço esticou demais)
  else if (valorRsi >= 80) or (valorRsi <= 20) then
  begin
    PaintBar(clYellow); 
  end;
end;