/* =========================================================
   Café Aurora — PDV (lógica de front-end)
   Sem back-end: estado em memória + localStorage para o dia.
   ========================================================= */
(function () {
  "use strict";

  // ---------- estado ----------
  const order = new Map();        // id -> { product, qty }
  let activeCat = CATEGORIES[0].id;
  let searchTerm = "";
  let payMethod = null;

  // ---------- helpers ----------
  const $ = (s) => document.querySelector(s);
  const BRL = (n) =>
    n.toLocaleString("pt-BR", { style: "currency", currency: "BRL" });

  const todayKey = () => "aurora-" + new Date().toISOString().slice(0, 10);

  function loadDay() {
    try { return JSON.parse(localStorage.getItem(todayKey())) || { count: 0, total: 0, seq: 0 }; }
    catch { return { count: 0, total: 0, seq: 0 }; }
  }
  function saveDay(d) { localStorage.setItem(todayKey(), JSON.stringify(d)); }

  let day = loadDay();
  let orderSeq = day.seq + 1; // próximo número de pedido

  // ---------- elementos ----------
  const el = {
    categories: $("#categories"),
    grid: $("#productGrid"),
    catalogEmpty: $("#catalogEmpty"),
    search: $("#search"),
    items: $("#orderItems"),
    placeholder: $("#orderPlaceholder"),
    subtotal: $("#subtotal"),
    discount: $("#discount"),
    total: $("#total"),
    finalize: $("#finalize"),
    finalizeTotal: $("#finalizeTotal"),
    orderNumber: $("#orderNumber"),
    clearOrder: $("#clearOrder"),
    todayCount: $("#todayCount"),
    todayTotal: $("#todayTotal"),
    clock: $("#clock"),
    date: $("#date"),
    cashRow: $("#cashRow"),
    received: $("#received"),
    change: $("#change"),
    modal: $("#modal"),
    modalSub: $("#modalSub"),
    modalReceipt: $("#modalReceipt"),
    modalTotals: $("#modalTotals"),
    newSale: $("#newSale"),
  };

  const orderLabel = (n) => "#" + String(n).padStart(4, "0");

  // ---------- relógio + cabeçalho ----------
  function tick() {
    const now = new Date();
    el.clock.textContent = now.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
    el.date.textContent = now.toLocaleDateString("pt-BR", { day: "2-digit", month: "short" }).replace(".", "");
  }
  function refreshDayMeta() {
    el.todayCount.textContent = day.count;
    el.todayTotal.textContent = BRL(day.total);
  }

  // ---------- categorias ----------
  function renderCategories() {
    el.categories.innerHTML = "";
    CATEGORIES.forEach((c) => {
      const b = document.createElement("button");
      b.className = "chip" + (c.id === activeCat ? " is-active" : "");
      b.textContent = c.label;
      b.onclick = () => { activeCat = c.id; searchTerm = ""; el.search.value = ""; renderCategories(); renderProducts(); };
      el.categories.appendChild(b);
    });
  }

  // ---------- produtos ----------
  function visibleProducts() {
    const term = searchTerm.trim().toLowerCase();
    if (term) return PRODUCTS.filter((p) => (p.name + " " + p.desc).toLowerCase().includes(term));
    return PRODUCTS.filter((p) => p.cat === activeCat);
  }

  function renderProducts() {
    const list = visibleProducts();
    el.grid.innerHTML = "";
    el.catalogEmpty.hidden = list.length > 0;

    list.forEach((prod) => {
      const inOrder = order.get(prod.id);
      const card = document.createElement("button");
      card.className = "product" + (inOrder ? " in-order" : "");
      card.innerHTML = `
        <span class="product__qty-badge">${inOrder ? inOrder.qty : ""}</span>
        <span class="product__icon">${prod.icon}</span>
        <span class="product__name">${prod.name}</span>
        <span class="product__desc">${prod.desc}</span>
        <span class="product__foot">
          <span class="product__price">${BRL(prod.price)}</span>
          <span class="product__add" aria-hidden="true">+</span>
        </span>`;
      card.setAttribute("aria-label", `Adicionar ${prod.name}, ${BRL(prod.price)}`);
      card.onclick = () => addToOrder(prod);
      el.grid.appendChild(card);
    });
  }

  // ---------- pedido ----------
  function addToOrder(prod) {
    const entry = order.get(prod.id);
    if (entry) entry.qty++;
    else order.set(prod.id, { product: prod, qty: 1 });
    renderProducts();
    renderOrder();
  }
  function changeQty(id, delta) {
    const entry = order.get(id);
    if (!entry) return;
    entry.qty += delta;
    if (entry.qty <= 0) order.delete(id);
    renderProducts();
    renderOrder();
  }
  function removeItem(id) { order.delete(id); renderProducts(); renderOrder(); }

  function subtotal() {
    let s = 0;
    order.forEach((e) => (s += e.product.price * e.qty));
    return s;
  }
  function discountValue() {
    const d = parseFloat(el.discount.value);
    return isNaN(d) || d < 0 ? 0 : d;
  }
  function totalValue() {
    return Math.max(0, subtotal() - discountValue());
  }

  function renderOrder() {
    const hasItems = order.size > 0;
    el.placeholder.style.display = hasItems ? "none" : "flex";
    el.items.innerHTML = "";

    order.forEach((entry, id) => {
      const { product, qty } = entry;
      const li = document.createElement("li");
      li.className = "order-item";
      li.innerHTML = `
        <div>
          <div class="order-item__name">${product.name}</div>
          <div class="order-item__unit">${BRL(product.price)} / un</div>
        </div>
        <div class="order-item__price">${BRL(product.price * qty)}</div>
        <div class="order-item__controls">
          <button class="qty-btn" data-act="dec" aria-label="Diminuir">−</button>
          <span class="qty-num">${qty}</span>
          <button class="qty-btn" data-act="inc" aria-label="Aumentar">+</button>
        </div>
        <button class="order-item__remove" data-act="rm">remover</button>`;

      li.querySelector('[data-act="dec"]').onclick = () => changeQty(id, -1);
      li.querySelector('[data-act="inc"]').onclick = () => changeQty(id, +1);
      li.querySelector('[data-act="rm"]').onclick = () => removeItem(id);
      el.items.appendChild(li);
    });

    const sub = subtotal();
    const tot = totalValue();
    el.subtotal.textContent = BRL(sub);
    el.total.textContent = BRL(tot);
    el.finalizeTotal.textContent = BRL(tot);
    el.orderNumber.textContent = orderLabel(orderSeq);

    updateChange();
    updateFinalizeState();
  }

  // ---------- pagamento ----------
  function selectPayment(method, btn) {
    payMethod = method;
    document.querySelectorAll(".pay-btn").forEach((b) => b.classList.toggle("is-active", b === btn));
    el.cashRow.hidden = method !== "Dinheiro";
    updateChange();
    updateFinalizeState();
  }
  function updateChange() {
    const received = parseFloat(el.received.value);
    const troco = isNaN(received) ? 0 : received - totalValue();
    el.change.textContent = BRL(Math.max(0, troco));
    el.change.style.color = troco < 0 ? "var(--terracotta)" : "";
    if (troco < 0 && !isNaN(received)) el.change.textContent = "falta " + BRL(-troco);
  }
  function updateFinalizeState() {
    const ok = order.size > 0 && payMethod;
    el.finalize.disabled = !ok;
  }

  // ---------- finalizar ----------
  function finalize() {
    if (order.size === 0 || !payMethod) return;

    const sub = subtotal(), disc = discountValue(), tot = totalValue();

    // recibo no modal
    el.modalSub.textContent = `Pedido ${orderLabel(orderSeq)} · ${payMethod}`;
    el.modalReceipt.innerHTML = "";
    order.forEach((entry) => {
      const li = document.createElement("li");
      li.innerHTML = `
        <span><span class="r-qty">${entry.qty}×</span> ${entry.product.name}</span>
        <span class="r-price">${BRL(entry.product.price * entry.qty)}</span>`;
      el.modalReceipt.appendChild(li);
    });

    let totalsHTML = `<div class="mt-line"><span>Subtotal</span><span>${BRL(sub)}</span></div>`;
    if (disc > 0) totalsHTML += `<div class="mt-line"><span>Desconto</span><span>− ${BRL(disc)}</span></div>`;
    if (payMethod === "Dinheiro") {
      const rec = parseFloat(el.received.value);
      if (!isNaN(rec) && rec >= tot) {
        totalsHTML += `<div class="mt-line"><span>Recebido</span><span>${BRL(rec)}</span></div>`;
        totalsHTML += `<div class="mt-line"><span>Troco</span><span>${BRL(rec - tot)}</span></div>`;
      }
    }
    totalsHTML += `<div class="mt-line mt-line--total"><span>Total</span><span>${BRL(tot)}</span></div>`;
    el.modalTotals.innerHTML = totalsHTML;

    // registra no acumulado do dia
    day.count += 1;
    day.total += tot;
    day.seq = orderSeq;
    saveDay(day);
    refreshDayMeta();

    el.modal.hidden = false;
  }

  function newSale() {
    order.clear();
    payMethod = null;
    orderSeq += 1;
    el.discount.value = "0";
    el.received.value = "";
    el.cashRow.hidden = true;
    document.querySelectorAll(".pay-btn").forEach((b) => b.classList.remove("is-active"));
    el.modal.hidden = true;
    renderProducts();
    renderOrder();
  }

  function clearOrder() {
    if (order.size === 0) return;
    order.clear();
    payMethod = null;
    el.received.value = "";
    el.cashRow.hidden = true;
    document.querySelectorAll(".pay-btn").forEach((b) => b.classList.remove("is-active"));
    renderProducts();
    renderOrder();
  }

  // ---------- eventos ----------
  el.search.addEventListener("input", (e) => { searchTerm = e.target.value; renderProducts(); });
  el.discount.addEventListener("input", renderOrder);
  el.received.addEventListener("input", updateChange);
  el.clearOrder.addEventListener("click", clearOrder);
  el.finalize.addEventListener("click", finalize);
  el.newSale.addEventListener("click", newSale);
  document.querySelectorAll(".pay-btn").forEach((b) =>
    b.addEventListener("click", () => selectPayment(b.dataset.method, b))
  );
  el.modal.querySelector("[data-close]").addEventListener("click", () => (el.modal.hidden = true));
  document.addEventListener("keydown", (e) => { if (e.key === "Escape") el.modal.hidden = true; });

  // ---------- init ----------
  renderCategories();
  renderProducts();
  renderOrder();
  refreshDayMeta();
  tick();
  setInterval(tick, 1000 * 20);
})();
