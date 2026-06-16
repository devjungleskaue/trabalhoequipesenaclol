# Café Aurora — PDV (Front-end)

Front-end de um **Ponto de Venda (PDV)** para cafeteria. Somente interface — **sem back-end**.
Estado da venda em memória; acumulado do dia (vendas/faturamento/número do pedido) em `localStorage`.

## Como rodar

É um site estático. Basta servir a pasta:

```bash
npx http-server . -p 4173 -c-1
# abra http://localhost:4173
```

Ou simplesmente abra `index.html` no navegador (o fundo de vapor usa p5.js via CDN, então requer internet).

## Funcionalidades

- **Catálogo** por categorias (Cafés Quentes, Gelados, Doces, Salgados, Bebidas) + busca.
- **Pedido**: adicionar itens, ajustar quantidade, remover, subtotal, desconto em R$ e total.
- **Pagamento**: Dinheiro (com cálculo de troco), Cartão e PIX.
- **Finalização**: modal de recibo, contador de vendas e faturamento do dia.

## Estrutura

```
front-end/
├── index.html              # marcação do PDV
├── css/styles.css          # estética "Slow Extraction"
├── js/
│   ├── data.js             # cardápio (dados de exemplo)
│   ├── steam.js            # fundo generativo p5.js "Rising Crema"
│   └── app.js              # lógica do PDV
├── DESIGN-PHILOSOPHY.md     # filosofia visual (skill canvas-design)
└── ALGORITHMIC-PHILOSOPHY.md# filosofia generativa (skill algorithmic-art)
```

## Conceito visual

- **Slow Extraction** — calor renderizado com precisão: paleta de espresso/crema/caramelo,
  tipografia fina (Inter) com numerais serifados tabulares (Fraunces), cantos suaves e
  motivo de anéis concêntricos (a xícara).
- **Rising Crema** — o painel de pedido tem um fundo animado de vapor subindo, um sistema
  de partículas p5.js com flutuação acoplada à temperatura e ruído Perlin em duas oitavas.

Referências de base pesquisadas: dashboards de POS para cafeterias no Dribbble
(*Green Grounds Coffee*, *Cuppa POS*), kits CloudPos/Figma e sistemas BR como ControleNaMão.
