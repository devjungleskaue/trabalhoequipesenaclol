/* =========================================================
   Cardápio da Café Aurora (dados de exemplo — front-end)
   ========================================================= */
const CATEGORIES = [
  { id: "quentes",  label: "Cafés Quentes" },
  { id: "gelados",  label: "Cafés Gelados" },
  { id: "doces",    label: "Doces" },
  { id: "salgados", label: "Salgados" },
  { id: "bebidas",  label: "Bebidas" },
];

const PRODUCTS = [
  // Cafés Quentes
  { id: 1,  name: "Espresso",        desc: "Dose curta, crema densa", price: 6.0,  cat: "quentes", icon: "☕" },
  { id: 2,  name: "Pingado",         desc: "Espresso com leite",      price: 7.0,  cat: "quentes", icon: "☕" },
  { id: 3,  name: "Cappuccino",      desc: "Espuma aveludada",        price: 11.0, cat: "quentes", icon: "☕" },
  { id: 4,  name: "Latte",           desc: "Leite vaporizado",        price: 12.0, cat: "quentes", icon: "🥛" },
  { id: 5,  name: "Flat White",      desc: "Microespuma sedosa",      price: 12.5, cat: "quentes", icon: "☕" },
  { id: 6,  name: "Mocha",           desc: "Chocolate & espresso",    price: 13.5, cat: "quentes", icon: "🍫" },
  { id: 7,  name: "Macchiato",       desc: "Marcado com leite",       price: 10.0, cat: "quentes", icon: "☕" },
  { id: 8,  name: "Café Coado",      desc: "Método filtrado V60",     price: 8.0,  cat: "quentes", icon: "☕" },

  // Cafés Gelados
  { id: 9,  name: "Cold Brew",       desc: "Extração a frio 18h",     price: 14.0, cat: "gelados", icon: "🧊" },
  { id: 10, name: "Latte Gelado",    desc: "Espresso & leite gelado", price: 13.0, cat: "gelados", icon: "🧊" },
  { id: 11, name: "Affogato",        desc: "Sorvete & espresso",      price: 15.0, cat: "gelados", icon: "🍨" },
  { id: 12, name: "Frappê de Café",  desc: "Batido cremoso",          price: 16.0, cat: "gelados", icon: "🥤" },
  { id: 13, name: "Iced Mocha",      desc: "Choco gelado",            price: 15.5, cat: "gelados", icon: "🧊" },

  // Doces
  { id: 14, name: "Brownie",         desc: "Chocolate 70%",           price: 9.0,  cat: "doces", icon: "🍫" },
  { id: 15, name: "Cookie",          desc: "Gotas de chocolate",      price: 7.0,  cat: "doces", icon: "🍪" },
  { id: 16, name: "Cheesecake",      desc: "Calda de frutas",         price: 14.0, cat: "doces", icon: "🍰" },
  { id: 17, name: "Bolo de Cenoura", desc: "Cobertura de choco",      price: 10.0, cat: "doces", icon: "🍰" },
  { id: 18, name: "Croissant Choco", desc: "Recheado",                price: 11.0, cat: "doces", icon: "🥐" },
  { id: 19, name: "Pão de Mel",      desc: "Coberto de chocolate",    price: 8.0,  cat: "doces", icon: "🍯" },

  // Salgados
  { id: 20, name: "Pão de Queijo",   desc: "Porção com 4",            price: 6.0,  cat: "salgados", icon: "🧀" },
  { id: 21, name: "Croissant",       desc: "Manteiga francesa",       price: 9.0,  cat: "salgados", icon: "🥐" },
  { id: 22, name: "Quiche",          desc: "Alho-poró",               price: 13.0, cat: "salgados", icon: "🥧" },
  { id: 23, name: "Sanduíche Nat.",  desc: "Frango & ricota",         price: 16.0, cat: "salgados", icon: "🥪" },
  { id: 24, name: "Misto Quente",    desc: "Presunto & queijo",       price: 12.0, cat: "salgados", icon: "🥪" },

  // Bebidas
  { id: 25, name: "Chá Gelado",      desc: "Limão siciliano",         price: 9.0,  cat: "bebidas", icon: "🧉" },
  { id: 26, name: "Chocolate Quente",desc: "Meio amargo",             price: 12.0, cat: "bebidas", icon: "🍫" },
  { id: 27, name: "Suco Natural",    desc: "Laranja / abacaxi",       price: 11.0, cat: "bebidas", icon: "🍊" },
  { id: 28, name: "Matchá Latte",    desc: "Cerimonial",              price: 15.0, cat: "bebidas", icon: "🍵" },
  { id: 29, name: "Água",            desc: "Com / sem gás",           price: 5.0,  cat: "bebidas", icon: "💧" },
];
