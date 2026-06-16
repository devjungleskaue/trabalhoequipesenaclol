/* =========================================================
   "Rising Crema" — vapor generativo subindo sobre o espresso.
   Sistema de partículas com flutuação acoplada à temperatura,
   campo de ruído Perlin em duas oitavas e decaimento por resfriamento.
   p5.js em modo instância, acoplado ao painel do pedido (#steam).
   Semente reproduzível: mesma seed => mesmo vapor.
   ========================================================= */
(function () {
  const SEED = 73; // a "xícara desta manhã"

  const sketch = (p) => {
    let particles = [];
    let W, H, host;
    let t = 0;

    // ---- partícula de vapor ----
    class Wisp {
      constructor() { this.reset(true); }

      reset(initial) {
        // emissão numa banda estreita perto da base — a "borda da xícara"
        this.x = W * (0.30 + p.random(0.40));
        this.y = H + p.random(0, initial ? H * 0.5 : 24);
        this.vx = p.random(-0.15, 0.15);
        this.vy = p.random(-0.9, -1.5);
        this.temp = p.random(0.75, 1.0);     // temperatura inicial (quente)
        this.life = 0;
        this.maxLife = p.random(180, 360);
        this.size = p.random(26, 64);
        this.drift = p.random(0.6, 1.4);     // sensibilidade ao vento
      }

      update() {
        // duas oitavas de ruído: balanço amplo + tremor fino
        const broad = p.noise(this.x * 0.0016, this.y * 0.0016, t * 0.12);
        const fine  = p.noise(this.x * 0.012,  this.y * 0.012,  t * 0.35 + 50);
        const angle = (broad * 0.7 + fine * 0.3) * p.TWO_PI * 1.4;
        const wind = p.cos(angle) * 0.05;

        // partículas quentes resistem ao vento e sobem com força; frias vagueiam
        this.vx += wind * this.drift * (1.2 - this.temp);
        this.vy += -0.012 * this.temp;          // empuxo proporcional à temperatura
        this.vx *= 0.97; this.vy *= 0.985;       // arrasto do ar

        this.x += this.vx;
        this.y += this.vy;

        this.temp *= 0.992;                      // resfriamento
        this.life++;

        if (this.life > this.maxLife || this.y < -this.size || this.temp < 0.12) {
          this.reset(false);
        }
      }

      draw() {
        const lifeRatio = this.life / this.maxLife;
        // surge, mantém, dissolve
        const fade = p.sin(lifeRatio * p.PI);
        const heightFade = p.constrain(this.y / H, 0, 1); // mais opaco embaixo
        const alpha = fade * heightFade * this.temp * 30;
        if (alpha < 0.5) return;

        // cor por temperatura: crema dourado quente -> creme -> névoa pálida
        const r = p.lerp(232, 255, 1 - this.temp);
        const g = p.lerp(208, 247, 1 - this.temp);
        const b = p.lerp(158, 235, 1 - this.temp);
        const s = this.size * (0.6 + lifeRatio * 0.9);

        p.noStroke();
        // núcleo suave em poucas camadas concêntricas (densidade acumulada)
        for (let k = 3; k >= 1; k--) {
          p.fill(r, g, b, alpha / (k * 1.6));
          p.ellipse(this.x, this.y, s * k * 0.7, s * k * 0.85);
        }
      }
    }

    function buildParticles() {
      p.randomSeed(SEED);
      p.noiseSeed(SEED);
      const count = p.constrain(Math.floor((W * H) / 5200), 60, 150);
      particles = Array.from({ length: count }, () => new Wisp());
    }

    function sizeToHost() {
      W = host.offsetWidth;
      H = host.offsetHeight;
    }

    p.setup = function () {
      host = document.getElementById("steam");
      if (!host) return;
      sizeToHost();
      const c = p.createCanvas(W, H);
      c.parent("steam");
      p.clear();
      buildParticles();
    };

    p.draw = function () {
      if (!host) return;
      p.clear(); // fundo transparente: deixa o gradiente espresso do CSS aparecer
      // brilho quente ancorando a base (a "poça de calor")
      p.noStroke();
      const glow = p.drawingContext.createRadialGradient(
        W / 2, H * 1.02, 10, W / 2, H * 1.02, H * 0.7
      );
      glow.addColorStop(0, "rgba(200,133,62,0.20)");
      glow.addColorStop(1, "rgba(200,133,62,0)");
      p.drawingContext.fillStyle = glow;
      p.rect(0, 0, W, H);

      p.drawingContext.globalCompositeOperation = "screen";
      for (const w of particles) { w.update(); w.draw(); }
      p.drawingContext.globalCompositeOperation = "source-over";

      t += 0.01;
    };

    p.windowResized = function () {
      if (!host) return;
      sizeToHost();
      p.resizeCanvas(W, H);
      buildParticles();
    };
  };

  // inicia quando o DOM estiver pronto
  function start() {
    if (document.getElementById("steam") && window.p5) {
      new p5(sketch);
    }
  }
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start);
  } else {
    start();
  }
})();
