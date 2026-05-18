var

mm9, mm21 : float;

linhaVwap : float;

valorRsi : float;

forcaCompra, forcaVenda : boolean;

begin

// --- 1. INDICADORES BÁSICOS ---

mm9 := Media(9, Close);

mm21 := Media(21, Close);

linhaVwap := VWAP(1); // O Muro Institucional

valorRsi := RSI(14, 0);

// --- 2. GATILHOS (MAIS SOLTOS E FLUIDOS) ---

// COMPRA: Acima da VWAP, MM9 virada pra cima da MM21, RSI saudável, e o candle atual fechou positivo.

forcaCompra := (Close > linhaVwap) and (mm9 > mm21) and (valorRsi < 70) and (Close > Open);

// VENDA: Abaixo da VWAP, MM9 virada pra baixo da MM21, RSI saudável, e o candle atual fechou negativo.

forcaVenda := (Close < linhaVwap) and (mm9 < mm21) and (valorRsi > 30) and (Close < Open);

// --- 3. COLORINDO E ALERTANDO ---

if forcaCompra then

begin

PaintBar(clGreen);

Alert(clGreen); // Dispara o popup verde no Gerenciador de Alarmes

end

else if forcaVenda then

begin

PaintBar(clRed);

Alert(clRed); // Dispara o popup vermelho no Gerenciador de Alarmes

end

// Alerta de exaustão extrema (Ajustado para 80/20 para diminuir o ruído)

else if (valorRsi >= 80) or (valorRsi <= 20) then

begin

PaintBar(clYellow); // Apenas pinta de amarelo na tela

end;

end;